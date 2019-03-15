#!/bin/sh

rm -rf subjects


for m in m1 m2
do
	for t in 0.7 1.4
	do	
		for r in run1 run2 run3
		do	
			mkdir -p subjects/$m/$t/$r
			for s in $(ls ../../subjects/)
			do	
				tr=1400
				if [ "$t" = "0.7" ]
				then
  					tr=0700
				fi

				if [ -e ../../subjects/$s/$m/epi_edt_tr${tr}_$r/nifti/vols.nii ]
				then
					ln -v -s ../../../../../../subjects/$s/$m/epi_edt_tr${tr}_$r/nifti subjects/$m/$t/$r/$s
					mkdir -p preproc/$m/$t/$r/$s
				fi				
			done
		done	
	done
done

