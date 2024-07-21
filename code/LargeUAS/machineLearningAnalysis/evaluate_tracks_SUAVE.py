
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
import time
import multiprocessing as mp
from multiprocessing import Process, Lock
from functools import partial
import concurrent.futures
from joblib import Parallel, delayed
# import pathos


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
            #vehicle_types = [Solar_UAV]
        else:
            vehicle_types = [Tiltwing, Stopped_Rotor, Solar_UAV, Electric_Multicopter]
  
        # partial_func = partial(vehicleAnalysisInstance.full_setup)
        args_set = []
        
        for vehicle_type in vehicle_types: 
           vehicle = setup_vehicle(vehicle_type)
           args_set.append((vehicle, vehicle_type, tj))
           

        # Parallalization using Joblib library
        n_jobs = 8 #max(int(mp.cpu_count()/2), 1)     
        feasibility_result = Parallel(n_jobs=n_jobs, verbose=10)(delayed(run_full_setup)(args) for args in args_set) # Execute the function calls in parallel
        #feasibility_result = run_full_setup(args_set[0])
        


         ################ THIS IS THE RESULT BEING FED BACK TO THE MATLAB SCRIPT ###############
        #         ####### DO NOT EDIT THIS PRINT STATEMENT AFTER THIS POINT IN THE CODE ##########
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

        
        #######Temporary#####
        #feasibility_report= {'Electric_Multicopter': False, 'Tiltwing': False, 'Stopped_Rotor': False, 'Solar_UAV': feasibility_result} 

            #############
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

def run_full_setup(args):
    vehicleAnalysisInstance = VehicleAnalysis()
    feasbility=  vehicleAnalysisInstance.full_setup(*args)
    return feasbility



if __name__ == '__main__':  
    main(0)

