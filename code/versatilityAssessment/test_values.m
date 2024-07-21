% Define the ownship's position and heading

intruder.north_ft(i) = 0; % Ownship is at the origin
intruder.east_ft(i) = 0;
intruder.psi_rad(i) = deg2rad(90); % Heading east (90 degrees)

% Define the intruder's position and heading
ownship.north_ft(i) = -1000; % Intruder is 1000 ft behind (north) of the ownship
ownship.east_ft(i) = -500; % Intruder is 500 ft to the left (west) of the ownship's path
ownship.psi_rad(i) = deg2rad(95); % Intruder is also heading east (90 degrees)
