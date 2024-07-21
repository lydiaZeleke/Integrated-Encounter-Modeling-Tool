function fig_feasbility =  plotTrackFeasbility(trackFeasbilityTrace)
    
    % Assuming our array of container maps for track feasiblity-trackFeasbilityTrace
    numTracks = numel(trackFeasbilityTrace);
    feasibilities = false(1, numTracks);  % Preallocate logical array for feasibility
    tracks = cell(1, numTracks); % Preallocate cell array for tracks
    
    for ii = 1:numTracks
        map = trackFeasbilityTrace{ii};
        tracks{ii} = map('track');  % Store track timetables in a cell array
        feasibilities(ii) = map('isFeasible');  % Store feasibility in a logical array
    end
    
    % Set the colors for feasible and infeasible tracks
    colorFeasible = 'blue';
    colorInfeasible = 'red';
    
    for ii = 1:numTracks 
        track = tracks{ii};  % Get the current track
        lat = track.lat_deg;  % Assuming your timetable has 'lat_deg' for latitude
        lon = track.lon_deg;  % Assuming your timetable has 'lon_deg' for longitude
        % figure %% Interesting phenomenon where each track is separately
        % represented
        if feasibilities(ii)  % If the track is feasible
            geoplot(lat, lon, 'Color', colorFeasible);
        else  % If the track is not feasible
            geoplot(lat, lon, 'Color', colorInfeasible);
        end
        hold on; 
    end
    
    hold off;  % Stop allowing multiple plots on the same axes

end