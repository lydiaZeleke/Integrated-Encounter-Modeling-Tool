function [sUAS_state, ref_point, sUAS_type] =  sUASDynamicsModeling(track,lat0_deg,lon0_deg,el0_ft_msl)
    rng('shuffle');

    % Select the dynamics model from a uniform distribution
    sUAS_models = {'FixedWingPathDynamics', 'multirotorPathDynamics'};
    mdl_num = randi(length(sUAS_models));
    model_name = sUAS_models{mdl_num};
    
    % Unit conversion
    ft2m = 0.3048;
    m2ft = 3.28084;
    kt2m = 0.51444;

    waypoint_track = track(2:end,:); 
    waypoints1 = [waypoint_track.north_ft waypoint_track.east_ft -waypoint_track.alt_ft_msl] * ft2m; %Convert unit from ft->meter 
    waypoints = waypoints1;
    if strcmp(mdl_num, sUAS_models(1))
%         waypoints = processWaypoints(waypoints);
    end
    last_waypoint = waypoints(height(waypoints)-1,:);
    initial_values = track(2,:);
   

    Tfinal = floor(height(track)/10) * 10;
    sim_stop = floor(height(track)/10) + 150;
    clear waypointData;
    
    weight_speed_grp = 0;
    switch(model_name)
        case 'multirotorPathDynamics'
            sampleRate = 0.005; 
        otherwise
            sampleRate = 0.01;     
    end
    %Sample aircraft weight and airspeed from Gaussian distribution 
    sample = sample_distribution(weight_speed_grp);
    airspeedVal =  sample(1); 
    aircraftMGTOW = sample(2);


    if strcmp(model_name, 'multirotorPathDynamics')
        posNED = [initial_values.north_ft * ft2m, initial_values.east_ft * ft2m, -initial_values.alt_ft_msl * ft2m];
        posLLA = [initial_values.lat_deg, initial_values.lon_deg, initial_values.alt_ft_msl *ft2m ];

        track.heading_rad = deg2rad(track.heading_deg);
        track.eastRate_ftps =  (track.groundspeed_kt * 1.68781) .* sin(track.heading_rad) ; % Conversion kt->ft/s;
        track.northRate_ftps =(track.groundspeed_kt * 1.68781) .* cos(track.heading_rad);
        track.upRate_ftps = track.altRate_fps;
        vel_ned = [track(2,:).northRate_ftps * ft2m, track(2,:).eastRate_ftps * ft2m, -track(2,:).upRate_ftps * ft2m];
        
        dateCondition =  [2019 1 1 0 0 0]; %Dummy Date
        
        %Find current path
        scriptPath = mfilename('fullpath');
        currDir = fileparts(scriptPath);
        dictPath = fullfile(currDir, 'modelData', 'multirotorPathDataDict.sldd');

        dd = Simulink.data.dictionary.open(dictPath); 
        initialConditions = dd.getSection('Design Data').getEntry('initialConditions').getValue();
        UAVSampleTime =  dd.getSection('Design Data').getEntry('UAVSampleTime');
    
        initialConditions.posNED = posNED ;
        initialConditions.posLLA = posLLA ;
        %initialConditions.euler = euler;
        initialConditions.vb = vel_ned;
        initialConditions.date = dateCondition;
        uavIC_latLon = [lat0_deg,lon0_deg];
        initialConditions.uav_mass = aircraftMGTOW;

        % Update the struct object in the data dictionary
        dd.getSection('Design Data').getEntry('initialConditions').setValue(initialConditions);
        UAVSampleTime.setValue(sampleRate);
        dd.getSection('Design Data').getEntry('uavIC_latLon').setValue(uavIC_latLon);
        dd.saveChanges;
        dd.close;
       
        evalin('base', 'modelInit;');

    else

        FidelityStage = 2;  % Set the level of Vehicle Dynamics Fidelity--> 'FidelityStage' 
        midFidelityUAV= mediumFidelitySetup();
        midFidelityUAV.maxroll=20;
        midFidelityUAV.initialAirspeed=initial_values.speed_ft_s  * ft2m;
        midFidelityUAV.initialAltitude= initial_values.alt_ft_msl * ft2m;
        midFidelityUAV.Tfinal=Tfinal;
        midFidelityUAV.aircraftM = aircraftMGTOW;
        midFidelityUAV.initialNorth=initial_values.north_ft * ft2m;
        midFidelityUAV.initialEast=initial_values.east_ft * ft2m;
        midFidelityUAV.initialFlightPathAngle=0;
        midFidelityUAV.initialHeadingAngle=0; %heading_rad(1); 
        assignin('base','midFidelityUAV',midFidelityUAV);
        
    end
    
    
    waypointData = waypoints(1:height(waypoints)-1,:);
    open_system(model_name)
    modelPath = fileparts(which(model_name));
    
    % Create a configuration set object and attach it to the model
    cfg = Simulink.fileGenControl('getConfig');
    cfg.CacheFolder = modelPath;
    cfg.CodeGenFolder = modelPath;

    set_param(model_name, 'StopTime', num2str(sim_stop));

    vehicleDynStates = get_param(bdroot, 'ModelWorkspace'); 
    vehicleDynStates.assignin('airspeedVal', airspeedVal);   
    vehicleDynStates.assignin('waypointData', waypointData); 
    vehicleDynStates.assignin('lastWaypointInstance', last_waypoint'); 
    if strcmp(model_name, 'FixedWingPathDynamics')
        set_param(model_name, 'InitFcn', sprintf('FidelityStage = %d;', FidelityStage)); % Set the value of 'FidelityStage' in the model workspace
    end  

    % Run the simulation
    sim(model_name); 
    

    %%%%% Restructuring Simulated Data and Visualization  %%%%%%

   % Sample new time vector (e.g., uniform 0.1s from start to end)
   start_time = 0;
   end_time =  seconds(track.Time(end));
   newTime = (start_time:0.1:end_time).'; 

   % Retiming the timetable to 0.1 second timestep using linear interpolation
   if strcmp(model_name, 'multirotorPathDynamics')
       % Extract states for clarity
       pos_vel = States.pos_vel;
       attitude = States.attitude;
       gps = States.gps;
        
      % Compute speed in ft/s
       speed_ft_s = (sqrt(pos_vel.vx.Data.^2 + pos_vel.vy.Data.^2 + pos_vel.vz.Data.^2)) * m2ft;

       sUAS_state_mr = struct(...
                        'Time', pos_vel.x.Time, ...
                        'north_ft', pos_vel.x.Data * m2ft, ...
                        'east_ft', pos_vel.y.Data * m2ft, ...
                        'alt_ft_msl', pos_vel.z.Data * m2ft, ...
                        'speed_ft_s', speed_ft_s, ...
                        'heading_deg', rad2deg(attitude.yaw.Data), ...
                        'theta_rad', attitude.pitch.Data, ...
                        'psi_rad', attitude.yaw.Data, ...
                        'phi_rad', attitude.roll.Data, ...
                        'phidot_radps', attitude.rollspeed_p.Data, ...
                        'psidot_radps', attitude.yawspeed_r.Data, ...
                        'thetadot_radps', attitude.pitchspeed_q.Data, ...
                        'northRate_ftps', pos_vel.vx.Data * m2ft, ...
                        'eastRate_ftps', pos_vel.vy.Data * m2ft, ...
                        'upRate_ftps', pos_vel.vz.Data * m2ft, ...
                        'lat_deg', single(gps.lat.Data)/1e7, ...
                        'lon_deg', single(gps.lon.Data)/1e7);
        sUAS_state_mr = structfun(@squeeze, sUAS_state_mr, 'UniformOutput', false);

       % New structure to store retimed data
        sUAS_state_mr_new = struct();
        sUAS_state_mr_new.Time = newTime;
        
        fields_mr = fieldnames(sUAS_state_mr);
        for i = 1:length(fields_mr)
            field = fields_mr{i};
            
            % Skip the Time field
            if strcmp(field, 'Time')
                continue;
            end
        
            % Original data and time
            originalData = sUAS_state_mr.(field);
            originalTime = sUAS_state_mr.Time;
        
            % Interpolate using interp1 (example: 'pchip')
            % Ensure time is converted to numeric format for interp1
            originalTimeNumeric = datenum(originalTime);
            newTimeNumeric = datenum(newTime);
            interpolatedData = interp1(originalTimeNumeric, originalData, newTimeNumeric, 'pchip', 'extrap'); % 'extrap' allows extrapolation
        
            % Store in the new structure
            sUAS_state_mr_new.(field) = interpolatedData;
        end

        sUAS_state = sUAS_state_mr_new;
        sUAS_state.Time = seconds(sUAS_state.Time);
        sUAS_type = 'multirotor';
    
   elseif strcmp(model_name, 'FixedWingPathDynamics')
        States = struct2timetable(States, model_name);
        States.Height = -States.Height;
        States(1,:).Height = -States(1,:).Height;

        % Convert data to desired format
        sUAS_state_fw = struct(...
            'Time', States.Time, ...
            'north_ft', States.North * m2ft, ...
            'east_ft', States.East * m2ft, ...
            'alt_ft_msl', States.Height * m2ft, ...
            'speed_ft_s', States.AirSpeed * m2ft, ...
            'heading_deg', rad2deg(States.HeadingAngle), ...
            'theta_rad', States.FlightPathAngle, ...
            'psi_rad', States.HeadingAngle, ...
            'phi_rad', States.RollAngle, ...
            'phidot_radps', States.RollAngleRate);
       
        % Resample each timeseries in sUAS_state_fw
        fields = fieldnames(sUAS_state_fw);
        for i = 1:numel(fields)
            if ~strcmp(fields{i}, 'Time')
               sUAS_state_fw.(fields{i}) = interp1(seconds(sUAS_state_fw.Time), sUAS_state_fw.(fields{i}), newTime, 'pchip', 'extrap');
            end
        end
        sUAS_state_fw.Time = seconds(newTime);
        sUAS_state = sUAS_state_fw;
        sUAS_type = 'fixed_wing';
       
   end
   sUAS_state.alt_ft_msl = abs(sUAS_state.alt_ft_msl);
   States = struct('North', sUAS_state.north_ft , 'East', sUAS_state.east_ft, 'Height', sUAS_state.alt_ft_msl,'HeadingAngle', sUAS_state.psi_rad, 'FlightPathAngle', sUAS_state.theta_rad, 'RollAngle', sUAS_state.phi_rad);  
   
   %%%%%%  Uncomment to Visualize Simulation  %%%%%%%%
    metadata = struct();
    metadata.airspeed = airspeedVal;
    metadata.weight = aircraftMGTOW;
    metadata.altitude = mean(sUAS_state.alt_ft_msl);

    interpolated_waypoints = processWaypoints(waypoints);
    interpolated_waypoints(:,:) = interpolated_waypoints(:,:) * m2ft;
    original_waypoints(:,:) = waypoints1(:,:) * m2ft;
    visualizeSimulation(States,original_waypoints , interpolated_waypoints, metadata);

  %%%%%%%%%%%%%---------------%%%%%%%%%%%%%
   

   state_table = struct2table(sUAS_state);          % Convert struct to table first
   tt = table2timetable(state_table); %, 'RowTimes', seconds(timestep)); % Convert table to timetable
   % Assuming yourTimetable is your timetable variable
   containsNaN = any(varfun(@(x) any(isnan(x)), tt, 'OutputFormat', 'uniform'));

   if containsNaN
       disp(tt)
   end
   sUAS_state = retime(tt,'regular','pchip','TimeStep',seconds(0.1));
   ref_point = [lat0_deg, lon0_deg, el0_ft_msl * ft2m];


end

function tt = struct2timetable(s, model_name)
  fields = fieldnames(s);
  timeVector = s.(fields{1}).Time;
  timeDuration = seconds(timeVector); % Convert time vector to duration.
  nDataPoints = length(timeVector);
  dataArray = zeros(nDataPoints, numel(fields));

  % Extract the data from each time series to form a table.
  if strcmp(model_name, 'multirotorPathDynamics')
     for i = 1:numel(fields)
       dataArray(:, i) = s.(fields{i}).Data;     
     end
     tt = array2timetable(dataArray, 'RowTimes', timeDuration, 'VariableNames', fields);
  else
     dataCell = cellfun(@(f) s.(f).Data, fields, 'UniformOutput', false);
     tbl = table(dataCell{:}, 'VariableNames', fields);
     tt = table2timetable(tbl, 'RowTimes', timeDuration);
  end
end

