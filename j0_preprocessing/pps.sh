#!/bin/bash
worker=8/:
threads="4"
job=$(readlink -f 7t_distortion_correction_task_multiband.job)



for m in m1 m2
do
	for t in 0.7 1.4
	do	
		for r in run1 run2 run3
		do	
			subjectsDir=$(rsbatch -j $job -V subjectsPath -A measurementnumber=$m -A TR=$t -A run=$r)
			subjects=$(ls $subjectsDir | sort | uniq)
			CMD="rsbatch -A subject={} -A measurementnumber=$m -A TR=$t -A run=$r -j $job --threads=$threads --quiet"
			echo "$subjects" | parallel -j+0 --eta --joblog pps.log -S$worker $CMD
			#echo "$CMD"

		done	
	done
done
