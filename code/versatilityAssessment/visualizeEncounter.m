function visualizeEncounter(ownship, intruder, i, encNum)
    figure; % Open a new figure window
    
    % Heading vector scale (adjust as necessary for visibility)
    scale = 1000; 

    % Convert headings from radians to scaled vectors for plotting
    ownshipVector = [cos(ownship.psi_rad(i)) * scale, sin(ownship.psi_rad(i)) * scale];
    intruderVector = [cos(intruder.psi_rad(i)) * scale, sin(intruder.psi_rad(i)) * scale];

    % Plot the positions
    hold on; % Hold on to plot multiple items
    scatter(ownship.north_ft(i), ownship.east_ft(i), 100, 'blue', 'filled');
    scatter(intruder.north_ft(i), intruder.east_ft(i), 100, 'red', 'filled');
    
    % Plot the headings as arrows
    quiver(ownship.north_ft(i), ownship.east_ft(i), ownshipVector(1), ownshipVector(2), 'MaxHeadSize', 0.5, 'Color', 'blue', 'LineWidth', 2, 'AutoScale', 'off');
    quiver(intruder.north_ft(i), intruder.east_ft(i), intruderVector(1), intruderVector(2), 'MaxHeadSize', 0.5, 'Color', 'red', 'LineWidth', 2, 'AutoScale', 'off');
    
%     % Set the axis limits
%     maxPosition = max(abs([ownship.north_ft(i), ownship.east_ft(i), intruder.north_ft(i), intruder.east_ft(i)]));
%     axisLimits = maxPosition + scale * 1.1; % Add some buffer around the positions and vectors
%     xlim([-axisLimits, axisLimits]);
%     ylim([-axisLimits, axisLimits]);

    % Labels and title
    xlabel('North (ft)');
    ylabel('East (ft)');
    titleStr = strcat('Encounter Visualization : ', string(encNum));
    title(titleStr);
    
    % Legend
    legend('Ownship', 'Intruder', 'Location', 'best');
    
    hold off; % Release the hold on the plot
end
