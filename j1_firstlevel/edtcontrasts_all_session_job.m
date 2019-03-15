%-----------------------------------------------------------------------
% Job saved on 20-Oct-2015 17:08:29 by cfg_util (rev $Rev: 6134 $)
% spm SPM - SPM12 (6225)
%-----------------------------------------------------------------------

clear matlabbatch;
i=1;
TRs = {'0.7','1.4'};
subs = {
        'empro15_006'
%         , 
%         'empro15_002', 'empro15_003', 'empro15_005', 'empro15_006', 'empro15_007', 'empro15_009', 'empro15_010', 'empro15_011', 'empro15_012','empro15_013', 'empro15_014', 'empro15_015', 'empro15_016', 'empro15_018'
    };


nruns=3;
nrp=18;

tst=[[1 0 -1] repmat([0],1,nrp)];


for s=1:length(subs);
    for m=1:2
        for t=2:2
            
            j=1;
            disp(['/net/mri.meduniwien.ac.at/projects/physics/fmri/data/empro15/analysis/edt/1_firstlevel/fl_session_s6/m' num2str(m) '/' TRs{t} '/run' num2str(r) '/' subs{s} '/SPM.mat']);
            matlabbatch{i}.spm.stats.con.spmmat = {['/net/mri.meduniwien.ac.at/projects/physics/fmri/data/empro15/analysis/edt/1_firstlevel/fl_session_s6/m' num2str(m) '/' TRs{t} '/' subs{s} '/SPM.mat']};
                        
            matlabbatch{i}.spm.stats.con.consess{j}.fcon.name = 'EOI';
            matlabbatch{i}.spm.stats.con.consess{j}.fcon.weights = [eye(3) zeros(3,18);
                zeros(3,9) eye(3) zeros(3,9);
                zeros(3,18) eye(3)];
            matlabbatch{i}.spm.stats.con.consess{j}.fcon.sessrep = 'none';
            j=j+1;
            
            matlabbatch{i}.spm.stats.con.consess{j}.fcon.name = 'first edt-odt';
            matlabbatch{i}.spm.stats.con.consess{j}.fcon.weights = [1 0 -1; 0 1 -1];
            matlabbatch{i}.spm.stats.con.consess{j}.fcon.sessrep = 'none';
            j=j+1;
            
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.name = 'first edt>odt'; tmp=[[1 1 -2] repmat([0],1,nrp)];
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.weights = tmp;
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.sessrep = 'none';
            j=j+1;
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.name = 'first edt<odt'; tmp=[[-1 -1 2] repmat([0],1,nrp)];
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.weights = tmp;
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.sessrep = 'none';
            j=j+1;
            
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.name = 'first eedt>odt'; tmp=[[1 0 -1] repmat([0],1,nrp)];
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.weights = tmp;
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.sessrep = 'none';
            j=j+1;
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.name = 'first eedt<odt'; tmp=[[-1 0 1] repmat([0],1,nrp)];
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.weights = tmp;
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.sessrep = 'none';
            j=j+1;
            
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.name = 'first iedt>odt'; tmp=[[0 1 -1] repmat([0],1,nrp)];
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.weights = tmp;
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.sessrep = 'none';
            j=j+1;
            
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.name = 'first iedt-odt'; tmp=[[0 -1 1] repmat([0],1,nrp)];
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.weights = tmp;
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.sessrep = 'none';
            j=j+1;
            
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.name = 'first eedt>iedt'; tmp=[[1 -1 0] repmat([0],1,nrp)];
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.weights = tmp;
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.sessrep = 'none';
            j=j+1;
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.name = 'first eedt<iedt'; tmp=[[-1 1 0] repmat([0],1,nrp)];
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.weights = tmp;
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.sessrep = 'none';
            j=j+1;
            
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.name = 'first eedt';
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.weights = 1;
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.sessrep = 'none';
            j=j+1;
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.name = 'first iedt';
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.weights = [0 1];
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.sessrep = 'none';
            j=j+1;
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.name = 'first oedt';
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.weights = [0 0 1];
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.sessrep = 'none';
            j=j+1;
            
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.name = 'edt>odt'; tmp=[[1 1 -2] repmat([0],1,nrp)];
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.weights = repmat(tmp,1,nruns);
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.sessrep = 'none';
            j=j+1;
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.name = 'edt<odt'; tmp=[[-1 -1 2] repmat([0],1,nrp)];
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.weights = repmat(tmp,1,nruns);
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.sessrep = 'none';
            j=j+1;
            
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.name = 'eedt>odt'; tmp=[[1 0 -1] repmat([0],1,nrp)];
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.weights = repmat(tmp,1,nruns);
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.sessrep = 'none';
            j=j+1;
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.name = 'eedt<odt'; tmp=[[-1 0 1] repmat([0],1,nrp)];
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.weights = repmat(tmp,1,nruns);
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.sessrep = 'none';
            j=j+1;
            
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.name = 'eedt>iedt'; tmp=[[1 -1 0] repmat([0],1,nrp)];
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.weights = repmat(tmp,1,nruns);
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.sessrep = 'none';
            j=j+1;
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.name = 'eedt<iedt'; tmp=[[-1 1 0] repmat([0],1,nrp)];
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.weights = repmat(tmp,1,nruns);
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.sessrep = 'none';
            j=j+1;
            
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.name = 'eedt'; tmp=[[1 0 0] repmat([0],1,nrp)]./nrp;
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.weights = repmat(tmp,1,nruns);
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.sessrep = 'none';
            j=j+1;
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.name = 'iedt'; tmp=[[0 1 0] repmat([0],1,nrp)]./nrp;
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.weights = repmat(tmp,1,nruns);
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.sessrep = 'none';
            j=j+1;
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.name = 'oedt'; tmp=[[0 0 1] repmat([0],1,nrp)]./nrp;
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.weights = repmat(tmp,1,nruns);
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.sessrep = 'none';
            j=j+1;
            
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.name = 'first eedt > last eedt'; tmp=[[1 0 0] repmat([0],1,nrp)];
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.weights = [tmp zeros(1,9) [-1 0 0]];
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.sessrep = 'none';
            j=j+1;
            
            %                 matlabbatch{i}.spm.stats.con.consess{j}.fcon.name = 'edt odt';
            %                 matlabbatch{i}.spm.stats.con.consess{j}.fcon.weights = [[1 1 0; 0 0 1] zeros(2,18);
            %                                                                         zeros(2,9) [1 1 0; 0 0 1] zeros(2,9);
            %                                                                         zeros(2,18) [1 1 0; 0 0 1]];
            %                                                                     % [1 1 0; 0 0 1];
            %                 matlabbatch{i}.spm.stats.con.consess{j}.fcon.sessrep = 'none';
            %                 j=j+1;
            
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.name = '2nd eedt>odt'; tmp=[[1 0 -1] repmat([0],1,nrp)];
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.weights = [zeros(1,9) tmp];
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.sessrep = 'none';
            j=j+1;
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.name = '3rd eedt>odt'; tmp=[[1 0 -1] repmat([0],1,nrp)];
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.weights = [zeros(1,18) tmp];
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.sessrep = 'none';
            j=j+1;
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.name = '2nd iedt>odt'; tmp=[[0 1 -1] repmat([0],1,nrp)];
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.weights = [zeros(1,9) tmp];
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.sessrep = 'none';
            j=j+1;
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.name = '3rd iedt>odt'; tmp=[[0 1 -1] repmat([0],1,nrp)];
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.weights = [zeros(1,18) tmp];
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.sessrep = 'none';
            j=j+1;
            
            
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.name = 'first iedt>odt'; tmp=[[0 1 -1] repmat([0],1,nrp)];
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.weights = tmp;
            matlabbatch{i}.spm.stats.con.consess{j}.tcon.sessrep = 'none';
            j=j+1;
            
            
            matlabbatch{i}.spm.stats.con.delete = 1;
            
            i=i+1;
            
        end
    end
end
spm_jobman('interactive',matlabbatch); % 'serial' or 'interactive'

