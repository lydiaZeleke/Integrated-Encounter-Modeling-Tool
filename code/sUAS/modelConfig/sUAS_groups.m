function sUAS_group = sUAS_group_parameters(group)
    
    switch(group)
        case 1
        % Define the sUAS sUAS_groups
            sUAS_group.weightRange = [0, 4.4]; %lb
            sUAS_group.meanCruiseSpeed = 25; %kt;
            sUAS_group.maxSpeed = 40; %kt;
            sUAS_group.descend_rate = -300; % ft/min
            sUAS_group.climb_rate = 500; % ft/min

        case 2
        
            sUAS_group.weightRange = [0, 20];
            sUAS_group.meanCruiseSpeed = 20;
            sUAS_group.maxSpeed = 30;
            sUAS_group.descend_rate = -500; % ft/min
            sUAS_group.climb_rate = 700; % ft/min
        
        case 3

            sUAS_group.weightRange = [4.4, 20];
            sUAS_group.meanCruiseSpeed = 30;
            sUAS_group.maxSpeed = 60;
            sUAS_group.descend_rate = -500; % ft/min
            sUAS_group.climb_rate = 700; % ft/min

        case 4
    
            sUAS_group.weightRange = [20, 55];
            sUAS_group.meanCruiseSpeed = 60;
            sUAS_group.maxSpeed = 100;
            sUAS_group.descend_rate = -1000; % ft/min
            sUAS_group.climb_rate = 1000; % ft/min
    end
        
    % Save the sUAS sUAS_groups as a .mat file
%     save('sUAS_group_data.mat', 'sUAS_group');

end
