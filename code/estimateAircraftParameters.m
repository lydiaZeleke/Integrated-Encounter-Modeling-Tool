function track = estimateAircraftParameters(track, mdltype, est_velocity, est_angular_rate,varargin)
    default_ref = [0 0 0];
    default_type = '';
    p = inputParser;
    
    % Required
    addRequired(p,'track', @istimetable); 
    addRequired(p,'mdltype', @ischar); 
    addRequired(p,'est_velocity', @islogical);
    addRequired(p,'est_angular_rate',@islogical); 
    addOptional(p,'est_euler_angles',false, @islogical);
    addOptional(p,'ref_point',default_ref, @(x) isnumeric(x) && length(x) == 3);
    addOptional(p,'sUAS_type',default_type,@ischar); % @(x) strcmp(x, 'multirotor') || strcmp(x, 'fixed_wing'));
    
    parse(p,track, mdltype, est_velocity, est_angular_rate, varargin{:});
    est_euler_angles = p.Results.est_euler_angles;
    ref_point = p.Results.ref_point;
    est_turn_rate = true;
    sUAS_type = p.Results.sUAS_type;
    est_acc = true;


    %% Initial Setup %%
    switch(mdltype)
        case 'sUAS' %%%%% convert deg to rad %%%%
            track.heading_rad = deg2rad(track.heading_deg);
            if strcmp(sUAS_type, 'fixed_wing')
                ECEF_coords = lla2ecef(ref_point);
                X0 = ECEF_coords(1);
                Y0 = ECEF_coords(2);
                Z0 = ECEF_coords(3);
                X = X0 + track.north_ft;
                Y = Y0 + track.east_ft;
                Z = Z0 + track.alt_ft_msl;
                lla = ecef2lla([X, Y, Z]);
                track.lat_deg = lla(:,1);
                track.lon_deg = lla(:,2);
            end

        case 'bayes'
            track.heading_rad = track.psi_rad;
    end

    %%%%% convert deg to rad %%%%
    track.lat_rad = deg2rad(track.lat_deg);
    track.lon_rad = deg2rad(track.lon_deg);

    ts = seconds(diff(track.Time));
   
    %%%%%%%%%%%%%%%%%%%%%%%%%%


    if est_turn_rate %%%% Turn Rate estimation %%%

        % Calculate the differences in Heading
       heading_diff = diff(track.heading_rad);

        % Correct for heading differences greater than pi radians
        heading_diff(heading_diff > pi) = heading_diff(heading_diff > pi) - 2*pi;
        heading_diff(heading_diff < -pi) = heading_diff(heading_diff < -pi) + 2*pi;
        
        % Estimate turn rate
        turn_rate = heading_diff ./ ts;

        
        % Add the turn rate to the timetable
        % The first entry will be NaN due to the diff function
        track.turn_rate = [track.heading_rad(1); turn_rate];

    end

    if est_velocity %%%%% Add north, east and up rate parameters as well- Lydia %%%%%F
 
        %Assumes the aircraft is maintaining a constant heading and airspeed%
        track.eastRate_ftps =  (track.speed_ft_s) .* sin(track.heading_rad) ; % Conversion kt->ft/s;
        track.northRate_ftps =(track.speed_ft_s) .* cos(track.heading_rad);
        track.upRate_ftps =  track.speed_ft_s .* sin(track.theta_rad);
        
    end

    if est_acc 

        speed_acc = smoothDifferentiation(track, ["upRate_ftps"]); %Filters Noise as well  
        track.hdot_ftps2 = speed_acc(:,1);

        %if mdltype == "bayes"
        speed_acc = smoothDifferentiation(track, ["speed_ft_s"]);   
        track.vdot_ftps2 = speed_acc(:,1);
        %end
    end

    if est_euler_angles
         %%%%% Add orientation or euler angle parameters %%%%%

        ft2m = 0.3048;
       
        gs_ms = track.groundspeed_kt * 0.514444; 
        Ve_ms = track.eastRate_ftps * ft2m;
        Vu_ms = track.upRate_ftps * ft2m;
        Vn_ms = track.northRate_ftps * ft2m;
   
        track.theta_rad = atan2(Vu_ms, gs_ms);  
        track.theta_rad(track.theta_rad < 0) = track.theta_rad(track.theta_rad < 0) + 2*pi;% Yaw angle estimation % Pitch angle estimation
        track.psi_rad = atan2(Ve_ms, Vn_ms);  
        track.psi_rad(track.psi_rad < 0) = track.psi_rad(track.psi_rad < 0) + 2*pi;% Yaw angle estimation 
      
        q = zeros(1, length(track.theta_rad) - 1);
        r = zeros(1, length(track.theta_rad) - 1);
        ts = zeros(1, length(track.theta_rad) - 1);
        
        % Compute q and r using finite differences
%         theta_diff = diff(track.theta_rad);
%         phi_diff = diff(track.phi_rad);
%         roll1 = ( theta_diff .* sin(track.psi_rad) + (phi_diff .* cos(track.psi_rad)) )./gs_ms
%         track.phi_rad = [track.phi_rad(1), atan(tan(roll1))];
%         track.phi_rad(track.phi_rad < 0) = track.phi_rad(track.phi_rad < 0) + 2*pi;% % Roll angle estimation with angle-range adjustment (0-2pi)
       
        for i = 1:length(track.theta_rad)
             if i==1
               ts(i) = seconds(track.Time(i));
               q(i) = track.theta_rad(i);
               r(i) = track.psi_rad(i);
               track.phi_rad(i) = 0;
             else
                 ts(i) = seconds(track.Time(i) - track.Time(i-1));
                 q(i) = (track.theta_rad(i) - track.theta_rad(i-1)) / ts(i); % Pitch rate
                 r(i) = (track.psi_rad(i) - track.psi_rad(i-1)) / ts(i); % Yaw rate

                 roll1 = (q(i) * sin(track.psi_rad(i)) + r(i) * cos(track.psi_rad(i)))/gs_ms(i); %Ground speed is constant
                 track.phi_rad(i) = atan(tan(roll1)); % Roll angle estimatio
             end
            track.phi_rad(track.phi_rad < 0) = track.phi_rad(track.phi_rad < 0) + 2*pi;% % Roll angle estimation with angle-range adjustment (0-2pi)
        end
    end


    if est_angular_rate
        angular_rates = smoothDifferentiation(track, ["phi_rad", "theta_rad", "psi_rad"]);   
        track.thetadot_radps = angular_rates(:,2);
        track.psidot_radps = angular_rates(:,3);
        if mdltype == "bayes"
           track.phidot_radps = angular_rates(:,1);
        end      
    end

   
end


