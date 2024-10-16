function [output,listing] = parseGeoTrajDirectory(inDir, usecase)
% Copyright 2019 - 2021, MIT Lincoln Laboratory
% SPDX-License-Identifier: BSD-2-Clause

% Input handling
if nargin < 1; inDir = [getenv('INTEGRATED_ENC_DIR') filesep 'code' filesep 'sUAS' filesep 'data' filesep 'waypoints']; end
if nargin < 2; usecase = 'all'; end

% Input directories of sUAS trajectories
listing = dir([inDir '*' filesep '*' filesep '*' filesep '*']);
listing(ismember( {listing.name}, {'.', '..'})) = [];  %remove . and ..
isShield = contains({listing.folder},'shield');
output = cellfun(@(f,n)([f filesep n]),{listing.folder},{listing.name},'UniformOutput',false)';

switch usecase
    case 'all'
        % No filtering needed
    case 'all-noshield'
        output(isShield) = [];
    case 'unconv-noshield'
        % Pairs to be used with the unconventional bayes model
        %(i.e. paragliders, gliders,)
        isCostal = contains({listing.folder},{'landuse_beach','landuse_cliff','landuse_volcano','gshhg_gshhs_resf_lvl1'});
        output(~isCostal) = [];
    case 'shield'
        output(~isShield) = [];
    case 'longlinearinfrastructure'
        islli = contains({listing.folder},{'pipeline','roads','waterway','railway','electrictransmission'});
        output(~islli) = [];
    case 'railway'
        irrail = contains({listing.folder},'railway');
        output(~irrail) = [];
    case 'agriculture'
        isAg = contains({listing.folder},{'farm','orchard','vineyard'});
        output(~isAg) = []; 
    case 'conventional' %added for the integrated encounter modeling tool purposes
        isConv = contains({listing.folder},{'farm','orchard','vineyard','pipeline','roads','waterway','railway','electrictransmission'...
            'landuse_beach','landuse_cliff','landuse_volcano'});
        output(~isConv) = [];
    otherwise
        error('usecase:unknown','Unknown use case of %s\n',usecase);
end