

addpath(getenv('INTEGRATED_ENC_DIR'))
addpath(genpath([getenv('INTEGRATED_ENC_DIR') filesep 'code']))

addpath(genpath([getenv('AEM_DIR_CORE')]))
addpath(genpath([getenv('AEM_DIR_CORE') filesep 'matlab']))

addpath(genpath([getenv('AEM_DIR_BAYES') filesep 'code' filesep 'matlab']))


%ADD SUAVE LIBRARY AND ITS SUBMODULES DIRECTORY INTO MATLAB PATH

% Import  SUAVE library 
addpath(fullfile(pwd, 'library', 'SUAVE_lib', 'trunk'));
insert(py.sys.path, int32(0), fullfile(pwd,'library', 'SUAVE_lib', 'trunk'));


SUAVE = py.importlib.import_module('SUAVE'); %suave_module = ...
py.importlib.reload(SUAVE);

% If SUAVE_lib is in the same directory as the current MATLAB file, you can add it like this:
addpath(fullfile(pwd, 'library', 'SUAVE_lib', 'trunk'));

% For Python integration, insert it to py.sys.path like this:
insert(py.sys.path, int32(0), fullfile(pwd, 'SUAVE_lib', 'trunk'));

% For MATLAB, add the 'Vehicles' subdirectory to the path
addpath(fullfile(pwd, 'library', 'SUAVE_lib', 'regression', 'scripts', 'Vehicles'));
insert(py.sys.path, int32(0), fullfile(pwd, 'library','SUAVE_lib', 'regression', 'scripts', 'Vehicles'));

Tiltwing = py.importlib.import_module('Tiltwing');
