function feasibility = trackFeasibilityAnalyses(bayes_track, aircraftClass)
   
    global trackFeasibilityTrace;
    % Path to the Python file
    bayesTable = timetable2table(bayes_track);
    bayesTable.Time = string(bayesTable.Time);
    
    % Convert to a struct where each variable is a field
    bayes_track_struct = struct();
    for varName = bayesTable.Properties.VariableNames
        bayes_track_struct.(varName{1}) = bayesTable.(varName{1});
    end

    bayes_payload_struct = struct("aircraft_class", aircraftClass, "trajectory_data", bayes_track_struct);
    bayes_manned = jsonencode(bayes_payload_struct, PrettyPrint=true);
    base_path = getenv('INTEGRATED_ENC_DIR');
    write_path = fullfile(base_path, 'code', 'LargeUAS', 'machineLearningAnalysis');
    write_file = fullfile(write_path, 'bayes_manned_track.json');

    fid =fopen(write_file,'wt');
    if fid == -1
        error('Cannot open file: %s', write_file);     % Check if the file was opened successfully
    end
    
    % Write the JSON string to the file
    fprintf(fid, '%s', bayes_manned);

    fclose(fid);
%Uncomment to experiment with LUAS data generation using the SUAVE
%analaysis Approach
%     write_file = append(write_path,'\','bayes_manned_track.csv');
%     writetimetable(bayes_track, write_file);
%     python_file = append(write_path,'\', 'evaluate_tracks_multiple_vehicles.py');
    
    % Construct the path to the python file, ensuring to handle spaces correctly
    python_file = fullfile(write_path, 'model_prediction.py');
    
    % Now we need to ensure the system command is properly formatted with quotes around the paths
    envBasePath = '/home/lydiazeleke/lydenv/bin/python';
    python_interpreter = strrep(envBasePath, '/', filesep);
    python_cmd = ['"', python_interpreter, '" "', python_file, '"'];


    [status, cmdout] = system(python_cmd, '-echo');
    results = cmdout;
    
    % Find the Feasibility Report Line and Marker%  
    search_phrase = lower('Feasibility Report: ');
    search_marker = '***';

    start_idx = strfind(lower(results), search_phrase);
    start_idx = start_idx + length(search_phrase);
    end_idx = strfind(lower(results), search_marker);

    result_end_idx = length(results)-1;
    if ~contains(results(start_idx:result_end_idx), search_marker ) %isempty(end_idx)
       % If there's no newline, extract to the end of the string
       substr = results(start_idx:end_idx-1);
       disp('Feasbility Result Phrase not captured properly. Please Try Running Again.')
    else
      % If there's a newline, extract up to just before it
      substr = results(start_idx : end_idx-1);

      % Replace single quotes with double quotes
      substr = replace(substr, '''', '"');
    
      % Replace True and False with true and false
      substr = strrep(substr, 'True', 'true');
      substr = strrep(substr, 'False', 'false');


      feasibility_results_obj = jsondecode(substr);
    end
    

    %UAS Feasbility Condition For Track
     feasbility_result = feasibility_results_obj.Tiltwing || feasibility_results_obj.Stopped_Rotor || feasibility_results_obj.Electric_Multicopter || feasibility_results_obj.Solar_UAV;
    
    aircraft_type = {};
    models = {};
    if feasbility_result

        % Model Categories of Feasible Tracks 
               
        fields = fieldnames(feasibility_results_obj);
        for i=1:numel(fields) 
            if feasibility_results_obj.(fields{i}) == 1
                models = [models, fields{i}];
            end
        end

    end


    % Key and value set for track
    bayes_track = bayes_track(:, {'north_ft', 'east_ft', 'alt_ft_msl', 'lat_deg', 'lon_deg'});
    keys = {'track', 'isFeasible','vehicle_models'};
    values = {bayes_track, feasbility_result, models};
    trackFeasibilityTrace{end+1} = containers.Map(keys, values,"UniformValues", false);
    
    feasibility = feasbility_result;

end
