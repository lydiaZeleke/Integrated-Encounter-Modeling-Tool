
# -*- coding: utf-8 -*-
"""
Created on Wednesday June  14 12:15:09 2021

@author: Lydia Zeleke
"""

# ----------------------------------------------------------------------
#   Imports
# ----------------------------------------------------------------------
import sys
import os
import pandas as pd
import json
import torch
import multiprocessing as mp
from multiprocessing import Process, Lock
from functools import partial
import concurrent.futures
from joblib import Parallel, delayed
import pathos


sys.path.append(os.path.join(os.getcwd(), 'SUAVE_lib', 'trunk'))
import SUAVE
from SUAVE.Core import Units , Data
from VehicleAnalysis import VehicleAnalysis

# The vehicles
sys.path.append(os.path.join(os.getcwd(), 'library', 'SUAVE_lib', 'regression', 'scripts', 'Vehicles'))

import Tiltwing
import Stopped_Rotor
import Electric_Multicopter 
import Solar_UAV


# ----------------------------------------------------------------------
#   Main
# ----------------------------------------------------------------------

def main(lock):
   
    try:

        json_file_path = os.path.join(os.path.dirname(__file__), 'bayes_manned_track.json')
        with open(json_file_path, 'r') as f:
            trajectory_metadata = json.load(f)
        tj = trajectory_metadata['trajectory_data']  
        tj = resample_track(tj)
        aircraft_class = trajectory_metadata['aircraft_class']

        if aircraft_class.lower() == 'rotorcraft':
            vehicle_types = [Tiltwing, Stopped_Rotor, Electric_Multicopter] 
        elif aircraft_class.lower() == 'fixed-wing':
            vehicle_types = [Tiltwing, Stopped_Rotor, Solar_UAV]
        else:
            vehicle_types = [Tiltwing, Stopped_Rotor, Solar_UAV, Electric_Multicopter]
  
 
        # partial_func = partial(vehicleAnalysisInstance.full_setup)
        args_set = []
        
        for vehicle_type in vehicle_types: 
           vehicle = setup_vehicle(vehicle_type)
           args_set.append((vehicle, vehicle_type, tj))
        
        #feasibility_result = run_full_setup_cpu(args_set[2])
           
        if torch.cuda.is_available():
            # Code to execute if GPUs are available
            n_gpus = torch.cuda.device_count()
            print(f"Running on {n_gpus} GPUs.")
            
            # Assuming args_set is a list of arguments for each task
            feasibility_result = Parallel(n_jobs=n_gpus)(delayed(run_full_setup_gpu)(args, i % n_gpus) for i, args in enumerate(args_set))
        else:
            # Code to execute if GPUs are not available (use CPU instead)
            print("GPUs not available. Running on CPU.")
            n_jobs = 8  # Number of parallel jobs for CPU
            feasibility_result = Parallel(n_jobs=n_jobs)(delayed(run_full_setup_gpu)(args) for args in args_set)

         ################ THIS IS THE RESULT BEING FED BACK TO THE MATLAB SCRIPT ###############
                ####### DO NOT EDIT THIS PRINT STATEMENT AFTER THIS POINT IN THE CODE ##########
        # feasibility_report = {"Tiltwing": False, "Stopped_Rotor": False, 'Electric_Multicopter': False, 'Solar_UAV': feasibility_result}
        feasibility_report = {"Tiltwing": feasibility_result[0], "Stopped_Rotor": feasibility_result[1]}
        if aircraft_class.lower()=='rotorcraft':
           feasibility_report['Solar_UAV'] = False
           feasibility_report['Electric_Multicopter']= feasibility_result[2]

        elif aircraft_class.lower()=='fixed-wing':
           feasibility_report['Electric_Multicopter']= False
           feasibility_report['Solar_UAV']= feasibility_result[2]
        else:
            feasibility_report['Electric_Multicopter']= feasibility_result[3] 
            feasibility_report['Solar_UAV']= feasibility_result[2] 

      
        marker = '***'
        print('Feasibility Report: ', feasibility_report, marker)
        
    except Exception as error:
        print("Analysis ran into an Error - Error Description: ", str(error))


def setup_vehicle(Vehicle):
    # vehicle data
    vehicle  = Vehicle.vehicle_setup()

    return vehicle


def resample_track(tj):
    tj = pd.DataFrame(tj)
    tj['Time'] = tj['Time'].str.replace(' sec', '').astype(float)
    tj = tj[tj['Time'].apply(lambda x: x.is_integer())] # from 0.1 second to 1 second
    tj = tj.reset_index(drop=True)
    return tj

def run_full_setup_gpu(args,gpu_id):
    with torch.cuda.device(gpu_id):
        vehicleAnalysisInstance = VehicleAnalysis()
        feasbility=  vehicleAnalysisInstance.full_setup(*args)
        return feasbility

def run_full_setup_cpu(args):
    vehicleAnalysisInstance = VehicleAnalysis()
    feasbility=  vehicleAnalysisInstance.full_setup(*args)
    return feasbility


if __name__ == '__main__':  
    main(0)

