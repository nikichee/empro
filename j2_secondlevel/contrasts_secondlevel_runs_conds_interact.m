

clear matlabbatch;
i=1;
sldir = 'sl_s6_TR1.4_wm_csf_flexiblefactorial';

matlabbatch{i}.spm.stats.con.spmmat = {['/net/mri.meduniwien.ac.at/projects/physics/fmri/data/empro15/analysis/edt/noDC/2_secondlevel/' sldir '/SPM.mat']}; % replace 1.4 with 0.7 or vice versa

nruns=6;
j=1; 

matlabbatch{i}.spm.stats.con.consess{j}.fcon.name = 'EOI';
matlabbatch{i}.spm.stats.con.consess{j}.fcon.weights = eye(nruns*3);
matlabbatch{i}.spm.stats.con.consess{j}.fcon.sessrep = 'none';
j=j+1;

matlabbatch{i}.spm.stats.con.consess{j}.tcon.name = 'edt>odt';
matlabbatch{i}.spm.stats.con.consess{j}.tcon.weights = repmat([1 1 -2],1,nruns);
matlabbatch{i}.spm.stats.con.consess{j}.tcon.sessrep = 'none';
j=j+1;

matlabbatch{i}.spm.stats.con.consess{j}.tcon.name = 'edt<odt';
matlabbatch{i}.spm.stats.con.consess{j}.tcon.weights = repmat([-1 -1 2],1,nruns);
matlabbatch{i}.spm.stats.con.consess{j}.tcon.sessrep = 'none';
j=j+1;

matlabbatch{i}.spm.stats.con.consess{j}.tcon.name = 'eedt>odt';
matlabbatch{i}.spm.stats.con.consess{j}.tcon.weights = repmat([1 0 -1],1,nruns); 
matlabbatch{i}.spm.stats.con.consess{j}.tcon.sessrep = 'none';
j=j+1;

matlabbatch{i}.spm.stats.con.consess{j}.tcon.name = 'eedt<odt';
matlabbatch{i}.spm.stats.con.consess{j}.tcon.weights = repmat([-1 0 1],1,nruns);
matlabbatch{i}.spm.stats.con.consess{j}.tcon.sessrep = 'none';
j=j+1;

matlabbatch{i}.spm.stats.con.consess{j}.tcon.name = 'eedt>iedt';
matlabbatch{i}.spm.stats.con.consess{j}.tcon.weights = repmat([1 -1 0],1,nruns);
matlabbatch{i}.spm.stats.con.consess{j}.tcon.sessrep = 'none';
j=j+1;

matlabbatch{i}.spm.stats.con.consess{j}.tcon.name = 'eedt<iedt';
matlabbatch{i}.spm.stats.con.consess{j}.tcon.weights = repmat([-1 1 0],1,nruns);
matlabbatch{i}.spm.stats.con.consess{j}.tcon.sessrep = 'none';
j=j+1;

matlabbatch{i}.spm.stats.con.consess{j}.tcon.name = 'eedt';
matlabbatch{i}.spm.stats.con.consess{j}.tcon.weights = repmat([1/nruns 0 0],1,nruns);
matlabbatch{i}.spm.stats.con.consess{j}.tcon.sessrep = 'none';
j=j+1;

matlabbatch{i}.spm.stats.con.consess{j}.tcon.name = 'iedt';
matlabbatch{i}.spm.stats.con.consess{j}.tcon.weights = repmat([0 1/nruns 0],1,nruns);
matlabbatch{i}.spm.stats.con.consess{j}.tcon.sessrep = 'none';
j=j+1;

matlabbatch{i}.spm.stats.con.consess{j}.tcon.name = 'oedt';
matlabbatch{i}.spm.stats.con.consess{j}.tcon.weights = repmat([0 0 1/nruns],1,nruns);
matlabbatch{i}.spm.stats.con.consess{j}.tcon.sessrep = 'none';
matlabbatch{i}.spm.stats.con.delete = 1;
j=j+1;

matlabbatch{i}.spm.stats.con.consess{j}.tcon.name = 'first eedt>odt';
matlabbatch{i}.spm.stats.con.consess{j}.tcon.weights = repmat([1 0 -1],1,1); 
matlabbatch{i}.spm.stats.con.consess{j}.tcon.sessrep = 'none';
j=j+1;

matlabbatch{i}.spm.stats.con.consess{j}.tcon.name = 'first eedt<odt';
matlabbatch{i}.spm.stats.con.consess{j}.tcon.weights = repmat([-1 0 1],1,1); 
matlabbatch{i}.spm.stats.con.consess{j}.tcon.sessrep = 'none';
j=j+1;

matlabbatch{i}.spm.stats.con.consess{j}.tcon.name = 'first eedt>iedt';
matlabbatch{i}.spm.stats.con.consess{j}.tcon.weights = repmat([1 -1 0],1,1); 
matlabbatch{i}.spm.stats.con.consess{j}.tcon.sessrep = 'none';

j=j+1;matlabbatch{i}.spm.stats.con.consess{j}.tcon.name = 'first eedt<iedt';
matlabbatch{i}.spm.stats.con.consess{j}.tcon.weights = repmat([-1 1 0],1,1); 
matlabbatch{i}.spm.stats.con.consess{j}.tcon.sessrep = 'none';
j=j+1;


matlabbatch{i}.spm.stats.con.consess{j}.tcon.name = 'first conditions';
matlabbatch{i}.spm.stats.con.consess{j}.tcon.weights = [1 1 1]; 
matlabbatch{i}.spm.stats.con.consess{j}.tcon.sessrep = 'none';
j=j+1;

matlabbatch{i}.spm.stats.con.consess{j}.fcon.name = 'first edt-odt';
matlabbatch{i}.spm.stats.con.consess{j}.fcon.weights = [1 0 -1; 0 1 -1];
matlabbatch{i}.spm.stats.con.consess{j}.fcon.sessrep = 'none';
j=j+1;

matlabbatch{i}.spm.stats.con.consess{j}.tcon.name = 'eedt first>last s1';
matlabbatch{i}.spm.stats.con.consess{j}.tcon.weights = [1 0 0 0 0 0 -1 0 0];
matlabbatch{i}.spm.stats.con.consess{j}.tcon.sessrep = 'none';
j=j+1;

matlabbatch{i}.spm.stats.con.consess{j}.tcon.name = 'eedt first>second s1';
matlabbatch{i}.spm.stats.con.consess{j}.tcon.weights = [1 0 0 -1 0 0];
matlabbatch{i}.spm.stats.con.consess{j}.tcon.sessrep = 'none';
j=j+1;

matlabbatch{i}.spm.stats.con.consess{j}.fcon.name = 'eedt-odt iedt-odt';
matlabbatch{i}.spm.stats.con.consess{j}.fcon.weights = [[1 0 -1; 0 1 -1] zeros(2,15);
    zeros(2,3) [1 0 -1; 0 1 -1] zeros(2,12)
    zeros(2,6) [1 0 -1; 0 1 -1] zeros(2,9)
    zeros(2,9) [1 0 -1; 0 1 -1] zeros(2,6)
    zeros(2,12) [1 0 -1; 0 1 -1] zeros(2,3)
    zeros(2,15) [1 0 -1; 0 1 -1]
    ];
matlabbatch{i}.spm.stats.con.consess{j}.fcon.sessrep = 'none';
j=j+1;

matlabbatch{i}.spm.stats.con.consess{j}.fcon.name = 'edt odt';
matlabbatch{i}.spm.stats.con.consess{j}.fcon.weights = [[1 1 0; 0 0 1] zeros(2,15);
    zeros(2,3) [1 1 0; 0 0 1] zeros(2,12)
    zeros(2,6) [1 1 0; 0 0 1] zeros(2,9)
    zeros(2,9) [1 1 0; 0 0 1] zeros(2,6)
    zeros(2,12) [1 1 0; 0 0 1] zeros(2,3)
    zeros(2,15) [1 1 0; 0 0 1]
    ];
matlabbatch{i}.spm.stats.con.consess{j}.fcon.sessrep = 'none';
j=j+1;


spm_jobman('interactive',matlabbatch); % 'serial' or 'interactive'
