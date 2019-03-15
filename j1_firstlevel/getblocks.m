function [eedton, iedton, odton] = getblocks(name, TR, r)
% function [eedton, iedton, odton] = getblocks(name, TR, r)
% name ... subjectname incl. measturementnumber, e.g. EMPRO15_001_M1
% TR in {'0700', '1400'}
% r in {1, 2, 3} .. run number

% for each subject, measurement, run... e.g.
%name = 'EMPRO15_001_M1';
%TR = '0700'; r=2;

ID = strcat('/z/fmri/data/empro15/logs/', name, '/edt_run',num2str(r),'_TR', TR, '_*');
%         disp(ID);

%logfilename = ls('../../logs/EMPRO15_002_M1*/edt_run1_TR0700_*'); %to account for timestamp in name
%         ls(ID)
logfilename = ls(ID);% ls(ID{1,1})
logfilename = cellstr(logfilename);
logfilename = logfilename{1,1};

fid = fopen(logfilename, 'r');
disp([logfilename ', fid: ' num2str(fid)])
if fid<0
    eedton = [];
    iedton = [];
    odton = [];
else
    log = textscan(fid, repmat('%s',1,8), 'delimiter',';', 'CollectOutput',true);
    log = log{1};
    fclose(fid);
    
    % get trigger and block onsets
    trigger = 0;
    eedton = [];
    iedton = [];
    odton = [];
    
    [lines, ~] = size(log);
    for i=1:lines
        if strcmp(log(i,2),'trigger')
            trigger = str2double(log{i,1});
        elseif strcmp(log(i,2),'starting_block_eedt')
            eedton(end+1) = str2double(log{i,1}) - trigger;
        elseif strcmp(log(i,2),'starting_block_iedt')
            iedton(end+1) = str2double(log{i,1}) - trigger;
        elseif strcmp(log(i,2),'starting_block_odt')
            odton(end+1) = str2double(log{i,1}) - trigger;
        end
    end
    
    
end

end
