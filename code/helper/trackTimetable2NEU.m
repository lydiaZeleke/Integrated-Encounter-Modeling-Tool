function [arrayOut, speed_ft_s] = trackTimetable2NEU(trackIn,sidx,eidx,dt,mdl,lat0_deg,lon0_deg,el0_ft_msl)
% Copyright 2019 - 2021, MIT Lincoln Laboratory
% SPDX-License-Identifier: BSD-2-Clause
%
% Converts timetables to arrays in a specific column order
%
% SEE ALSO encounterGeneration findCropIdx neu2Waypoints timetable

% Input Handling
if nargin < 2; sidx = 1; end
if nargin < 3; eidx = size(trackIn,1); end
if nargin < 4; dt = seconds(1); end

% Find colummn indicies for NEU variables
switch nargout
    case 1
        idxVar = find(contains(trackIn.Properties.VariableNames,{'north_ft','east_ft','alt_ft_msl'}));
    case 2
        idxVar = find(contains(trackIn.Properties.VariableNames,{'north_ft','east_ft','alt_ft_msl','heading_deg','speed_ft_s', 'lat_rad', 'lon_rad', 'psi_rad', 'phi_rad', 'theta_rad' ...
           'northRate_ftps', 'eastRate_ftps', 'upRate_ftps', 'psidot_radps', 'phidot_radps', 'thetadot_radps', 'vdot_ftps2', 'hdot_ftps2', 'turn_rate'}));
        idxVar = 1:length(trackIn.Properties.VariableNames);
    otherwise
        idxVar = find(contains(trackIn.Properties.VariableNames,{'north_ft','east_ft','alt_ft_msl','heading_deg','speed_ft_s', 'lat_rad', 'lon_rad','psi_rad', 'phi_rad', 'theta_rad' ...
           'northRate_ftps', 'eastRate_ftps', 'upRate_ftps','psidot_radps', 'phidot_radps', 'thetadot_radps', 'vdot_ftps2', 'hdot_ftps2','turn_rate'}));
end

% Filter track timetables
if sidx <= eidx   
    ttNEU = trackIn(sidx:1:eidx,idxVar);
else
    ttNEU = trackIn(sidx:-1:eidx,idxVar);
end

% Retime to desired timestep

if ttNEU.Properties.TimeStep ~= dt

    ttNEU = retime(ttNEU,'regular','pchip','TimeStep',dt);
end

% Have filtered NEU track to start at t=0 with positive timestep
ttNEU.Properties.StartTime = seconds(0);

% Convert timetables to arrays in a specific column order
%% Add extra parameters - Lydia

if strcmpi(mdl,'sUAS') 
    [simulatedStates, ref_point, sUAS_type] = sUASDynamicsModeling(ttNEU,lat0_deg,lon0_deg,el0_ft_msl); 
    if strcmp(sUAS_type, 'fixed_wing')
        ttNEU = estimateAircraftParameters(simulatedStates, mdl, true, true, 'ref_point', ref_point, 'sUAS_type', sUAS_type);
    else
        ttNEU = estimateAircraftParameters(simulatedStates, mdl, false, false, 'ref_point', ref_point, 'sUAS_type', sUAS_type);
    end
end 
arrayOut = [seconds(ttNEU.Time), ttNEU.north_ft, ttNEU.east_ft, ttNEU.alt_ft_msl, ttNEU.northRate_ftps, ttNEU.eastRate_ftps, ttNEU.upRate_ftps...
            ttNEU.theta_rad, ttNEU.psi_rad, ttNEU.phi_rad, ttNEU.thetadot_radps, ttNEU.psidot_radps, ttNEU.phidot_radps, ttNEU.lat_rad, ttNEU.lon_rad, ttNEU.vdot_ftps2,ttNEU.hdot_ftps2,...
            ttNEU.turn_rate];


% Output speed as optional output
if nargout > 1
    speed_ft_s = ttNEU.speed_ft_s;
end
