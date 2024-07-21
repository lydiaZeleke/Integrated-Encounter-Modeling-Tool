import sys
import os
import numpy as np
import pandas as pd
import time
import ruptures as rpt

sys.path.append(os.path.join(os.path.dirname(__file__), 'SUAVE_lib', 'trunk'))
import SUAVE
from SUAVE.Core import Units , Data
from SUAVE.Plots.Performance.Mission_Plots import *
from SUAVE.Plots.Geometry import *


class VehicleAnalysis():

    current_dir = os.getcwd()

    # Build the path to the 'logs/track_feasibility' directory
    feasibility_path = os.path.join(current_dir, 'logs', 'feasibility_data')
    dynamics_path = os.path.join(current_dir, 'logs', 'dynamics')
    # ----------------------------------------------------------------------
    #   Setup
    # ----------------------------------------------------------------------
    def full_setup(cls, vehicle, vehicle_type, tj):  
            # build the vehicle, configs, and analyses
        track = tj
        
        configs, analyses = cls.delegate_setup(vehicle, vehicle_type, tj)
        configs.finalize()
        analyses.finalize() 
        vehicle_tag = vehicle.tag.lower()


            # evaluate mission
        mission   = analyses.missions.base
        results   = mission.evaluate()
        feasibility_test = cls.check_profile_feasibility(results, vehicle_tag, track)
        
        #print('Feasibility Test with ', vehicle.tag, feasibility_test)
        return feasibility_test 
    

    def delegate_setup(cls, vehicle, vehicle_type, tj): 

        #print('Vehicle Type: ', vehicle.tag)
        final_analyses = SUAVE.Analyses.Analysis.Container()

        # configs setup
        configs  = vehicle_type.configs_setup(vehicle) if  vehicle.tag.lower() != 'multicopter' else cls.multicoptor_configs_setup(vehicle)

        # vehicle analyses
        configs_analyses = cls.analyses_setup(configs, vehicle.tag)

        # mission analyses
        mission           = cls.mission_setup(configs_analyses, vehicle, tj)
        missions_analyses = cls.missions_setup(mission)

        final_analyses.configs  = configs_analyses
        final_analyses.missions = missions_analyses

        return configs, final_analyses
    

    def analyses_setup(cls, configs, vehicle_type):
        analyses = SUAVE.Analyses.Analysis.Container()
    
        # build a base analysis for each config
        for tag,config in configs.items():
            analysis = cls.base_analysis(config, vehicle_type.lower())
            analyses[tag] = analysis

        return analyses

    
    def base_analysis(cls, vehicle, vehicle_type):

        # ------------------------------------------------------------------
        #   Initialize the Analyses
        # ------------------------------------------------------------------     
        analyses = SUAVE.Analyses.Vehicle()

        # ------------------------------------------------------------------
        #  Basic Geometry Relations
        sizing = SUAVE.Analyses.Sizing.Sizing()
        sizing.features.vehicle = vehicle
        analyses.append(sizing)

        # ------------------------------------------------------------------
        #  Weights
        
        if vehicle_type == 'solar':
            weights = SUAVE.Analyses.Weights.Weights_UAV()
            weights.settings.empty = SUAVE.Methods.Weights.Correlations.Human_Powered.empty
        else:
            weights = SUAVE.Analyses.Weights.Weights_eVTOL()
        weights.vehicle = vehicle
        analyses.append(weights)

        # ------------------------------------------------------------------
        #  Aerodynamics Analysis
        aerodynamics = SUAVE.Analyses.Aerodynamics.Fidelity_Zero()
        aerodynamics.geometry                = vehicle 
        if vehicle_type == 'tiltwing':
            aerodynamics.settings.model_fuselage = True
        elif vehicle_type == 'solar':
            aerodynamics.settings.drag_coefficient_increment = 0.0000

        if vehicle_type not in ['solar', 'multicopter']:
            aerodynamics.settings.drag_coefficient_increment = 0.4*vehicle.excrescence_area_spin / vehicle.reference_area
        analyses.append(aerodynamics)

        # ------------------------------------------------------------------
        #  Energy
        energy= SUAVE.Analyses.Energy.Energy()
        energy.network = vehicle.networks 
        analyses.append(energy)

        # ------------------------------------------------------------------
        #  Planet Analysis
        planet = SUAVE.Analyses.Planets.Planet()
        analyses.append(planet)

        # ------------------------------------------------------------------
        #  Atmosphere Analysis
        atmosphere = SUAVE.Analyses.Atmospheric.US_Standard_1976()
        atmosphere.features.planet = planet.features
        analyses.append(atmosphere)   

        return analyses    

    
    def mission_setup(cls, analyses,vehicle,tj):

        segment_type = []
        climb_rate = []
        descend_rate = []
        start_altitude = []
        end_altitude = []
        climb_angle = []
        descent_angle = []
        speed_spec = []
        time_required = []
            
        tag= vehicle.tag.lower()
        # ------------------------------------------------------------------
        #   Initialize the Mission
        # ------------------------------------------------------------------

        mission     = SUAVE.Analyses.Mission.Sequential_Segments()
        mission.tag = 'the_mission'

        # airport
        airport            = SUAVE.Attributes.Airports.Airport()
        airport.altitude   =  0.0  * Units.ft
        airport.delta_isa  =  0.0
        airport.atmosphere = SUAVE.Attributes.Atmospheres.Earth.US_Standard_1976()

        mission.airport = airport    

        # unpack Segments module
        Segments = SUAVE.Analyses.Mission.Segments

        # base segment
        base_segment                                             = Segments.Segment()
        base_segment.state.numerics.number_control_points        = 8
        ones_row                                                 = base_segment.state.ones_row 
        base_segment.process.initialize.initialize_battery       = SUAVE.Methods.Missions.Segments.Common.Energy.initialize_battery
        base_segment.process.iterate.conditions.planet_position  = SUAVE.Methods.skip
    

        # VSTALL Calculation
        m      = vehicle.mass_properties.max_takeoff
        g      = 9.81
        S      = vehicle.reference_area
        atmo   = SUAVE.Analyses.Atmospheric.US_Standard_1976()
        rho    = atmo.compute_values(tj.alt_ft_msl[0] * Units.feet,0.).density
        CLmax  = 1.2
        Vstall = float(np.sqrt(2.*m*g/(rho*S*CLmax)))

        # if tag != "solar":
        #     # # ------------------------------------------------------------------
        #     #   First Climb Segment: Constant Speed, Constant Rate
        #     # ------------------------------------------------------------------ 
        #     segment                                            = Segments.Hover.Climb(base_segment)
        #     segment.tag                                        = "Hover" 
        #     segment.altitude_start                             = 0.0  * Units.ft
        #     segment.altitude_end                               = 40.  * Units.ft
        #     segment.climb_rate                                 = 300. * Units['ft/min']
        #     segment.process.iterate.conditions.stability       = SUAVE.Methods.skip
        #     segment.process.finalize.post_process.stability    = SUAVE.Methods.skip
        #     segment.state.unknowns.throttle = 1.0 * ones_row(1)

        #     if tag in ['tiltwing', 'multicopter']:
        #         segment.analyses.extend(analyses.hover_climb) if vehicle.tag.lower() == 'tiltwing' else segment.analyses.extend(analyses.base)
        #         segment.battery_energy =  vehicle.networks.battery_propeller.battery.max_energy
            
        #         segment = vehicle.networks.battery_propeller.add_unknowns_and_residuals_to_segment(segment,\
        #                                                                                         initial_power_coefficient = 0.06) 
        #     elif tag == 'lift_cruise_crm': 
        #         segment.analyses.extend(analyses.base)
        #         segment.battery_energy = vehicle.networks.lift_cruise.battery.max_energy
        #         segment.process.iterate.unknowns.mission  = SUAVE.Methods.skip
        #         segment =  vehicle.networks.lift_cruise.add_lift_unknowns_and_residuals_to_segment(segment,\
        #                                                                                 initial_lift_rotor_power_coefficient = 0.01,
        #                                                                                 initial_throttle_lift = 0.9)

        #     elif tag == 'solar':    
        #         segment.battery_energy = vehicle.networks.solar.battery.max_energy
        #         segment = vehicle.networks.solar.add_unknowns_and_residuals_to_segment(segment,initial_power_coefficient = 0.05) 

        #     # add to misison
        #     mission.append_segment(segment) 

        #     segment_type.append(segment.tag)
        #     climb_rate.append(segment.climb_rate )
        #     descend_rate.append(np.nan)
        #     start_altitude.append(segment.altitude_start)
        #     end_altitude.append(segment.altitude_end)
        #     climb_angle.append(np.nan)
        #     descent_angle.append(np.nan)
        #     speed_spec.append(np.nan)
        #     time_required.append(np.nan)
            
        #     # # ------------------------------------------------------------------
        #     # #   Accelerated Climb
        #     # # ------------------------------------------------------------------
        
        #     segment                                            = Segments.Climb.Constant_Speed_Constant_Rate(base_segment)
        #     segment.tag                                        = "accel_climb"
        #     segment.air_speed                                  = cls.get_random_num(0.95, 1.2)*Vstall * Units['ft']
        #     segment.altitude_start                             = 40.0 * Units.ft
        #     segment.altitude_end                               = tj.alt_ft_msl[0] * Units.ft
        #     segment.climb_rate                                 = 500. * Units['ft/min'] 
        #     segment.state.unknowns.throttle                    =  0.90 * ones_row(1)
            
        #     if tag in ['tiltwing', 'multicopter']:
        #         segment.analyses.extend(analyses.cruise)
        #         segment = vehicle.networks.battery_propeller.add_unknowns_and_residuals_to_segment(segment,initial_power_coefficient = 0.03) 
        #     elif vehicle.tag.lower() == 'lift_cruise_crm':  
        #         segment.analyses.extend(analyses.base)
        #         segment = vehicle.networks.lift_cruise.add_cruise_unknowns_and_residuals_to_segment(segment)  
        #     elif tag == 'solar': 
               
        #         segment = vehicle.networks.solar.add_unknowns_and_residuals_to_segment(segment,initial_power_coefficient = 0.05) 


        #     # add to misison
        #     mission.append_segment(segment)

        #     segment_type.append(segment.tag)
        #     climb_rate.append(segment.climb_rate )
        #     descend_rate.append(np.nan)
        #     start_altitude.append(segment.altitude_start)
        #     end_altitude.append(segment.altitude_end)
        #     climb_angle.append(np.nan)
        #     descent_angle.append(np.nan)
        #     speed_spec.append(segment.air_speed)
        #     time_required.append(np.nan)

        ################-------------- Track Data As Cruise -----------################
        total_t = 0
        speed = 0

        [boundaries, segmented_tracks] = cls.trajectory_cruise_segmentation(tj)
        # Compute the boundaries for each segment

        # Print the boundaries
        for i, (start, end) in enumerate(boundaries):
            # #print(f"Segment {i}: Start={start}, End={end}")
            timelapsed =  int(tj.Time[end] - tj.Time[start]) 
            speed = tj.speed_ft_s[start:end].mean() #tj.speed_ft_s[start+1]
            # ------------------------------------------------------------------
            #   Cruise
            # ------------------------------------------------------------------  
            segment                                            = Segments.Cruise.Constant_Speed_Constant_Altitude(base_segment)
            segment.tag                                        = "cruise_"+str(i)
            segment.altitude                                   =tj.alt_ft_msl[start:end].mean()* Units.feet #(tj.alt_ft_msl[start] + tj.alt_ft_msl[end])/2 * Units.ft # Absolute altitude or altitude Mean Sea Level
            segment.air_speed                                  = speed * Units['ft/s'] #110.   * Units['mph']
            segment.distance                                   = timelapsed * speed * Units['ft'] #50.    * Units.miles   
            segment.state.unknowns.throttle                    = 0.7 * ones_row(1) 
            segment.process.iterate.conditions.stability       = SUAVE.Methods.skip
            segment.process.finalize.post_process.stability    = SUAVE.Methods.skip
            print(timelapsed)
            if vehicle.tag.lower() in ['tiltwing', 'multicopter']:
                segment.analyses.extend(analyses.cruise)
                segment = vehicle.networks.battery_propeller.add_unknowns_and_residuals_to_segment(segment)
            elif tag == 'lift_cruise_crm': 
                segment.analyses.extend(analyses.base)
                segment = vehicle.networks.lift_cruise.add_cruise_unknowns_and_residuals_to_segment(segment, initial_prop_power_coefficient = 0.16)   
            elif tag == 'solar':
                now = time.time()
                # Convert it to a struct_time in local time
                now_struct = time.localtime(now)

                # Format it in the desired format
                formatted_now = now_struct # time.strftime("%a, %b %d %H:%M:%S %Y", now_struct)

                # Use it in your code
                segment.start_time = formatted_now 
                segment.analyses.extend(analyses.cruise)
                segment.battery_energy = vehicle.networks.solar.battery.max_energy*0.3
                segment = vehicle.networks.solar.add_unknowns_and_residuals_to_segment(segment,initial_power_coefficient = 0.05) 

            # add to misison
            mission.append_segment(segment)
            
            segment_type.append(segment.tag)
            climb_rate.append(np.nan)
            descend_rate.append(np.nan)
            start_altitude.append(segment.altitude)
            end_altitude.append(segment.altitude)
            climb_angle.append(np.nan)
            descent_angle.append(np.nan)
            speed_spec.append(segment.air_speed)
            time_required.append(timelapsed)

    
        profile_spec_df = pd.DataFrame(data={'segment_type':segment_type,
                                        'climb_rate':climb_rate,
                                        'descend_rate':descend_rate,
                                        'start_altitude':start_altitude,
                                        'end_altitude':end_altitude,
                                        'climb_angle':climb_angle,
                                        'descent_angle':descent_angle,
                                        'speed':speed_spec,
                                        'time_required':time_required
                                        })
        
        # base_path = ".\\logs\\profiles_eval\\"

        #base_path = "C:\\Users\\IRC\\Desktop\\encounter_gen_tool\\eVTOL_performance_evaluation\\logs\\profiles_eval_clustering_10k_ori\\"
        #profile_spec_df.to_csv(base_path+"profile_spec_"+'.csv', index=False)


        
        return mission
    
    
    def missions_setup(cls, base_mission):

        # the mission container
        missions = SUAVE.Analyses.Mission.Mission.Container()

        # ------------------------------------------------------------------
        #   Base Mission
        # ------------------------------------------------------------------

        missions.base = base_mission


        # done!
        return missions  

    
    def save_flight_conditions(cls, results):
         for label, segment in zip(results.segments.keys(), results.segments.values()): 
            time     = segment.conditions.frames.inertial.time[:,0] / Units.min

    def check_profile_feasibility(cls, results, vehicle_type, tj):

        feasibility_profile = []
        mission_segment_profile = []
        altitudes = []
        airspeeds = []
        thetas = []
        ranges = []
        times = []
        UAS_profile = []
        isFeasible = True
        
        feasbility_id= 0 if len(os.listdir(cls.feasibility_path))==0 else len(os.listdir(cls.feasibility_path))+1
        dynamics_id = 0 if len(os.listdir(cls.dynamics_path))==0  else len(os.listdir(cls.dynamics_path))
        
        

        for label, segment in zip(results.segments.keys(), results.segments.values()): 
            time     = segment.conditions.frames.inertial.time[:,0] * Units.min
            #feasibility_profile += [segment.converged] * len(list(time))
            mission_segment_profile += [label]*len(list(time))
            if 'cruise' in label and  not segment.converged:  
                isFeasible = False
            airspeed = segment.conditions.freestream.velocity[:,0] *   Units['ft/s']  
            theta    = segment.conditions.frames.body.inertial_rotations[:,1,None] / Units.deg
            
            x        = segment.conditions.frames.inertial.position_vector[:,0]*Units.ft
            y        = segment.conditions.frames.inertial.position_vector[:,1]*Units.ft
            z        = segment.conditions.frames.inertial.position_vector[:,2]*Units.ft
            altitude = segment.conditions.freestream.altitude[:,0]*Units.feet
            
            altitudes += list(altitude)
            airspeeds += list(airspeed) 
            thetas    += list(np.squeeze(theta)) 
            ranges    += list(x)
            times     += list(time)
            UAS_profile += [vehicle_type]*len(list(time))
            mission_segment_profile += [label]*len(list(time))
            if 'cruise' in label:  
                feasibility_profile += [segment.converged] #* len(list(time))
            
        # profile_df = pd.DataFrame(data={'time':times,
        #                                 'UAS_type':UAS_profile,
        #                                 'mission_segment':mission_segment_profile,
        #                                 'altitude_ft':altitudes,
        #                                 'airspeed':airspeeds,
        #                                 'pitch_angle_deg':thetas,
        #                                 'x':ranges,
        #                                 'y': y,
        #                                 'z':z
        #                                 })
        
        feasibility_df =  pd.DataFrame(data={'flight_dynamics':[tj], 'feasibility': [feasibility_profile], 'vehicle_type': [vehicle_type]})
        
        # profile_df.to_csv(cls.dynamics_path+"\\profile_dynamics_conditions_"+ vehicle_type + "_" + str(feasbility_id)+'.csv', index=False)
        feasibility_df['flight_dynamics'] = feasibility_df['flight_dynamics'].apply(lambda x: x.to_json())
        # Construct the file name
        file_name = f'profile_feasbility_{vehicle_type}_{feasbility_id}.csv'

        # Use os.path.join to create the full file path
        full_file_path = os.path.join(cls.feasibility_path, file_name)

        feasibility_df.to_csv(full_file_path, index=False)
        
        return isFeasible
          
    def trajectory_cruise_segmentation(cls, track):

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
        # Save the segmented data back to CSV
        # data.to_csv('your_data_file_with_segments.csv', index=False)
      
    def get_random_num(cls, low, high):
        return low + (high-low)*np.random.rand()
  
    
    # ----------------------------------------------------------------------
    #   Define the Configurations
    # ---------------------------------------------------------------------

    def multicoptor_configs_setup(cls, vehicle):
        # ------------------------------------------------------------------
        #   Initialize Configurations
        # ------------------------------------------------------------------

        configs = SUAVE.Components.Configs.Config.Container()

        base_config = SUAVE.Components.Configs.Config(vehicle)
        base_config.tag = 'base'
        configs.append(base_config)

        # ------------------------------------------------------------------
        #   Hover Configuration
        # ------------------------------------------------------------------
        config = SUAVE.Components.Configs.Config(base_config)
        config.tag = 'hover'
        config.networks.battery_propeller.pitch_command            = 0.  * Units.degrees
        configs.append(config)

        # ------------------------------------------------------------------
        #    Configuration
        # ------------------------------------------------------------------
        config = SUAVE.Components.Configs.Config(base_config)
        config.tag = 'climb'
        config.networks.battery_propeller.pitch_command            = 0. * Units.degrees
        configs.append(config)

        # ------------------------------------------------------------------
        #    Cruise Configuration
        # ------------------------------------------------------------------
        config = SUAVE.Components.Configs.Config(base_config)
        config.tag = 'cruise'
        config.networks.battery_propeller.pitch_command            = 20.  * Units.degrees
        configs.append(config)

        return configs
