function geometry_class= find_geometry(ownship, intruder, encNum)

    % Parameters
    NMAC_SPEC = [500, 100]; %[NMAC Horizontal Separation, NMAC Vertical Separation]
    DWC_SPEC = [4000, 450]; %[DWC Horizontal Separation, DWC Vertical Separation]

    hmdAmbiguousLimit = 1000; % feet

    geometry_class= repmat({EncounterGeometryClasses.Invalid}, size(ownship.north_ft, 1), 1); % Creates a cell array with the same number of rows as A


    hmd_ft = hypot(ownship.north_ft - intruder.north_ft, ownship.east_ft - intruder.east_ft);
    
    % Calculate vertical miss distance
    vmd_ft = abs(abs(ownship.up_ft)- abs(intruder.up_ft));
    
    % Identify those in VMD and HMD conflict
    lhmd = hmd_ft <= DWC_SPEC(1);
    lvmd = vmd_ft <= DWC_SPEC(2);

    idx_lhmd = find(lhmd);
    idx_lvmd = find(lvmd);   
    idxConflicts = find(lhmd & lvmd);
    hNMAC = hmd_ft <= NMAC_SPEC(1);
    vNMAC = vmd_ft <= NMAC_SPEC(2);
    idxNMAC = find(hNMAC & vNMAC);
    if isempty(idxNMAC)
      idxNMAC = length(ownship.time);
    end
    hmdAmbig = hmd_ft(1:idxNMAC-1) < hmdAmbiguousLimit;

    if ~isempty(idxConflicts)
        if idx_lhmd(1) < idx_lvmd(1)
            geometry_class(idxConflicts) = {EncounterGeometryClasses.VerticallyConverging};
        else 
            %Horizontal distance between DWC conflict and NMAC conflict
         
            hmd_btn = hmd_ft(idxConflicts(1):idxNMAC(1)) < hmdAmbiguousLimit; 
            hmd_btn_idx = find(hmd_btn);
    
            if ~isempty(hmd_btn_idx)
%                 if encNum == 23
%                     disp('breakpoint here')
%                 end
                idxOfInterest = hmd_btn_idx(1)+idxConflicts(1)-1; %Could change
                isHeadOn = HeadOnAnalyzer(ownship, intruder,idxOfInterest);
                isOvertaken = overtakenAnalyzer(ownship, intruder,idxOfInterest);
                isOvertaking = overtakingAnalyzer(ownship, intruder,idxOfInterest);
                isLeftOblique = leftOblAnalyzer(ownship, intruder,idxOfInterest);
                isRightOblique = rightOblAnalyzer(ownship, intruder,idxOfInterest);
                isLeftConverge = leftConvAnalyzer(ownship, intruder,idxOfInterest);
                isRightConverge = rightConvAnalyzer(ownship, intruder,idxOfInterest);
                
    
                %visualizeEncounter(ownship, intruder, idxOfInterest, encNum)
                if isHeadOn
                  geometry_class(hmd_btn_idx) = {EncounterGeometryClasses.HeadOn};
                elseif isOvertaken
                  geometry_class(hmd_btn_idx) = {EncounterGeometryClasses.Overtaken};         
                elseif isOvertaking
                  geometry_class(hmd_btn_idx) = {EncounterGeometryClasses.Overtaking};
                elseif isRightOblique
                  geometry_class(hmd_btn_idx) = {EncounterGeometryClasses.RightObliqueOvertaking};
                elseif isLeftOblique
                  geometry_class(hmd_btn_idx) = {EncounterGeometryClasses.LeftObliqueOvertaking};
                elseif isLeftConverge
                  geometry_class(hmd_btn_idx) = {EncounterGeometryClasses.ConvergingFromLeft};
                elseif isRightConverge
                  geometry_class(hmd_btn_idx) = {EncounterGeometryClasses.ConvergingFromRight};     
                end
            else
               
               %idxOfInterest = idxConflicts(1);
               geometry_class(idxConflicts) = {EncounterGeometryClasses.HorizontallyUnambiguous};    
            end
        end
    else
        conc = strcat('Separation too large for DWC', '   ', 'HMD: ', string(lhmd), 'VMD: ', string(lvmd));
        disp(conc)
    end
    

end

function isHeadOn = HeadOnAnalyzer(ownship, intruder, i) 
    headOnBearingTolerance = 10; % degrees
    headOnRelativeHeadingTolerance = 10; % degrees

    relativePosition = [ownship.north_ft(i) - intruder.north_ft(i), ownship.east_ft(i) - intruder.east_ft(i)];
    
    % Calculate the bearing from the ownship to the intruder
    bearingToIntruder = atan2d(relativePosition(2), relativePosition(1));
    % Normalize the bearing
    bearingToIntruder = mod(bearingToIntruder, 360);

    % Calculate the relative heading
    relativeHeading = angleDifference(mod(rad2deg(intruder.psi_rad(i)), 360),mod(rad2deg(ownship.psi_rad(i)), 360));
    % Calculate the heading difference from head-on
    deltaHeading = abs(relativeHeading - 180);

    % Check if the encounter falls within the head-on criteria
    if abs(bearingToIntruder - rad2deg(ownship.psi_rad(i))) <= headOnBearingTolerance || ...
       abs((rad2deg(ownship.psi_rad(i))+180) - bearingToIntruder) <= headOnBearingTolerance && ...
         deltaHeading <= headOnRelativeHeadingTolerance
        %abs(bearingToIntruder - rad2deg(ownship.psi_rad(i))) >= (360 - headOnBearingTolerance)) && ...
       
        isHeadOn = true;
    else
        isHeadOn = false;
    end
end


function isOvertaken = overtakenAnalyzer(ownship, intruder, i)
    overtakenTolerance = 90; % degrees
    
    ownshipHeading = mod(rad2deg(ownship.psi_rad(i)), 360);
    intruderHeading = mod(rad2deg(intruder.psi_rad(i)), 360);
    
    % Calculate the relative position from ownship to intruder
    relativePosition = [ownship.north_ft(i) - intruder.north_ft(i), ownship.east_ft(i) - intruder.east_ft(i)];
    bearingToOwnship = atan2d(relativePosition(2), relativePosition(1));
    bearingToOwnship = mod(bearingToOwnship, 360);


    bearingToIntruder = atan2d(-relativePosition(2), -relativePosition(1));
    bearingToIntruder = mod(bearingToIntruder, 360);                                                                                                                                                                                                  


    % Check if the ownship is within ±90 degrees of the intruder's direction of travel
    isOwnshipWithinIntruderSector = abs(angleDifference(intruderHeading, bearingToOwnship)) < overtakenTolerance;
    
    % Check if the intruder is behind the ownship ±90 degrees of the ownship's direction of travel
    isIntruderBehindOwnshipSector = abs(angleDifference(ownshipHeading, bearingToIntruder)) >= overtakenTolerance;
    
    isOvertaken = isOwnshipWithinIntruderSector && isIntruderBehindOwnshipSector;


end
 
function isOvertaking = overtakingAnalyzer(ownship, intruder, i)
    
    overtakingTolerance = 90; % degrees for sector behind intruder
    relativeHeadingTolerance = 10; % degrees tolerance for relative heading

    ownshipHeading = mod(rad2deg(ownship.psi_rad(i)), 360);
    intruderHeading = mod(rad2deg(intruder.psi_rad(i)), 360);
    
    % Calculate the relative position from intruder to ownship
    relativePosition = [ownship.north_ft(i) - intruder.north_ft(i), ownship.east_ft(i) - intruder.east_ft(i)];
    bearingToOwnship = atan2d(relativePosition(2), relativePosition(1));
    bearingToOwnship = mod(bearingToOwnship, 360);


    % From ownship to intruder
    bearingToIntruder = atan2d(-relativePosition(2), -relativePosition(1));
    bearingToIntruder = mod(bearingToIntruder, 360);


    % Calculate the relative heading from the ownship to the intruder
    relativeHeading = angleDifference(intruderHeading, ownshipHeading);
    isRelativeHeadingAligned = abs(relativeHeading) <= relativeHeadingTolerance;

     % Check if the intruder is within ±90 degrees of the ownship's direction of travel
    isIntruderWithinOwnshipSector = abs(angleDifference(ownshipHeading, bearingToIntruder)) < overtakingTolerance;
    
    % Check if the ownship is behind the intruder ±90 degrees of the intruder's direction of travel
    isOwnshipBehindIntuderSector = abs(angleDifference(intruderHeading, bearingToOwnship)) >= overtakingTolerance;
    
    % Determine if it is an overtaking encounter
    isOvertaking = isRelativeHeadingAligned && isOwnshipBehindIntuderSector && isIntruderWithinOwnshipSector ;
    
end

% Helper function to compute the difference between two angles with proper wrapping
function diff = angleDifference(angle1, angle2)
    diff = mod((angle1 - angle2 + 180), 360) - 180;
end

function isLeftObliqueOvertaking = leftOblAnalyzer(ownship, intruder, i)
    % Calculate the relative position from ownship to intruder
    relativePositionIntruderToOwnship = [ownship.north_ft(i) - intruder.north_ft(i), ownship.east_ft(i) - intruder.east_ft(i)];
    relativePositionOwnshipToIntruder = -relativePositionIntruderToOwnship;

    % Calculate the bearing from the intruder to the ownship
    bearingFromIntruderToOwnship = atan2d(relativePositionIntruderToOwnship(2), relativePositionIntruderToOwnship(1));
    bearingFromOwnshipToIntruder = atan2d(relativePositionOwnshipToIntruder(2), relativePositionOwnshipToIntruder(1));

    % Normalize the bearings to a range from 0 to 360 degrees
    bearingFromIntruderToOwnship = mod(bearingFromIntruderToOwnship, 360);
    bearingFromOwnshipToIntruder = mod(bearingFromOwnshipToIntruder, 360);

    % Calculate the headings of ownship and intruder in degrees
    ownshipHeading = mod(rad2deg(ownship.psi_rad(i)), 360);
    intruderHeading = mod(rad2deg(intruder.psi_rad(i)), 360);

    % Calculate the relative bearings
    relativeBearingOfIntruder = angleDifference(bearingFromOwnshipToIntruder, ownshipHeading);
    relativeBearingOfOwnship = angleDifference(bearingFromIntruderToOwnship, intruderHeading);

    % Check if the intruder is in the left-front quadrant of the ownship
    isIntruderInLeftFrontQuadrant = relativeBearingOfIntruder > 0 && relativeBearingOfIntruder < 90;

    % Check if the ownship is in the right-rear quadrant of the intruder
    isOwnshipInRightRearQuadrant = -relativeBearingOfOwnship > 90 && -relativeBearingOfOwnship < 180;

    % Determine if it is a left oblique overtaking encounter
    isLeftObliqueOvertaking = isIntruderInLeftFrontQuadrant && isOwnshipInRightRearQuadrant;
end


function isRightObliqueOvertaking = rightOblAnalyzer(ownship, intruder, i)

    % Calculate the ownship's and intruder's headings in degrees
    ownshipHeading = mod(rad2deg(ownship.psi_rad(i)), 360);
    intruderHeading = mod(rad2deg(intruder.psi_rad(i)), 360);
    
    % Calculate the relative position from ownship to intruder
    relativePosition = [intruder.east_ft(i) - ownship.east_ft(i), intruder.north_ft(i) - ownship.north_ft(i)];
    
    % Calculate the bearing from the ownship to the intruder
    bearingFromOwnshipToIntruder = atan2d(relativePosition(1), relativePosition(2));
    bearingFromOwnshipToIntruder = mod(bearingFromOwnshipToIntruder, 360);
    
    % Calculate the bearing from the intruder to the ownship
    bearingFromIntruderToOwnship = atan2d(-relativePosition(1), -relativePosition(2));
    bearingFromIntruderToOwnship = mod(bearingFromIntruderToOwnship, 360);

    % Calculate the relative bearings
    relativeBearingOfIntruder = angleDifference(ownshipHeading, bearingFromOwnshipToIntruder);
    relativeBearingOfOwnship = angleDifference(intruderHeading, bearingFromIntruderToOwnship);

    
    % Check if the intruder is in the left-front quadrant of the ownship
    isIntruderInRightFrontQuadrantOfOwn = relativeBearingOfIntruder > 0 && relativeBearingOfIntruder < 90;

    % Check if the intruder is in the right-front quadrant of the ownship
    isOwnInLeftRearQuadrantOfInt = -relativeBearingOfOwnship > 90 && -relativeBearingOfOwnship < 180;

    % Determine if it is a left oblique overtaking encounter
    isRightObliqueOvertaking = isIntruderInRightFrontQuadrantOfOwn && isOwnInLeftRearQuadrantOfInt;

end


function isConvergingFromLeft = leftConvAnalyzer(ownship, intruder, i)
    % Calculate the relative position from ownship to intruder
    relativePosition = [intruder.north_ft(i) - ownship.north_ft(i), intruder.east_ft(i) - ownship.east_ft(i)];
    
    % Calculate the bearing from the ownship to the intruder
    bearingToIntruder = atan2d(relativePosition(2), relativePosition(1));
    % Normalize the bearing
    bearingToIntruder = mod(bearingToIntruder, 360);

    % Calculate the ownship's heading
    ownshipHeading = mod(rad2deg(ownship.psi_rad(i)), 360);

    % Relative bearing of the intruder from the ownship
    relativeBearingOfIntruder = mod(bearingToIntruder - ownshipHeading, 360);

    % Check if the intruder is to the left of the UA and in front of the UA
    isIntruderToLeftAndFrontOfUA = relativeBearingOfIntruder > 0 && relativeBearingOfIntruder < 90;

    % Check if the UA is in front of the intruder
    % For this, calculate the bearing from the intruder to the ownship
    bearingFromIntruderToUA = atan2d(-relativePosition(2), -relativePosition(1));
    bearingFromIntruderToUA = mod(bearingFromIntruderToUA, 360);

    % Relative bearing of the ownship from the intruder
    relativeBearingOfUAFromIntruder = mod(bearingFromIntruderToUA - rad2deg(intruder.psi_rad(i)), 360);
    
    % Check if the UA is in front of the intruder
    isUAInFrontOfIntruder = relativeBearingOfUAFromIntruder > 270 || relativeBearingOfUAFromIntruder < 90;

    % Check for non-head-on geometry, i.e., the relative bearing should not be around 180 degrees
    isNotHeadOnGeometry = ~(relativeBearingOfIntruder > 170 && relativeBearingOfIntruder < 190);

    % Determine if it is a converging from left encounter
    isConvergingFromLeft = isIntruderToLeftAndFrontOfUA && isNotHeadOnGeometry;
end


function isConvergingFromRight = rightConvAnalyzer(ownship, intruder, i)
    % Calculate the relative position from ownship to intruder
    relativePosition = [intruder.north_ft(i) - ownship.north_ft(i), intruder.east_ft(i) - ownship.east_ft(i)];
    
    % Calculate the bearing from the ownship to the intruder
    bearingToIntruder = atan2d(relativePosition(2), relativePosition(1));
    % Normalize the bearing
    bearingToIntruder = mod(bearingToIntruder, 360);

    % Calculate the ownship's heading
    ownshipHeading = mod(rad2deg(ownship.psi_rad(i)), 360);

    % Relative bearing of the intruder from the ownship
    relativeBearingOfIntruder = mod(bearingToIntruder - ownshipHeading, 360);

    % Check if the intruder is to the right of the UA and in front of the UA
    isIntruderToRightAndFrontOfUA = relativeBearingOfIntruder >= 270; % || relativeBearingOfIntruder <= 90;

    % Check if the UA is in front of the intruder
    % For this, calculate the bearing from the intruder to the ownship
    bearingFromIntruderToUA = atan2d(-relativePosition(2), -relativePosition(1));
    bearingFromIntruderToUA = mod(bearingFromIntruderToUA, 360);

    % Relative bearing of the ownship from the intruder
    relativeBearingOfUAFromIntruder = mod(bearingFromIntruderToUA - rad2deg(intruder.psi_rad(i)), 360);
    
    % Check if the UA is in front of the intruder
    isUAInFrontOfIntruder = relativeBearingOfUAFromIntruder > 270 || relativeBearingOfUAFromIntruder < 90;

    % Check for non-head-on geometry, i.e., the relative bearing should not be around 180 degrees
    isNotHeadOnGeometry = ~ HeadOnAnalyzer(ownship, intruder, i); %(relativeBearingOfIntruder > 150 && relativeBearingOfIntruder < 210);

    % Determine if it is a converging from right encounter
    isConvergingFromRight = isIntruderToRightAndFrontOfUA && isNotHeadOnGeometry;
end
