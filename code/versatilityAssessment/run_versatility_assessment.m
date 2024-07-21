
%%% Run all analysis %%%

% Define Root Directory for the Baseline Dataset
rootDir = fullfile(pwd, 'data/baseline_processed_dataset');

subDirs = dir(rootDir); % The '*/' pattern finds directories only
subDirs = subDirs([subDirs.isdir]); % Remove any non-directory entries
% Filter out the parent and current directory entries ('.' and '..')
subDirs = subDirs(~ismember({subDirs.name}, {'.', '..'}));
numEncountersToSelect = 5556;
statsTable = table([], [], [], [], [], [], [], [], 'VariableNames', ...
    {'EncConfig', 'EncNum', 'UniqueGeometry', 'ClosingSpeed', 'SpeedOwnship', 'SpeedIntruder', 'AltitudeOwnship', 'AltitudeIntruder'});


% Loop over each subdirectory
for i = 1:length(subDirs)
   
    % Full path to the subdirectory
    subDirPath = fullfile(rootDir, subDirs(i).name);
    matFiles = dir(fullfile(subDirPath, '*.mat'));
    matCount = numEncountersToSelect; %fix(length(matFiles)/2);

    for encNum = 1:matCount
        ownshipFile = fullfile(subDirPath, strcat('ownship_', string(encNum), '.mat'));
        intruderFile = fullfile(subDirPath,strcat('intruder_', string(encNum), '.mat'));
        % Check if the 'scriptedEncounters.mat' file exists in the subdirectory
        if exist(ownshipFile, 'file') && exist(intruderFile, 'file')
        
            ownshipData = load(ownshipFile);
            intruderData = load(intruderFile);
            
         %% Tool Versatility Assessment Section %%%
           
         % ----- Analysis #1 -------%
            own_field = fieldnames(ownshipData);
            int_field = fieldnames(intruderData);

%             if isfield(ownshipData, own_field{1})
    
            encounterType = find_geometry(ownshipData.(own_field{1}), intruderData.(int_field{1}), encNum);
%             else
%                 encounterType = find_geometry(ownshipData.aircraft_data, intruderData.aircraft_data);
%             end
            % Filter out 'Invalid' enumeration values
            notInvalid = cellfun(@(x) x ~= EncounterGeometryClasses.Invalid, encounterType);
            filteredEncounterType = encounterType(notInvalid);
            % Convert enumeration values to strings
            encTypeStr = cellfun(@char, filteredEncounterType, 'UniformOutput', false);
            uniqueGeometriesinEnc = unique(encTypeStr);
            if isempty(uniqueGeometriesinEnc)
                uniqueGeometriesinEnc(1) = {EncounterGeometryClasses.Invalid};
                uniqueGeometriesinEnc = cellfun(@char, uniqueGeometriesinEnc, 'UniformOutput', false);
            end
            conc = strcat('Geometry class in encounter', '   ', string(encNum), ': ', uniqueGeometriesinEnc);
            disp(conc)
    
            %% Analysis #2
            [closingSpeed, speedOwn, speedInt, altitudeOwn, altitudeInt] = dwc_loss_parameters(ownshipData.(own_field{1}), intruderData.(int_field{1}));
            % Add a new row to the statsTable
            newRow = {i, encNum, uniqueGeometriesinEnc{1}, closingSpeed, speedOwn, speedInt, altitudeOwn, altitudeInt};
            statsTable = [statsTable; newRow];
        end
    end   
end

date_now = datetime('now', 'Format', 'yyyy-mm-dd HH-MM');
outputDir = fullfile(pwd, 'output', datestr(date_now, 'yyyy-mm-dd HH-MM'));

% Check if the output directory exists, if not, create it
if ~exist(outputDir, 'dir')
    mkdir(outputDir);
end


% Visualize the PDF for each metrics 
compute_param_PDF(statsTable, outputDir);
metricsTable = statistical_analysis_metrics(statsTable);

 
%%%%%%%% SAVE VARIABLE STATS FOR EACH ENCOUNTER IN A TABLE %%%%%%%%%


% Define the file name without date-time information
filename = 'statsTable_custom.csv';

% Full path to the file including directories and filename
fullFilePath = fullfile(outputDir, filename);

% Save the table to a CSV file
writetable(statsTable, fullFilePath, 'WriteRowNames', true);

% Display a message to confirm file saving
disp(['Table saved to ', fullFilePath]);
