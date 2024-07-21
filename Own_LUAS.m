

% Aircraft type considerations
rng('shuffle');
mdl2_type= {'sUAS', 'bayes'}; 
bayes_type = {'largeUAS', 'manned'};
isLargeUAS = struct('mdl1', true, 'mdl2', false);

% Tradespace
tradespace = CreateTradespacePairingGeo('mdlType1','bayes','mdlType2',mdl2_type,...
    'thresHorz_ft',2200,'thresVert_ft',450,...
    'dofMaxRange_ft',[500],'dofMaxVert_ft',[500],...
    'conflictTime_s',[60, 60:30:210, 60:30:180]','encTime_s',[(30:30:210)+30, (60:30:180)+60]');

   
% Remove repeated rows in the tradespace   
allColumnNames = tradespace.Properties.VariableNames;
columnsToUse = ~strcmp(allColumnNames, 'configId');
filteredTable = tradespace(:, columnsToUse);
[uniqueRowsFiltered, ia] = unique(filteredTable, 'rows');
tradespace = tradespace(ia, :);


tradespace = sortrows(tradespace,{'dofMaxRange_ft','encTime_s'});
        
% Get the current date and time
currentDateTime = datetime('now', 'Format', 'yyyy-MM-dd_HH-mm-ss');

% Parent output directory
rootFullPath = mfilename('fullpath');
[rootCurDir, ~,~]= fileparts(rootFullPath);
rootOutDir = [rootCurDir filesep 'output' filesep 'encounter_set' filesep 'Own_LUAS' filesep datestr(currentDateTime, 'yyyy-mm-dd_HH-MM-ss')];

for i=1:length(mdl2_type)

    if strcmp({'sUAS'}, mdl2_type(i)) 
        tradespace = tradespace(strcmp(tradespace.mdlType2, mdl2_type(i)) | strcmp(tradespace.mdlType2, 'sUAS'), :); 
    else
        tradespace = tradespace(~strcmp(tradespace.mdlType2, {'sUAS'}) & ~strcmp(tradespace.mdlType2, 'sUAS'), :);
    end
    % RUN_1 parameters
    anchorRange_nm = 1.00;

    if mdl2_type{i} == "bayes"
      usecase = 'uncor_uncor';
      bayes_num = randi(length(bayes_type));
      if bayes_num == 1 % If the Bayes Model will be used for Large UAS Modeling
          isLargeUAS.mdl2 = true;
      else 
          isLargeUAS.mdl2= false;
      end
    else
      usecase = 'conventional'; % so that trajectories representing all  sUAS usecases
      %tradespace= tradespace(~contains(tradespace.bayesFile1, 'uncor_1200code_v2p1'), :); %Filter out the RADES uncorrelated model for low altitude manned trajectories
    
    end

    seedGen = 1;
    
    % Other parameter not defined in tradespace table
    dem = 'globe';
    
    %% Suppress warning
    warning('off','map:io:UnableToDetermineCoordinateSystemType')
    
    %% Tradespace tasks
    [tasks, anchors,initialSeeds] = CreateTasksPairingGeo(tradespace,anchorRange_nm,usecase,seedGen);
    
    %% Save tradespace
    [~, ~, ~] = mkdir(rootOutDir);
    save([rootOutDir filesep 'tradespace.mat'],'tradespace','tasks');
    
    %% Create status table to record performance                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
    status = table( tradespace.configId,zeros(size(tradespace,1),1),zeros(size(tradespace,1),1),'VariableNames',{'tradespaceId','workTime_s','nEncounters'});

    %%%%%%%% REMOVE REPEATED CONFIGID IN TASKS LIST %%%%%%
%     [~, idx] = unique(tasks.configId, 'stable');
%     tasks = tasks(idx,:);
               %%%%%%%%%%%%%%%%%%%%%

        %% Iterate over tasks
        for ii=1:1:size(tasks,1)
            % Start timer
            tic
            
            % Display status
            fprintf('Starting task global id %i\n',ii);
            
            % Filter anchors
            iiAnchors = anchors(tasks.sidx(ii):tasks.eidx(ii),:);
            
            iiGlobal = tasks.globalId(ii);
            iiConfig = tasks.configId(ii);
             
            % Tradespace idx
            idxTS = find( tradespace.configId == iiConfig);
 
            % Create output directory
            outHash = sprintf('%04.f_%07.f',iiConfig,iiGlobal);
            
            % Create a folder name that includes the timestamp
            encOutDir = [rootOutDir filesep sprintf('%04.f',iiConfig)];
            % Create the folder if it doesn't exist
            if ~exist(encOutDir, 'dir')
                [~, ~, ~] =  mkdir(encOutDir);
            end

        
            % Create encounters
            metadata = encounterGeneration(iiAnchors,ii,...
                tradespace.encTime_s(idxTS,:),tradespace.thresHorz_ft(idxTS,:),tradespace.thresVert_ft(idxTS,:), encOutDir, ...
                'bayesFile1',tradespace.bayesFile1{idxTS},...
                'bayesFile2',tradespace.bayesFile2{idxTS},...
                'conflictTime_s',tradespace.conflictTime_s(idxTS,:),...
                'dofMaxRange_ft',tradespace.dofMaxRange_ft(idxTS,:),...
                'dofMaxVert_ft',tradespace.dofMaxVert_ft(idxTS,:),...
                'initHorz_ft',tradespace.initHorz_ft(idxTS,:),...
                'initVert_ft',tradespace.initVert_ft(idxTS,:),...
                'mdlType1',tradespace.mdlType1(idxTS,:),...
                'mdlType2',char(tradespace.mdlType2(idxTS,:)),...
                'dem',dem,...
                'initialSeed',initialSeeds(ii),...
                'outHash',outHash,...
                'isGeoPointOverride',true,...
                'isSampleAlt1',true,...
                'isStartEndNonZero1',true,...
                'isZip',false, ...
                'plotUAS',true,... %turn on plot for large UAS
                'bayesType', isLargeUAS);
            %         'bayesFile2',tradespac                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    e.bayesFile2{idxTS},...
        
        
            % Record performance
            workTime_s = toc;
            nEncounters = size(metadata,1);
            
            % Save to status table
            status.workTime_s(ii) = workTime_s;
            status.nEncounters(ii) = nEncounters;
            
            save([encOutDir filesep 'metadata_' outHash '.mat'],'metadata','workTime_s','nEncounters','ii','iiAnchors');
        end
end

%% Save Display status to screen
save([rootOutDir filesep 'tradespace.mat'],'status','-append');
warning('on','all')
disp('Done!');
