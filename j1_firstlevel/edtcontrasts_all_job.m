%-----------------------------------------------------------------------
% Job saved on 20-Oct-2015 17:08:29 by cfg_util (rev $Rev: 6134 $)
% spm SPM - SPM12 (6225)
%-----------------------------------------------------------------------

clear matlabbatch;
i=1;
TRs = {'0.7','1.4'};
subs = {
    'empro15_001', 'empro15_002', 'empro15_003', 'empro15_005', 'empro15_007', 'empro15_009', 'empro15_010', 'empro15_011', 'empro15_012','empro15_013', 'empro15_014', 'empro15_015', 'empro15_016', 'empro15_018'
};

for s=1:length(subs);
    for m=1:2
        for t=1:2
            for r=1:3
                
                j=1;
                disp(['/net/mri.meduniwien.ac.at/projects/physics/fmri/data/empro15/analysis/edt/1_firstlevel/fl_session_s6/m' num2str(m) '/' TRs{t} '/run' num2str(r) '/' subs{s} '/SPM.mat']);
                matlabbatch{i}.spm.stats.con.spmmat = {['/net/mri.meduniwien.ac.at/projects/physics/fmri/data/empro15/analysis/edt/1_firstlevel/fl_session_s6/m' num2str(m) '/' TRs{t} '/run' num2str(r) '/' subs{s} '/SPM.mat']};
                matlabbatch{i}.spm.stats.con.consess{j}.fcon.name = 'EOI';
                matlabbatch{i}.spm.stats.con.consess{j}.fcon.weights = eye(3);
                matlabbatch{i}.spm.stats.con.consess{j}.fcon.sessrep = 'none';
                j=j+1;
                
                matlabbatch{i}.spm.stats.con.consess{j}.tcon.name = 'edt>odt';
                matlabbatch{i}.spm.stats.con.consess{j}.tcon.weights = [1  1 -2];
                matlabbatch{i}.spm.stats.con.consess{j}.tcon.sessrep = 'none';
                j=j+1;
                matlabbatch{i}.spm.stats.con.consess{j}.tcon.name = 'edt<odt';
                matlabbatch{i}.spm.stats.con.consess{j}.tcon.weights = [-1 -1 2];
                matlabbatch{i}.spm.stats.con.consess{j}.tcon.sessrep = 'none';
                j=j+1;
                
                matlabbatch{i}.spm.stats.con.consess{j}.tcon.name = 'eedt>odt';
                matlabbatch{i}.spm.stats.con.consess{j}.tcon.weights = [1 0 -1];
                matlabbatch{i}.spm.stats.con.consess{j}.tcon.sessrep = 'none';
                j=j+1;cd
                matlabbatch{i}.spm.stats.con.consess{j}.tcon.name = 'eedt<odt';
                matlabbatch{i}.spm.stats.con.consess{j}.tcon.weights = [-1 0 1];
                matlabbatch{i}.spm.stats.con.consess{j}.tcon.sessrep = 'none';
                j=j+1;
                
                matlabbatch{i}.spm.stats.con.consess{j}.tcon.name = 'eedt>iedt';
                matlabbatch{i}.spm.stats.con.consess{j}.tcon.weights = [1 -1];
                matlabbatch{i}.spm.stats.con.consess{j}.tcon.sessrep = 'none';
                j=j+1;
                matlabbatch{i}.spm.stats.con.consess{j}.tcon.name = 'eedt<iedt';
                matlabbatch{i}.spm.stats.con.consess{j}.tcon.weights = [-1 1];
                matlabbatch{i}.spm.stats.con.consess{j}.tcon.sessrep = 'none';
                j=j+1;
                
                matlabbatch{i}.spm.stats.con.consess{j}.tcon.name = 'eedt';
                matlabbatch{i}.spm.stats.con.consess{j}.tcon.weights = 1;
                matlabbatch{i}.spm.stats.con.consess{j}.tcon.sessrep = 'none';
                j=j+1;
                matlabbatch{i}.spm.stats.con.consess{j}.tcon.name = 'iedt';
                matlabbatch{i}.spm.stats.con.consess{j}.tcon.weights = [0 0 1];
                matlabbatch{i}.spm.stats.con.consess{j}.tcon.sessrep = 'none';
                j=j+1;
                matlabbatch{i}.spm.stats.con.consess{j}.tcon.name = 'oedt';
                matlabbatch{i}.spm.stats.con.consess{j}.tcon.weights = [0 0 0 0 1];
                matlabbatch{i}.spm.stats.con.consess{j}.tcon.sessrep = 'none';
                j=j+1;
                
                matlabbatch{i}.spm.stats.con.consess{j}.fcon.name = 'edt-odt';
                matlabbatch{i}.spm.stats.con.consess{j}.fcon.weights = [1 0 -1; 0 1 -1];
                matlabbatch{i}.spm.stats.con.consess{j}.fcon.sessrep = 'none';
                j=j+1;
                
                matlabbatch{i}.spm.stats.con.delete = 1;
                
                i=i+1;
            end
        end
    end
end
spm_jobman('interactive',matlabbatch); % 'serial' or 'interactive'

