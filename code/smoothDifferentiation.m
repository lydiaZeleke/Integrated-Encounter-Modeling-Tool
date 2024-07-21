function filtered_param = smoothDifferentiation(track, params)
        filtered_param = zeros(length(track.Time), length(params));

        % Euler angle rate Parameters using the Savitzky-Golay filter to  avoid noisy estimations
        frame_length = 11; % Must be an odd integer
        polynomial_order = 3; % Degree of the fitting polynomial
        
        % Apply the Savitzky-Golay filter for differentiation
        % First, create the Savitzky-Golay differentiation filter
        dt = mean(seconds(diff(track.Time))); % Calculate the average time step
        [b, g] = sgolay(polynomial_order, frame_length);
        fd = 1;
        HalfWin = ((frame_length + 1)/2) - 1;
        
        % Smooth the data using the Savitzky-Golay filter
        for i = 1:numel(params)
            param = params(i);
            smooth_param = sgolayfilt(double(track.(param)), polynomial_order, frame_length);          
            param_dot = conv(track.(param), factorial(fd) * g(:, fd + 1), 'same') / dt^fd; 
            
            % Remove filter delay
            param_dot = [NaN(HalfWin, 1); param_dot(frame_length - HalfWin:end - HalfWin); NaN(HalfWin, 1)];
            
            % replace NAN values with 0(for the first NAN entries) and a last nonNan
            param_dot(1:HalfWin+1) = 0;

            % entry value (for the last NAN entries)
            len = length(track.Time);
            lastnonNan = param_dot(len-HalfWin);
            param_dot(len-HalfWin:len) = lastnonNan;
            filtered_param(:,i) = param_dot;
        end
          

end