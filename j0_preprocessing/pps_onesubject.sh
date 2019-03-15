#!/bin/bash
worker=8/:
threads="8"
job=$(readlink -f 7t_task_distortion_correction_multiband.job)



for m in m1 m2
do
	for t in 1.4 0.7
	do	
			
		CMD="rsbatch -A subject=empro15_006 -A measurementnumber=$m -A TR=$t -A run={} -j $job --threads=$threads -s 1-7,11-14" # 1-7,11-14 need to be left out after normalizing, or 7-100 before
		echo "run1 run2 run3" | sed -e 's/ /\n/g' | parallel -j+0 --eta --joblog pps.log -S$worker $CMD 
		#echo "$CMD"
	done
done
