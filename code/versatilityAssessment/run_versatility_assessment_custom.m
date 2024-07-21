
%%% Run all analysis %%%

% Define Root Directory for the Custom Dataset
baseDir = getenv('INTEGRATED_ENC_DIR');
dataPath = fullfile(baseDir, 'output', 'encounter_set', 'Own_LUAS');

% Open the directory selection dialog at the specified path
selectedFolder = uigetdir(dataPath, 'Select a Subfolder');

if selectedFolder == 0
    disp('No folder selected');
else
    [~, folderName, ~] = fileparts(selectedFolder);
end


%%%%%%%%%%%
rootDir = fullfile(dataPath, folderName);
isCustom = true;
global statsTable encNum tradespaceNum;

encNum = 0;
statsTable= table([], [], [], [], [], [], [], [], 'VariableNames', ...
    {'EncConfig', 'EncNum', 'UniqueGeometry', 'ClosingSpeed', 'SpeedOwnship', 'SpeedIntruder', 'AltitudeOwnship', 'AltitudeIntruder'});

processEncounters(rootDir, folderName);

date_now = datetime('now', 'Format', 'yyyy-mm-dd HH-MM');
outputDir = fullfile(pwd, 'output', datestr(date_now, 'yyyy-mm-dd HH-MM'));

% Check if the output directory exists, if not, create it
if ~exist(outputDir, 'dir')
    mkdir(outputDir);
end


% % Visualize the PDF for each metrics 
compute_param_PDF(statsTable, outputDir, isCustom);
metricsTable = statistical_analysis_metrics(statsTable, isCustom);

%%%%%%%% SAVE VARIABLE STATS FOR EACH ENCOUNTER IN A TABLE %%%%%%%%%

% Define the file name without date-time information
filename = 'statsTable_custom.csv';

% Full path to the file including directories and filename
fullFilePath = fullfile(outputDir, filename);

% Save the table to a CSV file
writetable(statsTable, fullFilePath, 'WriteRowNames', true);

% Display a message to confirm file saving
disp(['Table saved to ', fullFilePath]);


function processEncounters(rootDir, folderName)

    global encNum tradespaceNum;
    passOn = true;
    % This function starts at the root directory of your tradespace
    % and searches for encounter directories to process CSV files.

    % List all items in the root directory
    items = dir(rootDir);

    
    % Filter out the '.' and '..' directories
    items = items(~ismember({items.name}, {'.', '..'}));
    encounterPattern = 'encounter_\d+';
    if ~isempty(regexp(rootDir, encounterPattern, 'once'))
        encNum = encNum + 1;
        csvFiles= dir(fullfile(rootDir, '*.csv'));
        processCSVFile(csvFiles, rootDir, encNum);
    else
    % Loop through each tradespace item in the root directory
        for i = 1:length(items)
            currentPath = fullfile(rootDir, items(i).name);
            if endsWith(rootDir, folderName)
                tradespaceNum = items(i).name;
%                 if str2double(tradespaceNum) < 85
%                     passOn = true;
%                 else
%                     passOn = false;
%                 end
            end
            if items(i).isdir && passOn
                % If the item is a directory, it might be a numbered directory,
                % an anchor directory, or an encounter directory. Dive deeper in any case.
                processEncounters(currentPath, folderName);
            end
        end
    end
end

function processCSVFile(csvFiles, rootDir, encNum)

    global statsTable tradespaceNum;

    for i=1:length(csvFiles)
        fileName = csvFiles(i).name;
        csvFilePath = fullfile(rootDir, fileName);
        if contains(fileName, 'own')
            ownshipData = readtable(csvFilePath);
        else
            if contains(fileName, 'int')
                isSmallUAS = true;
            else
                isSmallUAS = false;
            end
            intruderData = readtable(csvFilePath);
        end
    end


    %% Tool Versatility Assessment Section %%% 
    %% Analysis #1 %
    ownshipData= updateAircraftFieldNames(ownshipData);
    intruderData= updateAircraftFieldNames(intruderData);
    
    own_field = fieldnames(ownshipData);
    int_field = fieldnames(intruderData);

    encounterType = find_geometry(ownshipData, intruderData, encNum);

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
    [closingSpeed, speedOwn, speedInt, altitudeOwn, altitudeInt] = dwc_loss_parameters(ownshipData, intruderData, isSmallUAS);
    % Add a new row to the statsTable
    newRow = {tradespaceNum, encNum, uniqueGeometriesinEnc{1}, closingSpeed, speedOwn, speedInt, altitudeOwn, altitudeInt};
    statsTable = [statsTable; newRow];

end

function T = updateAircraftFieldNames(aircraftTable)
        % Get the current variable names
    varNames = aircraftTable.Properties.VariableNames;
    
    % Create a map of old names to new names
    oldNewNamesMap = {'n_ft', 'north_ft'; 'e_ft', 'east_ft'; 'h_ft', 'up_ft'; 'v_ftps', 'speed_ftps'};
    
    % Loop through the map and update the names
    for i = 1:size(oldNewNamesMap, 1)
        varIndex = strcmp(varNames, oldNewNamesMap{i, 1});
        if any(varIndex)
            varNames{varIndex} = oldNewNamesMap{i, 2};
        end
    end
    
    % Apply the updated names back to the table
    aircraftTable.Properties.VariableNames = varNames;
    T = aircraftTable;
end


