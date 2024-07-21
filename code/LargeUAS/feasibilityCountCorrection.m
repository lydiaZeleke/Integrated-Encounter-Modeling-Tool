function [feasible_traj_avg, corrected_vehicle_models] = feasibilityCountCorrection()
%     List all files in the current directory
baseDir = getenv('INTEGRATED_ENC_DIR');
fullPath = fullfile(baseDir, 'logs', 'feasibility_data');
files = dir(fullPath);

feasibility_struct = struct('feasible', 0, 'infeasible', 0);
vehicle_models = struct('Tiltwing', feasibility_struct, ...
                        'Electric_Multicopter',  feasibility_struct, ...
                        'Solar_UAV', feasibility_struct, ...
                        'Stopped_Rotor',  feasibility_struct);

feasible_traj_avg = struct('altitude', [], 'speed', []);

% Loop through each file
for i = 1:length(files)
        filename = files(i).name;
   
    if files(i).isdir || ~endsWith(filename, '.csv')
        continue;
    end
    
    % Extract Data
    fullFilename = fullfile(fullPath, filename);
    data = readtable(fullFilename);
    data_table = jsondecode(data.flight_dynamics{1});

    feasibility = data.feasibility{1};
    feasibility = strrep(feasibility, '[', '');
    feasibility = strrep(feasibility, ']', '');
    
    % Replace True and False
    feasibility = strrep(feasibility, 'False', '0');
    feasibility = strrep(feasibility, 'True', '1');
    
    % Split the string by commas
    elements = strsplit(feasibility, ', ');
    
    % Convert to logical array
    feasibility_array = logical(str2double(elements));

    if all(feasibility_array)
        avg_altitude = computeAverage('alt_ft_msl', data_table);
        feasible_traj_avg.altitude = [ feasible_traj_avg.altitude, avg_altitude];
    
        avg_speed = computeAverage('speed_ft_s', data_table);
        feasible_traj_avg.speed = [ feasible_traj_avg.speed, avg_speed];
    end 
% %     Check if the file name contains 'tiltwing' or 'electric_multicopter'
%     if contains(lower(filename), 'solar') || contains(lower(filename), 'multicopter')
% 
% %         Check and update for 'Solar_UAV'
%         if contains(lower(filename), 'solar')
%             if strcmp(data.feasibility{1},'True')
%                 vehicle_models.Solar_UAV.feasible = vehicle_models.Solar_UAV.feasible + 1;
%             else
%                 vehicle_models.Solar_UAV.infeasible = vehicle_models.Solar_UAV.infeasible + 1;
%             end
%         end
% 
% %         Check and update for 'Electric_Multicopter'
%         if contains(lower(filename), 'multicopter')
%                   
%             if strcmp(data.feasibility{1},'True')
%                 vehicle_models.Electric_Multicopter.feasible = vehicle_models.Electric_Multicopter.feasible + 1;
%                
%             else
%                 vehicle_models.Electric_Multicopter.infeasible = vehicle_models.Electric_Multicopter.infeasible + 1;
%             end
%         end
%     end
% end
    if contains(lower(filename), 'solar')
        if all(feasibility_array)
            vehicle_models.Solar_UAV.feasible = vehicle_models.Solar_UAV.feasible + 1;
        else
            vehicle_models.Solar_UAV.infeasible = vehicle_models.Solar_UAV.infeasible + 1;
        end
    elseif contains(lower(filename), 'multicopter')          
        if feasibility_array
            vehicle_models.Electric_Multicopter.feasible = vehicle_models.Electric_Multicopter.feasible + 1;
           
        else
            vehicle_models.Electric_Multicopter.infeasible = vehicle_models.Electric_Multicopter.infeasible + 1;
        end
    elseif contains(lower(filename), 'lift_cruise_crm')          
        if feasibility_array
            vehicle_models.Stopped_Rotor.feasible = vehicle_models.Stopped_Rotor.feasible + 1;
           
        else
            vehicle_models.Stopped_Rotor.infeasible = vehicle_models.Stopped_Rotor.infeasible + 1;
        end
    elseif contains(lower(filename), 'tiltwing')          
        if feasibility_array
            vehicle_models.Tiltwing.feasible = vehicle_models.Tiltwing.feasible + 1;
           
        else
            vehicle_models.Tiltwing.infeasible = vehicle_models.Tiltwing.infeasible + 1;
        end
    end
end

corrected_vehicle_models = vehicle_models;
end

function avg_val = computeAverage(variableName, data_table)
    values = struct2array(data_table.(variableName));
    avg_val = mean(values);
end

