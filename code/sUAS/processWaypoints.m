
function smoothed_waypoints = processWaypoints(varargin)
    waypoints = varargin{1};
    if nargin > 1
        numPoints = varargin{2};
    else
        numPoints = 100;
    end

    % Original waypoints (x, y,z coordinates)
 
    % Parameters for B-spline interpolation
    degree = 3;     % Degree of the polynomial (cubic B-spline)
    numControlPoints = length(waypoints) + degree + 1;
    knots = [zeros(1, degree), linspace(0, 1, numControlPoints - degree), ones(1, degree)];
    
    % Create B-spline curve using spmak
    sp = spmak(knots, waypoints');
    
    % Generate points along the B-spline curve
    splinePoints = fnval(sp, linspace(0, 1, numPoints));
    smoothed_waypoints = splinePoints(:, 2:end-1)';
    % Plot original waypoints and B-spline curve
%     figure;
%     plot3(waypoints(:, 1), waypoints(:, 2), waypoints(:, 3), 'ro', 'MarkerSize', 8);
%     hold on;
%     plot3(splinePoints(1, :), splinePoints(2, :), splinePoints(3, :), 'b-', 'LineWidth', 2);
%     xlabel('X');
%     ylabel('Y');
%     zlabel('Z');
%     title('B-Spline Interpolation');
%     legend('Original Waypoints', 'B-Spline Curve');
%     grid on;
%     axis equal;
    end
