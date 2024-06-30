% delete(gcp('nocreate'))
% parpool;
mex -setup C++;
clear
clc
%% 请确保当前的工作区是simulation文件夹！！！
% 注意！！！ 运行此节将清除result中所有文件，如果不需要请手动注释该节，SIM脚本可以自动覆盖旧的结果
currentScriptDir = fileparts(mfilename('fullpath'));
resultFolderPath = fullfile(currentScriptDir, 'result');
if exist(resultFolderPath, 'dir') == 7
    files = dir(resultFolderPath);
    for i = 1:length(files)
        if ~files(i).isdir
            filePath = fullfile(resultFolderPath, files(i).name);
            try
                delete(filePath);
                disp(['Deleted file: ' filePath]);
            catch e
                warning('Could not delete file: %s. Reason: %s', filePath, e.message);
            end
        end
    end
else
    warning('The ''result'' folder does not exist in the current script directory.');
end

%% 
% disp('Running SIM1');
% SIM1
% disp('Running SIM2');
% SIM2
disp('Running SIM3');
SIM3