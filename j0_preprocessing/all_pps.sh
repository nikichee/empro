#!/bin/bash
worker=8/:

./pps_before_registration.sh

subjectsDir=/z/fmri/data/empro15/analysis/edt/subjects/m1/1.4/run1/
subjects=$(ls $subjectsDir | sort | uniq)
CMD="/z/fmri/data/empro15/analysis/normalise_job/normalise_measurements.sh {}"
echo "$subjects" | parallel -j+0 --eta -S$worker $CMD

./pps_after_registration.sh

#for s in empro15_001 empro15_002 empro15_003 empro15_004 empro15_005 empro15_006 empro15_007 empro15_009 empro15_010 empro15_011 empro15_012 empro15_013 empro15_014 empro15_015 empro15_016 empro16_018
#do
#	/z/fmri/data/empro15/analysis/normalise_job/normalise_measurements.sh $s
#done



