% opens all DCMs to get estimations, and calculates different ICC measures.
%

DCMdir = '/net/mri.meduniwien.ac.at/projects/physics/fmri/data/empro15/analysis/edt/3_dcm/V1_rFus_rAmy_1input';
subs = dir(fullfile(DCMdir, 'm1', '1.4', 'empro*'));
TRs = {'1.4', '0.7'};
ms = {'m1', 'm2'};

s=1;t=1;m=1;r=1;
%%
for s=1:length(subs)
    for t=1:2
        for m=1:2
            for r=1:3
                tmp = load(fullfile(DCMdir,ms{m}, TRs{t}, subs(s).name, ['DCM_run' num2str(r) '.mat'])); 
                EPs{s,t,m,r} = [spm_vec(tmp.Ep.A(tmp.DCM.a>0))', spm_vec(tmp.Ep.B(tmp.DCM.b>0))', spm_vec(tmp.Ep.C(tmp.DCM.c>0))'];
                EPs1{s,t,3*(m-1)+r} = [spm_vec(tmp.Ep.A(tmp.DCM.a>0))', spm_vec(tmp.Ep.B(tmp.DCM.b>0))', spm_vec(tmp.Ep.C(tmp.DCM.c>0))'];
            end
        end
    end
end


% over all subs, first run first meas first TR
% ICCsf(3,'single',cell2mat(EPs(:,1,1,1))')
% over all runs, first sub 
% ICCsf(3,'single', squeeze(cell2mat(EPs1(1,1,:)))')

% over subs
for t=1:2
    for r=1:6
        oversubs(t,r) = ICCsf(3,'single', squeeze(cell2mat(EPs1(:,t,r)))');
    end
end
        
        
% over all runs, first sub
% MEAN over measurements
for s=1:length(subs)
    for t=1:2   
        overruns(s,t) = ICCsf(3,'single', squeeze(cell2mat(EPs1(s,t,:)))');
        overmeas(s,t) = ICCsf(3,'k', [mean(squeeze(cell2mat(EPs(s,t,1,:))), 2), mean(squeeze(cell2mat(EPs(s,t,2,:))), 2)]);
    end
    for r=1:6
       overTRs(s,r) = ICCsf(3,'single',squeeze(cell2mat(EPs1(s,:,r)'))); 
    end
end

%% indices of existing connections: 
[AI,AJ]=find(tmpdcm.DCM.a)
[BI,BJ]=find(tmpdcm.DCM.b);
[CI,CJ]=find(tmpdcm.DCM.c);
connections(:,1) = [AI;BI;CI];
connections(:,2) = [AJ;BJ;CJ];


