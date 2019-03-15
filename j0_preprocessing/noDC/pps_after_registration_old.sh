#!/bin/bash
worker=48/:
threads="10"
job=$(readlink -f 7t_task_multiband.job)



for t in 1.4 0.7
do
	for m in m1 m2
	do	
		for r in run1 run2 run3
		do	
			subjectsDir=$(rsbatch -j $job -V subjectsPath -A measurementnumber=$m -A TR=$t -A run=$r)
			subjects=$(ls $subjectsDir | sort | uniq)
			CMD="rsbatch -A subject={} -A measurementnumber=$m -A TR=$t -A run=$r -j $job --threads=$threads -s 1-7,9-14"
			echo "$subjects" | parallel -j+0 --eta --joblog pps.log -S$worker $CMD 
			#echo "$CMD"

		done	
	done
done
