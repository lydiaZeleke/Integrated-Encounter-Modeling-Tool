function [closingSpeedAtDWC, speedAtDWCOwn, speedAtDWCInt, altitudeAtDWCOwn, altitudeAtDWCInt] = dwc_loss_parameters(ownship, intruder, isIntSuas)
    
    if nargin < 3
        isIntSuas = false;
    end

    % Initialize outputs
    closingSpeedAtDWC = NaN;
    speedAtDWCOwn = NaN;
    speedAtDWCInt = NaN;
    altitudeAtDWCOwn = NaN;
    altitudeAtDWCInt = NaN;
    
    % Assume AvoidFlag is set to 1 at DWC violation points
    DWC_SPEC = [4000, 450]; %[DWC Horizontal Separation, DWC Vertical Separation]
    hmd_ft = hypot(ownship.north_ft - intruder.north_ft, ownship.east_ft - intruder.east_ft);
    vmd_ft = abs(abs(ownship.up_ft)- abs(intruder.up_ft));
    
    % Identify those in VMD and HMD conflict
    lhmd = hmd_ft <= DWC_SPEC(1);
    lvmd = vmd_ft <= DWC_SPEC(2);

    violationIndices = find(lhmd & lvmd);
  
    
    if ~isempty(violationIndices)
        % Get the index of the first DWC violation
        violationIdx = violationIndices(1);
        
        % Compute the speed of the ownship and intruder at the DWC violation point
        speedAtDWCOwn = ownship.speed_ftps(violationIdx);
        speedAtDWCInt = intruder.speed_ftps(violationIdx);
        altitudeAtDWCOwn = ownship.up_ft(violationIdx);
        altitudeAtDWCInt = intruder.up_ft(violationIdx);
        
        %%%% temporary %%%
%         if isIntSuas && altitudeAtDWCInt > 5500
%            disp('int altitude higher')
%            altitudeAtDWCInt = randi([4500, 5200]);
%         end
% 
%         if isIntSuas && altitudeAtDWCOwn > 5600
%            disp('own altitude higher')
%            altitudeAtDWCOwn = randi([4500, 5300]);
%         end
% 
%         if isIntSuas && altitudeAtDWCInt < -450
%            disp('int altitude lower')
%            altitudeAtDWCInt = randi([-450, 0]);
%         end
%         
%         if isIntSuas && speedAtDWCInt > 100
%             speedAtDWCInt = sqrt(intruder.Ndot_ftps(violationIdx)^2 + intruder.Edot_ftps(violationIdx)^2 + intruder.hdot_ftps(violationIdx)^2);            
%         end

        %%%%%-------------------%%%%%%%%%%%%%
        % Compute the altitude of the ownship at the DWC violation point
%         altitudeAtDWCOwn = ownship.altitude_ft(violationIdx);
%         altitudeAtDWCInt = ownship.altitude_ft(violationIdx);
       
        
        
        % Compute the relative velocity components between ownship and intruder
        relativeVelocityNorth = ownship.Ndot_ftps(violationIdx) - intruder.Ndot_ftps(violationIdx);
        relativeVelocityEast = ownship.Edot_ftps(violationIdx) - intruder.Edot_ftps(violationIdx);
        relativeVelocityUp = ownship.hdot_ftps(violationIdx) - intruder.hdot_ftps(violationIdx);
        
        % Compute the closing speed at the DWC violation point
        closingSpeedAtDWC = sqrt(relativeVelocityNorth^2 + relativeVelocityEast^2 + relativeVelocityUp^2);
    end
end
