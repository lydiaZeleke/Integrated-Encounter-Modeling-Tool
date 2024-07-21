function compute_param_PDF(statsTable, baselineDir, isCustom)

    if nargin < 3
        isCustom = false;
    end
    dividing_factor = 1.68781;

    if isCustom
        dividing_factor = 1;
    end
    if isCustom
        baselineDir = fullfile(baselineDir, 'custom');
        titleVar = 'Custom';
    else
        baselineDir = fullfile(baselineDir, 'baseline');
        titleVar = 'Benchmark';
    end
    if ~exist(baselineDir, 'dir')
        mkdir(baselineDir);
    end

    % Assuming ClosingSpeed is a discrete variable
    closingSpeeds = statsTable.ClosingSpeed/dividing_factor; % convert to knots
    [probabilities, edges] = histcounts(closingSpeeds, 'Normalization', 'probability');
    
    % The 'edges' output gives the bin edges, so the x-values for the plot
    % are taken as the midpoints of these bins
    binCenters = edges(1:end-1) + diff(edges)/2;
    % Plotting the PDF for Closing Speed
    fig1 = figure;
    bar(binCenters, probabilities, 1, 'FaceColor', [0.0745, 0.5529, 0.4588], 'EdgeColor', [0.7490, 0.7882, 0.7922]); % Width set to 1
    title(string(titleVar) + ' Closing Speed Distribution');
    xlabel('Speed (Knots)');
    ylabel('Probability');
    grid on;

    %saveas(fig1, fullfile(baselineDir, 'ClosingSpeedDistribution.jpg')); % Save as JPG
    print(fig1, fullfile(baselineDir, 'ClosingSpeedDistribution.jpg'), '-djpeg', '-r300');
    close(fig1);



    %%%%%% Estimating and plotting the PMF using Kernel Density Estimation
    fig2= figure;
    pdfRangeClosingSpeed = linspace(min(closingSpeeds), max(closingSpeeds), 100);
    [f1, x1] = ksdensity(closingSpeeds,pdfRangeClosingSpeed, 'Support', 'positive'); % Estimating the PDF
    plot(x1, f1, 'LineWidth', 2, 'Color', [0.0745, 0.5529, 0.4588]); % Blue color line for Closing Speed
    title(string(titleVar) + ' Estimated Closing Speed PDF');
    xlabel('Speed (Knots)');
    ylabel('Probability');
    grid on;
    %saveas(fig2, fullfile(baselineDir, 'ClosingSpeedLineGraph.jpg')); % Save as JPG
    print(fig2, fullfile(baselineDir, 'ClosingSpeedLineGraph.jpg'), '-djpeg', '-r300');
    close(fig2);
   

    %-------- Convert SpeedOwnship to knots and calculate discrete PDF
    speedOwnship = statsTable.SpeedOwnship / dividing_factor;
    [probabilities, edges] = histcounts(speedOwnship, 'Normalization', 'probability');
    binCenters = edges(1:end-1) + diff(edges)/2;
    
    fig3 = figure;
    bar(binCenters, probabilities, 1, 'FaceColor', [0.0745, 0.5529, 0.4588], 'EdgeColor', [0.7490, 0.7882, 0.7922]);
    title(string(titleVar) + ' Ownship Speed Distribution');
    xlabel('Speed (Knots)');
    ylabel('Probability');
    grid on;
    %saveas(fig3, fullfile(baselineDir, 'SpeedOwnship.jpg')); % Save as JPG
    print(fig3, fullfile(baselineDir, 'SpeedOwnship.jpg'), '-djpeg', '-r300');
    close(fig3);
    

    % Convert SpeedIntruder to knots and calculate discrete PDF
    speedIntruder = statsTable.SpeedIntruder / 1.68781;
    [probabilities, edges] = histcounts(speedIntruder, 'Normalization', 'probability');
    binCenters = edges(1:end-1) + diff(edges)/2;
    
    fig4 = figure;
    bar(binCenters, probabilities, 1, 'FaceColor', [0.0745, 0.5529, 0.4588], 'EdgeColor', [0.7490, 0.7882, 0.7922]);
    title(string(titleVar) + ' Intruder Speed Distribution');
    xlabel('Speed (Knots)');
    ylabel('Probability');
    grid on;
    %saveas(fig4, fullfile(baselineDir, 'SpeedIntruder.jpg')); % Save as JPG
    print(fig4, fullfile(baselineDir, 'SpeedIntruder.jpg'), '-djpeg', '-r300');
    close(fig4);
    
    

    % Estimated PDF for Intruder and Ownship Speeds
    fig5 = figure;
    pdfRangeOwnSpeed = linspace(min(speedOwnship), max(speedOwnship), 100);
    pdfRangeIntSpeed = linspace(min(speedIntruder), max(speedIntruder), 100);
    [f2, x2] = ksdensity(speedOwnship,pdfRangeOwnSpeed, 'Support', 'positive'); % Estimating the PDF
    [f3, x3] = ksdensity(speedIntruder,pdfRangeIntSpeed, 'Support', 'positive'); % Estimating the PDF
    plot(x2, f2, 'LineWidth', 2, 'Color','b'); % Blue color line for Own
    hold on 
    plot(x3, f3, 'LineWidth', 2, 'Color','r'); % Red color line for Int
    legend('Speed Ownship', 'Speed Intruder');
    title(string(titleVar) + ' Ownship Vs Intruder Speed Estimated PDF');
    xlabel('Speed (Knots)');
    ylabel('Probability');
    hold off
    %saveas(fig5, fullfile(baselineDir, 'SpeedOwnInt.jpg')); % Save as JPG
    print(fig5, fullfile(baselineDir, 'SpeedOwnInt.jpg'), '-djpeg', '-r300');
    close(fig5);
    

    % Calculate discrete PMF for AltitudeOwnship
    [probabilities, edges] = histcounts(statsTable.AltitudeOwnship, 'Normalization', 'probability');
    binCenters = edges(1:end-1) + diff(edges)/2;
    
    fig6 = figure;
    bar(binCenters, probabilities, 1, 'FaceColor', [0.0745, 0.5529, 0.4588], 'EdgeColor', [0.7490, 0.7882, 0.7922]);
    title(string(titleVar) + ' Ownship Altitude Distribution');
    xlabel('Altitude (ft)');
    ylabel('Probability');
    grid on;
    %saveas(fig6, fullfile(baselineDir, 'AltitudeOwnship.jpg')); % Save as JPG
    print(fig6, fullfile(baselineDir, 'AltitudeOwnship.jpg'), '-djpeg', '-r300');
    close(fig6);
    


    % Calculate discrete Probability Function for AltitudeIntruder
    [probabilities, edges] = histcounts(statsTable.AltitudeIntruder, 'Normalization', 'probability');
    binCenters = edges(1:end-1) + diff(edges)/2;
    
    fig7= figure;
    bar(binCenters, probabilities, 1, 'FaceColor', [0.0745, 0.5529, 0.4588], 'EdgeColor', [0.7490, 0.7882, 0.7922]);
    title(string(titleVar) + ' Intruder Altitude Distribution');
    xlabel('Altitude (ft)');
    ylabel('Probability');
    grid on;
    %saveas(fig7, fullfile(baselineDir, 'AltitudeIntruder.jpg')); % Save as JPG
    print(fig7, fullfile(baselineDir, 'AltitudeIntruder.jpg'), '-djpeg', '-r300');
    close(fig7);

     % Estimated PDF for Intruder and Ownship Altitude 
    fig8 = figure;
    pdfRangeOwnAlt = linspace(min(statsTable.AltitudeOwnship), max(statsTable.AltitudeOwnship), 100);
    pdfRangeIntAlt = linspace(min(statsTable.AltitudeIntruder), max(statsTable.AltitudeIntruder), 100);
    [f4, x4] = ksdensity(statsTable.AltitudeOwnship,pdfRangeOwnAlt); % Estimating the PDF
    [f5, x5] = ksdensity(statsTable.AltitudeIntruder,pdfRangeIntAlt); % Estimating the PDF
    plot(x4, f4, 'LineWidth', 2, 'Color','b'); % Blue color line for Own
    hold on 
    plot(x5, f5, 'LineWidth', 2, 'Color','r'); % Red color line for Int
    legend('Ownship Altitude', 'Intruder Altitude');
    title(string(titleVar) + ' Ownship Vs Intruder Altitude Estimated PDF');
    xlabel('Altitude (ft)');
    ylabel('Probability');
    
    %saveas(fig8, fullfile(baselineDir, 'AltitudeOwnInt.jpg')); % Save as JPG
    print(fig8, fullfile(baselineDir, 'AltitudeOwnInt.jpg'), '-djpeg', '-r300');
    close(fig8);


    % Plotting distribution for UniqueGeometry
    fig9 = figure;

    categoryLabels = {'HeadOn', 'Overtaken', 'Overtaking', 'LeftObliqueOvertaking', ...
                      'RightObliqueOvertaking', 'ConvergingFromLeft', 'ConvergingFromRight', ...
                      'VerticallyConverging', 'HorizontallyUnambiguous', 'Invalid'};
    
    % Convert UniqueGeometry to categorical
    categories = categorical(statsTable.UniqueGeometry, categoryLabels);
    histogram(categories, 'Normalization', 'probability', 'FaceColor', [0.0745, 0.5529, 0.4588], 'EdgeColor', [0.0745, 0.5529, 0.4588],'FaceAlpha', 1);
    title(string(titleVar) + ' Distribution of Unique Geometry Classes');
    xlabel('Geometry Class');
    ylabel('Probability');
    grid on;

    %saveas(fig9, fullfile(baselineDir, 'UniqueGeometry.jpg')); % Save as JPG
    print(fig9, fullfile(baselineDir, 'UniqueGeometry.jpg'), '-djpeg', '-r300');
    close(fig9);


end