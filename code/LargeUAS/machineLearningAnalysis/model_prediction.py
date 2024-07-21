
# Import Libraries
import pandas as pd
import numpy as np
from sklearn.preprocessing import MinMaxScaler, OneHotEncoder
from sklearn.model_selection import train_test_split
import os
import json
import joblib
from joblib import load, dump
import ruptures as rpt
from multiprocessing import Lock
from joblib import Parallel, delayed
import tensorflow as tf
from tensorflow.keras.models import load_model

os.environ['CUDA_VISIBLE_DEVICES'] = '-1'

def main(lock):

  try:
    
    TIMESTEP = 64
    json_file_path = os.path.join(os.path.dirname(__file__), 'bayes_manned_track.json')

    with open(json_file_path, 'r') as f:
        trajectory_metadata = json.load(f)
    tj = trajectory_metadata['trajectory_data']  
    tj = resample_track(tj)
    aircraft_class = trajectory_metadata['aircraft_class']

    if aircraft_class.lower() == 'rotorcraft':
        vehicle_types = ['tiltwing', 'lift_cruise_crm', 'multicopter'] 
    elif aircraft_class.lower() == 'fixed-wing':
        vehicle_types = ['tiltwing', 'lift_cruise_crm', 'solar']
    else:
        vehicle_types = ['tiltwing', 'lift_cruise_crm', 'solar', 'multicopter']


    all_vehicle_classes = ['tiltwing', 'lift_cruise_crm', 'solar', 'multicopter']
    #####################

    scaler = MinMaxScaler(feature_range=(0, 1)) # Adjust the range according to your data
    encoder = OneHotEncoder(sparse= False)

    engineered_tj, encoder = preprocess_file_per_segment(tj, all_vehicle_classes, encoder)

    # Load the model
    path_to_model = os.path.join(os.path.dirname(__file__), 'model', 'Feasibility_Prediction_Model', 'random_forest_model.joblib')
    model = load(path_to_model)
    
    args_set = []
    for vehicle_type in vehicle_types: #replace with ----> vehicle_types: 
        args_set.append((engineered_tj, model, vehicle_type, encoder))

    # Code to execute if GPUs are not available (use CPU instead)
    print("GPUs not available. Running on CPU.")
    n_jobs = 8  # Number of parallel jobs for CPU
    predicted_feasibility = Parallel(n_jobs=n_jobs)(delayed(run_full_setup_cpu)(args) for args in args_set)

        ################ THIS IS THE RESULT BEING FED BACK TO THE MATLAB SCRIPT ###############
         ################ THIS IS THE RESULT BEING FED BACK TO THE MATLAB SCRIPT ###############
                ####### DO NOT EDIT THIS PRINT STATEMENT AFTER THIS POINT IN THE CODE ##########
        # feasibility_report = {"Tiltwing": False, "Stopped_Rotor": False, 'Electric_Multicopter': False, 'Solar_UAV': predicted_feasibility}
    feasibility_report = {"Tiltwing": predicted_feasibility[0], "Stopped_Rotor": predicted_feasibility[1]}
    if aircraft_class.lower()=='rotorcraft':
        feasibility_report['Solar_UAV'] = False
        feasibility_report['Electric_Multicopter']= predicted_feasibility[2]

    elif aircraft_class.lower()=='fixed-wing':
        feasibility_report['Electric_Multicopter']= False
        feasibility_report['Solar_UAV']= predicted_feasibility[2]
    else:
        feasibility_report['Electric_Multicopter']= predicted_feasibility[3] 
        feasibility_report['Solar_UAV']= predicted_feasibility[2] 

    
    marker = '***'
    print('Feasibility Report: ', feasibility_report, marker)
            
  except Exception as error:
    print("Analysis ran into an Error - Error Description: ", str(error))  

def trajectory_cruise_segmentation(track):

        # Load your data
        data = track

        # Define the signals that you are interested in
        
        speed = data['speed_ft_s'].values
        altitude = data['alt_ft_agl'].values


        # Standardize the variables to have zero mean and unit variance
        epsilon = 1e-8
        speed = (speed - np.mean(speed)) / (np.std(speed) + epsilon)  #Epsilon helps prevent division by zero cases

        #speed = (speed - np.mean(speed)) / np.std(speed)
        altitude = (altitude - np.mean(altitude)) / np.std(altitude)

        # Create a composite signal
        composite_signal = np.sqrt(speed**2 + altitude**2)

        # Define algorithm configuration
        algo = rpt.Pelt(model="rbf").fit(composite_signal)

        # Detection
        result = algo.predict(pen=3)  # You might need to adjust the penalty value

        # Create a new column 'segment' and set it initially to 0
        data['segment'] = 0
        boundaries = [(0, result[0])]
        data.loc[0:result[0], 'segment'] = 0
        
        # Loop over the result to assign each segment a unique ID
        for i, val in enumerate(result[:-1]):            
            if i == len(result)-2:
                boundaries.append((val, result[i+1]-1))
            else:
                boundaries.append((val, result[i+1]))
            data.loc[val:result[i+1], 'segment'] = i+1
            

        return boundaries, data
        
def predict_traj_feasibility(trajectory_input, model, vehicle_type, encoder):
    vehicle_type_encoded = encoder.transform(np.array([vehicle_type]).reshape(-1, 1))
    seq_vehicle_encoded = np.tile(vehicle_type_encoded, (len(trajectory_input), 1))
    tiled_trajectory= np.concatenate([trajectory_input, seq_vehicle_encoded], axis=1)
    predictions = [model.predict(np.array([row_segment])) for row_segment in tiled_trajectory]
    boolean_predictions = [True if pred == 1 else False for pred in predictions]
    
    # Determine trajectory feasibility
    # The trajectory is deemed infeasible if any segment is infeasible (False)
    is_trajectory_feasible = all(boolean_predictions)
    
    return is_trajectory_feasible


def preprocess_file_per_segment(trajectory_data, all_vehicle_classes, encoder):


    boundary, trajectory = trajectory_cruise_segmentation(trajectory_data)
    
    segment_count = trajectory['segment'].nunique()  # Count unique segments
    
    # Apply Feature Engineering
    engineered_trajectory = trajectory.groupby('segment').apply(lambda x: process_segment(x)).reset_index(drop=True)

    
    unique_vehicle_types = np.unique(all_vehicle_classes)
    encoder.fit(unique_vehicle_types.reshape(-1, 1))

    return engineered_trajectory, encoder

def process_segment(group):
    # Ensure the group is sorted by Time
    group = group.sort_values(by='Time')

    # Calculate time difference
    time_elapsed = group['Time'].iloc[-1] - group['Time'].iloc[0]
    
    airspeed_value = group['speed_ft_s'].mean()
    # Calculate distance
    distance = airspeed_value * time_elapsed

    # Calculate altitude

    altitude = group['alt_ft_msl'].mean() #(group['alt_ft_msl'].iloc[-1] + group['alt_ft_msl'].iloc[0])/2


    return pd.Series({'distance': distance, 'airspeed': airspeed_value, 'altitude': altitude})

def resample_track(tj):
    tj = pd.DataFrame(tj)
    tj['Time'] = tj['Time'].str.replace(' sec', '').astype(float)
    tj = tj[tj['Time'].apply(lambda x: x.is_integer())] # from 0.1 second to 1 second
    tj = tj.reset_index(drop=True)
    return tj 


def run_full_setup_cpu(args):
    feasbility = predict_traj_feasibility(*args)
    return feasbility

if __name__ == '__main__':
    lock = Lock()  # If you need to use a lock, it should be created in the if __name__ == '__main__' guard
    main(lock)