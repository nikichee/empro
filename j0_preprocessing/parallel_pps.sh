#!/bin/bash
worker=48/:
threads="10"
job=$(readlink -f 7t_task_multiband.job)

#subjectsDir=$(rsbatch -j $job -V subjectsPath)
#subjects=$(ls $subjectsDir | sort | uniq)
subjects=$(cat ../subjects_names.txt)
CMD="rsbatch -A subject={} -j $job --threads=$threads -s 1-6 --quiet"

echo "$subjects" | parallel -j+0 --eta --joblog pps.log -S$worker $CMD
