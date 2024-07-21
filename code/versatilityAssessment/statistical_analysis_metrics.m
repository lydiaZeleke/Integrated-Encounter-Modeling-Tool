function metricsTable = statistical_analysis_metrics(statsTable, isCustom)

    if nargin < 2
        isCustom = false;
    end
    dividing_factor = 1.68781;

    if isCustom
        dividing_factor = 1;
    end
    % Converting closing speed to knots
    closingSpeed = statsTable.ClosingSpeed/ dividing_factor;
    ownSpeed = statsTable.SpeedOwnship/dividing_factor;
    intSpeed = statsTable.SpeedIntruder/1.68781;
    ownAlt = statsTable.AltitudeOwnship;
    intAlt = statsTable.AltitudeIntruder;
    geometryClasses = statsTable.UniqueGeometry;

    % Initialize table for metrics
    metricsTable = table();

    % Parameters to analyze
    parameters = {closingSpeed, ownSpeed, intSpeed, ownAlt, intAlt};
    paramNames = {'ClosingSpeed', 'OwnshipSpeed', 'IntruderSpeed', 'OwnshipAltitude', 'IntruderAltitude'};
    
    for i = 1:length(parameters)
        param = parameters{i};

        % Compute statistical metrics for each parameter
        skewness_val = skewness(param);
        kurtosis_val = kurtosis(param);
        range_val = range(param);
        iqr_val = iqr(param);
        standard_dev = nanstd(param);
        
        % Computing Shannon Entropy (needs discretization of data)
        [prob, ~] = histcounts(param, 'Normalization', 'probability');
        entropy_val = -sum(prob .* log2(prob + eps), 'omitnan');

        % Adding metrics to the table
        metricsTable.(paramNames{i}) = [skewness_val; kurtosis_val; standard_dev; range_val; iqr_val; entropy_val];
    end

    % Adding row names to the table
    metricsTable.Properties.RowNames = {'Skewness', 'Kurtosis', 'Standard Deviation', 'Range', 'IQR', 'Entropy'};
  
    
    % Get the current date and time
    date_now = datetime('now', 'Format', 'yyyy-mm-dd HH-MM');
    
    % Create the folder path for 'output' and date-time named folder
    outputDir = fullfile(pwd, 'output', datestr(date_now, 'yyyy-mm-dd HH-MM'));
    
    % Check if the output directory exists, if not, create it
    if ~exist(outputDir, 'dir')
        mkdir(outputDir);
    end
    
    % Define the file name based on whether it is custom or not
    if isCustom
        filename = 'metricsTable_custom.csv';
    else
        filename = 'metricsTable.csv';
    end
    
    % Full path to the file
    fullFilePath = fullfile(outputDir, filename);
    
    % Save the table to a CSV file
    writetable(metricsTable, fullFilePath, 'WriteRowNames', true);
    
    % Optionally, display a message confirming the save
    disp(['Table saved to ', fullFilePath]);
    
end
