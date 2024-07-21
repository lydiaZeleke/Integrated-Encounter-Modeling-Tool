function visualizeSimulation(States,original_waypoints, interpolated_waypoints, metadata)

%%%%%%%%%%----------Plot 1----------- %%%%%%%%%%%
%     figure
%     x = -States(:,:).North;
%     y = States(:,:).East;
%     z = States(:,:).Height;
%     
%     position = [y x z];   
%     roll = States(:,:).RollAngle;
%     pitch = States(:,:).FlightPathAngle;
%     yaw = States(:,:).HeadingAngle; 
%     rotation = quaternion(eul2quat([yaw pitch roll]));
%     
%     totalPlanes = 50;
%     plotIndex = 1:floor(size(position,1)/totalPlanes):size(position,1);
%     plotTransforms(position(plotIndex,:), rotation(plotIndex,:),'MeshFilePath', 'fixedwing.stl','FrameSize',50,'InertialZDirection','Down');
%     
%     % set the axis ratios
%     pbaspect([1 1 1]);
%     daspect([1 1 1]);
%     
%     % set the grid and light
%     grid('on');
%     light('position', [1 0 1]);


%%%%%%%%%%----------Plot 2----------- %%%%%%%%%%%

 %  Plot for the originaloriginal_waypoints vs simulated states.
    % Extracting data from the States struct
    northData = States(:,:).North;
    eastData = States(:,:).East;
    heightData = States(:,:).Height;
    
    % Extracting original waypoint data
    northWaypoints = interpolated_waypoints(:, 1);
    eastWaypoints = interpolated_waypoints(:, 2);
    upWaypoints = abs(interpolated_waypoints(:, 3));

    % Plotting North, East, and Up in 3D
    fig2  = figure;
    plot3(eastData, northData, heightData, 'g-','LineWidth', 4,'DisplayName', 'Simulated States');
    hold on;
    plot3(eastWaypoints, northWaypoints, upWaypoints, 'bo-', 'DisplayName', 'Interpolated Waypoints');
%      hold on;
%     plot3(northCoords, eastCoords, upCoords, 'r-',  'DisplayName', 'Interpolatedoriginal_waypoints');
%     legend;
    xlabel('East (ft)');
    ylabel('Norths (ft)');
    zlabel('Up (ft)');
%     title('3D Trajectory in NEU');
    grid on;   

    addMetadataToFigure(fig2, metadata);

%%%%%%- ---------------------------- -- %%%%%%%%%%




% %%%%%%%%%%----------Plot 3----------- %%%%%%%%%%%
%     %Visualizeoriginal_waypoints
%     % Extract coordinates
%     northCoords =original_waypoints(:, 1);
%     eastCoords =original_waypoints(:, 2);
%     upCoords = -original_waypoints(:, 3);
%     
%     % Create a 3D plot
%     figure;
%     plot3(eastWaypoints, northWaypoints , upWaypoints, 'k-', 'LineWidth', 2, 'DisplayName', 'Interpolated Waypoints');
%     hold on;
%     plot3(eastCoords, northCoords, upCoords, 'o-', 'LineWidth', 2 ,'DisplayName', 'Original Waypoints');
%     legend;
%     grid on;
%     xlabel('East');
%     ylabel('North');
%     zlabel('Up');
%     title('Waypoint Data in NEU Coordinates');
% 
% %%%%%%- ---------------------------- -- %%%%%%%%%%

end

function addMetadataToFigure(figHandle, metadata)
    % Check if the necessary fields exist in the metadata structure
    if isfield(metadata, 'weight') && isfield(metadata, 'airspeed') && isfield(metadata, 'altitude')
        % Extract data from the metadata structure
        weight = metadata.weight;
        airspeed = metadata.airspeed;
        altitude = metadata.altitude;
        
        % Use the figure handle to ensure we are adding to the correct figure
        figure(figHandle);
        
        % Display the metadata values as text on the figure
        annotation('textbox', [0.15, 0.75, 0.1, 0.1], 'String', ['Weight: ', sprintf('%.2f', weight), ' lb'], 'FontSize', 12, 'FontWeight', 'bold', 'EdgeColor', 'none');
        annotation('textbox', [0.15, 0.7, 0.1, 0.1], 'String', ['Airspeed: ', sprintf('%.2f', airspeed), ' kt'], 'FontSize', 12, 'FontWeight', 'bold', 'EdgeColor', 'none');
        annotation('textbox', [0.15, 0.65, 0.1, 0.1], 'String', ['Altitude: ', sprintf('%.2f', altitude), ' ft'], 'FontSize', 12, 'FontWeight', 'bold', 'EdgeColor', 'none');
        
    else
        error('Metadata structure must contain fields: weight, airspeed, and altitude.');
    end
end
