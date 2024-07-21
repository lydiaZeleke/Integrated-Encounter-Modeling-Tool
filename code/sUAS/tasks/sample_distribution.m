function sample = sample_distribution(group)

    %%%%%%------SAMPLE WEIGHTS-------%%%%%%
    weight = 0; % MGTOW parameter, 

    if group == 0
        % Randomly choose a group
        group = randi([1, 4]);
    end

  
    class_parameters = sUAS_groups(group);
    weightRange = class_parameters.weightRange;
    weight = weightRange(1) + rand() * (weightRange(2) - weightRange(1));
    sample_weight = weight;


    %%%%%%------SAMPLE AIRSPEED-------%%%%%%
    
    maxAirspeed = class_parameters.maxSpeed;
    meanCruiseSpeed = class_parameters.meanCruiseSpeed;

    

    % (maxAirspeed, meanCruiseSpeed)
    % Estimate the standard deviation
    sigma = (maxAirspeed - meanCruiseSpeed) / 3;
    
    % Generate a sample from a standard normal distribution
    standard_sample = randn();
    
    % Scale and shift the sample to match the desired mean and standard deviation
    sample_airspeed = meanCruiseSpeed + sigma * standard_sample;
    
     %%%%%%%% ----------------------------%%%%%%%%%%%%

    sample = [sample_airspeed, sample_weight];
end
