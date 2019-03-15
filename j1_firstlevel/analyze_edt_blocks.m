function [] = analyze_edt_blocks()
measurements_to_analyze = {
    'EMPRO15_001_M1'; 'EMPRO15_003_M1'; 'EMPRO15_005_M1'; 'EMPRO15_006_M1';
    'EMPRO15_007_M1'; 'EMPRO15_009_M1'; 'EMPRO15_010_M1'; 'EMPRO15_011_M1'; 
    'EMPRO15_012_M1';'EMPRO15_013_M1'; 'EMPRO15_014_M1'; 'EMPRO15_015_M1'; 
    'EMPRO15_016_M1'; 'EMPRO15_018_M1'%;
%     'EMPRO15_001_M2'; 'EMPRO15_003_M2'; 'EMPRO15_005_M2'; 'EMPRO15_006_M2';
%     'EMPRO15_007_M2'; 'EMPRO15_009_M2'; 'EMPRO15_010_M2'; 'EMPRO15_011_M2'; 
%     'EMPRO15_012_M2';'EMPRO15_013_M2'; 'EMPRO15_014_M2'; 'EMPRO15_015_M2'; 
%     'EMPRO15_016_M2'; 'EMPRO15_018_M2'
    };
TRs = {'0700','1400'};

addpath(genpath('/z/fmrilab/lab/spm/spm12/'));

for s=1:size(measurements_to_analyze,1)
    name = measurements_to_analyze{s};
    for t=1:2
        for r=1:3
            tr=TRs{t}; %in ms
            [eedton, iedton, odton] = getblocks(name, tr, r);
            
            csubj=lower(name(1:end-3)); % csubj='empro15_001';
            cm=lower(name(end-1:end)); % cm='m1';
            crun = r;
            TR=(str2double(tr)/1000); % TR=0.7; in s
            
            analysisdir=['/z/fmri/data/empro15/analysis/test/analysis_edt_all_newpre/' cm '/' num2str(TR) '/run' num2str(crun) '/' csubj '/'];
            ScanFolder=['/z/fmri/data/empro15/analysis/edt/preproc/' cm '/' num2str(TR) '/run' num2str(crun) '/' csubj '/'];
            
            
            conditionnames={'eedt','iedt','odt'};
            onsets={eedton iedton odton};
            duration=20;
            
            % mtFlex_unwarped(ScanFolder,analysisdir,TR,duration,onsets,conditionnames,svbcons,normalised,jobmode)
            disp([ScanFolder, analysisdir, TR, duration, onsets, conditionnames,true,true,'serial'])
            mtFlex_unwarped(ScanFolder,analysisdir,TR,duration,onsets,conditionnames,true,true,'interactive')
            
%             for jobmode='interactive':
            y = input('Continue? ', 's');
            if y=='n'
                return
            end
            
        end
    end    
end




    function [eedton, iedton, odton] = getblocks(name, TR, r)
        % function [eedton, iedton, odton] = getblocks(name, TR, r)
        % name ... subjectname incl. measturementnumber, e.g. EMPRO15_001_M1
        % TR in {'0700', '1400'}
        % r in {1, 2, 3} .. run number
        
        % for each subject, measurement, run... e.g.
        %name = 'EMPRO15_001_M1';
        %TR = '0700'; r=2;
        
        ID = strcat('/z/fmri/data/empro15/logs/', name, '/edt_run',num2str(r),'_TR', TR, '_*');
        disp(ID);
        
        %logfilename = ls('../../logs/EMPRO15_002_M1*/edt_run1_TR0700_*'); %to account for timestamp in name
        ls(ID)
        logfilename = ls(ID);% ls(ID{1,1})
        logfilename = cellstr(logfilename);
        logfilename = logfilename{1,1};
        
        fid = fopen(logfilename, 'r');
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
