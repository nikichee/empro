# copied from /z/fmri/data/clu12p/analysis/pain_habituation/jobs/coregister_normalise.sh

template_dir=/z/fmrilab/lab/preprocessing/template 
for sub in ../preproc/empro15-p*
do
	for run in {run2,run3}
	do
		mean_r1=$sub/run1/meanrbadvols.nii
		mean_rx=$sub/$run/meanrbadvols.nii
		
		#Coregister run x to run 1 
		/z/fmrilab/lab/ants/bin/antsRegistration -d 3 -m MeanSquares[$mean_r1, $mean_rx, 1] -t Rigid[0.1] -c 10x100x1000 -s 4x2x0mm -f 4x2x1 -o $sub/$run/rx2r1_

		#Apply Transform to run x
		rbad=$sub/$run/rbadvols.nii
		wrbad=$sub/$run/w2rbadvols.nii
		/z/fmrilab/lab/ants/bin/antsApplyTransforms -d 3 -e 3 -i $rbad -o $wrbad -r $template_dir/t1_template_MNI_epi_space.nii -t $template_dir/3t_epi_template_Warp.nii.gz $template_dir/3t_epi_template_affine.txt $sub/r1/epi2tpl_Warp.nii.gz $sub/r1/epi2tpl_affine.txt $sub/$run/rx2r1_0GenericAffine.mat
	done
	#Apply Transform to run 1
	/z/fmrilab/lab/ants/bin/antsApplyTransforms -d 3 -e 3 -i $sub/r1/rbadvols.nii -o $sub/r1/w2rbadvols.nii -r $template_dir/t1_template_MNI_epi_space.nii -t $template_dir/3t_epi_template_Warp.nii.gz $template_dir/3t_epi_template_affine.txt $sub/r1/epi2tpl_Warp.nii.gz $sub/r1/epi2tpl_affine.txt
done
