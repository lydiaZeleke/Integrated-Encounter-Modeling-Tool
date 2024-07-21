
% Define Root Directory for the Baseline Dataset
rootDirBaseline = fullfile(pwd, 'data/baseline_processed_dataset');
rootDirCustom =   fullfile(pwd, 'data/custom_combined');

%Global variables
isCustom = true;
statsTable= table([], [], [], [], [], [], [], [], 'VariableNames', ...
    {'EncConfig', 'EncNum', 'UniqueGeometry', 'ClosingSpeed', 'SpeedOwnship', 'SpeedIntruder', 'AltitudeOwnship', 'AltitudeIntruder'});

global statsTableBaseline statsTableCustom encNum tradespaceNum;
statsTableBaseline = statsTable;
statsTableCustom = statsTable;

processBaselineEncounters(rootDirBaseline)
processCustomEncounters(rootDirCustom)
plotGeometeryDistns()


function plotGeometeryDistns()
    global statsTableCustom statsTableBaseline
    % Plotting distribution for UniqueGeometry
    % Define the category labels
    categoryLabels = {'HeadOn', 'Overtaken', 'Overtaking', 'LeftObliqueOvertaking', ...
                      'RightObliqueOvertaking', 'ConvergingFromLeft', 'ConvergingFromRight', ...
                      'VerticallyConverging', 'HorizontallyUnambiguous', 'Invalid'};
    
    % Convert UniqueGeometry to categorical
    categoriesCustom = categorical(statsTableCustom.UniqueGeometry, categoryLabels);
    categoriesBaseline = categorical(statsTableBaseline.UniqueGeometry, categoryLabels);
    
    % Calculate the probability distribution for each category
    probDistCustom = countcats(categoriesCustom) / length(categoriesCustom);
    probDistBaseline = countcats(categoriesBaseline) / length(categoriesBaseline);
    
    % Create a matrix for the bar graph
    data = [probDistCustom(:) probDistBaseline(:)];
    
       % Create a figure
    fig1 = figure;
    
    % Create a grouped bar plot
    b = bar(data, 'grouped');
    b(1).FaceColor = [0.0745, 0.5529, 0.4588];  % Custom Teal Color
    b(2).FaceColor = 'red';                     % Red Color for Baseline
    
    % Adjust bar width (default is 0.8, increase to reduce space between groups)
    b(1).BarWidth = 1;  % Apply to both if needed
    b(2).BarWidth = 1;  % Apply to both if needed
    
    % Set the colormap if using bar handle directly to set colors
    % colormap([0.0745, 0.5529, 0.4588; 1, 0, 0]); % Custom color and red for baseline
    
    % Add category labels to the x-axis
    xticks(1:length(categoryLabels));
    xticklabels(categoryLabels);
    xtickangle(45);
    
    % Add title and axis labels
    title('Comparison of Unique Geometry Class Distribution');
    xlabel('Geometry Class', 'FontSize', 14, 'FontWeight', 'bold');
    ylabel('Probability', 'FontSize', 14, 'FontWeight', 'bold');
    
    % Add grid and legend
    grid on;
    legend('Custom Dataset', 'Baseline Dataset', 'Location', 'best');
    
    % Adjust figure properties for better visibility
    set(gca, 'FontSize', 12, 'FontWeight', 'bold'); % Adjust font size and weight for readability
    box on; % Add box around the plot
    
    % Save the figure
    saveas(fig1, fullfile(baselineDir, 'GeometryClassDistComparison.jpg')); % Save as JPG
    print(fig1, fullfile(baselineDir, 'GeometryClassDistComparison.jpg'), '-djpeg', '-r300');
    close(fig1);

    
end

function processBaselineEncounters(rootDir)
    global statsTableBaseline

    subDirs = dir(rootDir); % The '*/' pattern finds directories only
    subDirs = subDirs([subDirs.isdir]); % Remove any non-directory entries
    % Filter out the parent and current directory entries ('.' and '..')
    subDirs = subDirs(~ismember({subDirs.name}, {'.', '..'}));
    numEncountersToSelect =295; % 5318;
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
                encounterType = find_geometry(ownshipData.(own_field{1}), intruderData.(int_field{1}), encNum);
    
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
                statsTableBaseline = [statsTableBaseline; newRow];
            end
        end   
    end


end

function processCustomEncounters(rootDir)

    global tradespaceNum;
    encNum = 0;
    passOn = true;
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
            if endsWith(rootDir, 'custom_combined')
                tradespaceNum = items(i).name;
            end
            if items(i).isdir && passOn
                % If the item is a directory, it might be a numbered directory,
                % an anchor directory, or an encounter directory. Dive deeper in any case.
                processCustomEncounters(currentPath);
            end
        end
    end
end

function processCSVFile(csvFiles, rootDir, encNum)

    global statsTableCustom tradespaceNum;

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
    statsTableCustom = [statsTableCustom; newRow];

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
