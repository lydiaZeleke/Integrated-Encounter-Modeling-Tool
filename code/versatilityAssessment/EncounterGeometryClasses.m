classdef EncounterGeometryClasses < int32
    enumeration
        %A. HorizontallyAmbiguous
        HeadOn (1)
        Overtaken (2)
        Overtaking (3)
        LeftObliqueOvertaking (4)
        RightObliqueOvertaking (5)
        ConvergingFromLeft (6)
        ConvergingFromRight (7)

        %B. Vertically Converging
        VerticallyConverging (8)

        %C. HorizontallyUnambiguous
        HorizontallyUnambiguous (9)

        %D. None
        Invalid (10)

    end
end
