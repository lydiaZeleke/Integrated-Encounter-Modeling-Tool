function fig_uas_composition = plotUASComposition(trackFeasibilityTrace)
    % Initialize the aircraft type/model counts
    feasibility_struct = struct('feasible', 0, 'infeasible', 0);
    aircraftTypeCounts = struct('Hybrid', feasibility_struct, 'Rotorcraft', feasibility_struct, 'Fixed_Wing', feasibility_struct);   
    vehicle_models = struct('Tiltwing', feasibility_struct, ...
                        'Electric_Multicopter',  feasibility_struct, ...
                        'Solar_UAV', feasibility_struct, ...
                        'Stopped_Rotor',  feasibility_struct);

    feasible_count =  0;
    infeasible_count = 0;
    
    % Iterate over the trackFeasibilityTrace cell array
    for i = 1:numel(trackFeasibilityTrace)
        % Get the current Map object
        map = trackFeasibilityTrace{i};

        feasible_models = map('vehicle_models');
        if map('isFeasible')
            feasible_count = feasible_count + 1;
            for i = 1:length(feasible_models)
                model = feasible_models{i};
                vehicle_models.(model).feasible = vehicle_models.(model).feasible + 1;
    
                % Generic Aircraft Categories
                if strcmp(model, 'Tiltwing') || strcmp(model, 'Stopped_Rotor')
                    type = 'Hybrid';
    
                elseif strcmp(model, 'Solar_UAV')
                    type = 'Fixed_Wing';
    
                elseif strcmp(model, 'Electric_Multicopter')
                    type = 'Rotorcraft';
                end
                aircraftTypeCounts.(type).feasible = aircraftTypeCounts.(type).feasible + 1;           
            end        
        else 
           infeasible_count = infeasible_count + 1;
        end

        infeasible_models = setdiff(fieldnames(vehicle_models), feasible_models);
        for i = 1:length(infeasible_models)
            infeasible_model = infeasible_models{i};        

            if isfield(vehicle_models, infeasible_model)
                % Increase the infeasible count by 1
                vehicle_models.(infeasible_model).infeasible = vehicle_models.(infeasible_model).infeasible + 1;
            end
        end        
    
    end

    % For Multicopter and Solar UAV
   [feasible_var_avg, corrrected_vehicle_models] = feasibilityCountCorrection();
        
   %%%% Plots %%%%
    
    % Combined Feasibility Counts
    X = categorical({'Feasible', 'Infeasible'});
    Y = [feasible_count, infeasible_count];
    colors =[ 0, 0.75, 0.75; 0.9, 0.3, 0.3];  % Color code: feasible (blue) and infeasible (red)
    
    figure;
    b = bar(X, Y);
    b.FaceColor = 'flat';
    b.CData = colors;
    
    xlabel('Combined Vehicle Models');
    ylabel('Count');
    title('Feasibility Count based on Coordinated Analysis');


    % Individual Feasibility Counts
    vehicleNames = fieldnames(corrrected_vehicle_models);
    labels =  strrep(vehicleNames, '_', ' ');
    feasibleCounts = zeros(1, numel(vehicleNames));
    infeasibleCounts = zeros(1, numel(vehicleNames));
    for i = 1:numel(vehicleNames)
        feasibleCounts(i) = corrrected_vehicle_models.(vehicleNames{i}).feasible;
        infeasibleCounts(i) = corrrected_vehicle_models.(vehicleNames{i}).infeasible;
    end

    % Prepare data for plotting
    data = [feasibleCounts; infeasibleCounts]';
    tealColor =  [0, 0.75, 0.75];
    redColor = [0.9, 0.3, 0.3];
    % Create bar plot
    figure;
    barHandle = bar(data, 'grouped');
    set(barHandle(1), 'FaceColor', [0, 0.75, 0.75], 'EdgeColor', tealColor); % Bright Teal
    set(barHandle(2), 'FaceColor', [0.9, 0.3, 0.3],'EdgeColor',redColor); % Complementary Red
    
    % Customize the plot
    % xticks(1:numel(vehicleNames));
    xticklabels(labels);
    legend('Feasible', 'Infeasible');
    ylabel('Count');
    xlabel('Vehicle Models');
    title('Feasibility Count for Vehicle Models');
    
    %%%%%%% PDF FOR ALITTUDE AND AIRSPEED OF FEASIBLE TRAJECTORIES %%%%%%%
    % Plot PDF for Altitude
    [f_altitude, x_altitude] = ksdensity( feasible_var_avg.altitude);
    figure; % Create new figure
    plot(x_altitude, f_altitude, 'Color',tealColor);
    xlabel('Altitude (ft)');
    ylabel('Probability Distribution');
    title('PDF of Average Altitude for Feasible Trajectorie');
    
    % Plot PDF for Speed
    [f_speed, x_speed] = ksdensity(feasible_var_avg.speed);
    figure; % Create new figure
    plot(x_speed, f_speed, 'Color',tealColor);
    xlabel('Airspeed (ft/s)');
    ylabel('Probability Distribution');
    title('PDF of Average Speed for Feasible Trajectories');
    

    avg_speed = x_speed %feasible_var_avg.speed;
    [probabilities, edges] = histcounts(avg_speed, 'Normalization', 'probability');
    binCenters = edges(1:end-1) + diff(edges)/2;
    
    fig3 = figure;
    bar(binCenters, probabilities, 1, 'FaceColor', [0.0745, 0.5529, 0.4588], 'EdgeColor', [0.7490, 0.7882, 0.7922]);
    title('Ownship Speed Distribution');
    xlabel('Speed (Knots)');
    ylabel('Probability');
    grid on;
    
    
end

% %---------------------------------------------------------------------------------------
%     labels =  strrep(type_labels, '_', ' ');
%     custom_colors = [0 .5 .5;  % teal for 'Hybrid'
%                  0.4940 0.1840 0.5560;  % purple for 'Fixed-Wing'
%                  1 0.498 0.314];  % red for 'Rotorcraft'
%     largestTrackNum = max(type_counts);
%     y_lim = [0, largestTrackNum+10];
% 
% 
%     % Create categorical X axis
%     X = categorical(labels);
%     X = reordercats(X, labels);
%     
%     % Create the bar graph with custom colors
%     figure;
%     b = bar(X,type_counts);
%     hold on;
%     b.FaceColor = 'flat';
%     b.CData = custom_colors;
%     
%     % Create dummy bars for the legend with matching colors
%     bh(1) = bar(nan, nan);
%     bh(2) = bar(nan, nan);
%     bh(3) = bar(nan, nan);
%     bh(1).CData = custom_colors(1, :);
%     bh(2).CData = custom_colors(2, :);
%     bh(3).CData = custom_colors(3, :);
%     
%     % Set the colorbar
%     colormap(custom_colors);
%     
%     % Set the color limits of the colorbar to match the range of values
%     caxis([min(type_counts), max(type_counts)]);% 
%     % Create the dummy bar plot for the legend
%     nColors = size(custom_colors, 1);
%     hBLG = bar(nan(2, nColors));
%     
%     % Set the face colors of the legend bars
%     for i = 1:nColors
%         hBLG(i).FaceColor = custom_colors(i, :);
%     end
%     
%     % Create the legend
%     legend(hBLG,  labels, 'location', 'northeast');
%     ylim(y_lim);
%     title('Number of Feasible Tracks for Each Aircraft Class')
%     xlabel('Aircraft Type')
%     ylabel('Feasible Tracks Per Aircraft Class')
% 
%         
% %     Set the figure size
% %     b.Parent.Position(3) = 0.55;
% %     
% %     % Set the color limits of the colorbar to match the range of values
% %     caxis([min(type_counts), max(type_counts)]);
% %     
% %     % Associate the colormap with the same colors as the bars
% %     colormap(custom_colors);
% %     
% %     % Create the colorbar
% %     cb = colorbar();
% %     
% %     % Set colorbar ticks and labels
% %     cb.Ticks = linspace(min(type_counts), max(type_counts), numel(type_labels));
% %     cb.TickLabels = type_labels;
% %     cb.FontSize = 8;    
% 
% %------------------------------------------------------------
% 
%     labels = strrep(model_labels, '_', ' ');
%     custom_colors = [0 .5 .5;  % teal for 'Hybrid'
%                  0.4940 0.1840 0.5560;  % purple for 'Fixed-Wing'
%                  1 0.498 0.314; 0 0.4470 0.7410;];  % Colar for 'Rotorcraft'
% 
%     largestTrackNum = max(model_counts);
%     y_lim = [0, largestTrackNum+10];
%     % Create categorical X axis
%     X = categorical(labels);
%     X = reordercats(X, labels);
%     
%     % Create the bar graph with custom colors
%     figure;
%     b = bar(X,model_counts);
%     hold on;
%     b.FaceColor = 'flat';
%     b.CData = custom_colors;
%     
%     % Create dummy bars for the legend with matching colors
%     bh(1) = bar(nan, nan);
%     bh(2) = bar(nan, nan);
%     bh(3) = bar(nan, nan);
%     bh(4) = bar(nan, nan);
%     bh(1).CData = custom_colors(1, :);
%     bh(2).CData = custom_colors(2, :);
%     bh(3).CData = custom_colors(3, :);
%     bh(4).CData = custom_colors(4, :);
%     
%     % Set the colorbar
%     colormap(custom_colors);
%     
%     % Set the color limits of the colorbar to match the range of values
%     caxis([min(model_counts), max(model_counts)]);% 
%     % Create the dummy bar plot for the legend
%     nColors = size(custom_colors, 1);
%     hBLG = bar(nan(2, nColors));
%     
%     % Set the face colors of the legend bars
%     for i = 1:nColors
%         hBLG(i).FaceColor = custom_colors(i, :);
%     end
%     
%     % Create the legend
%     legend(hBLG,  labels, 'location', 'northeast');
%     ylim(y_lim)
%     title('Number of Feasible Tracks for Each UAS Model')
%     xlabel('UAS Model')
%     ylabel('Feasible Tracks Per UAS Model')
% %----------------------------------------------------------------
% 
% 
% X = categorical({'Feasible', 'Infeasible'});
% Y = [feasible_count, infeasible_count];
% colors = [0 0.4470 0.7410; 0 .5 .5];  % Color code: feasible (blue) and infeasible (red)
% 
% figure;
% b = bar(X, Y);
% b.FaceColor = 'flat';
% b.CData = colors;
% 
% xlabel('Feasbility');
% ylabel('Count');
% title('Feasible and Infeasible Track Counts');



