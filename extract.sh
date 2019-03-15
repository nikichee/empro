### script to beautify the spm result table
contrasts=( edt-odt_run1.csv edt-odt_run2.csv edt-odt_run3.csv edt-odt_run4.csv edt-odt_run5.csv edt-odt_run6.csv TR07_edt-odt_run1.csv TR07_edt-odt_run2.csv TR07_edt-odt_run3.csv TR07_edt-odt_run4.csv TR07_edt-odt_run5.csv TR07_edt-odt_run6.csv )

for con in "${contrasts[@]}"
do
  echo $con
  # $12-$14 = MNI coordinates

  if [ -e all.$con ]
  then
    rm all.$con
  fi

  if [ -e coords.txt ]
  then
    rm coords.txt
  fi

  cat $con  | awk -F, '{print $12" "$13" "$14}' > coords.txt

  line=1
  while read coords; do
    # column names in first line
    if [ "$line" -ne "0" ]
    then
      region=$(/usr/lib/afni/bin/whereami -spm -space MNI -atlas TT_Daemon $(sed -n "$line p" < coords.txt) 2> /dev/null | grep "Focus point:" | cut -c 17- | sed "s/Left /L/g" | sed "s/Right/R/g")
    else
      region="Anatomy"
      echo "$region,x,y,z,pFWE,pFDR,T,k,equivZ" >> all.$con
      line=$((line+1))
      continue
    fi

    ## test if in white matter or csf? ### ni: commented to get all resultvalues
    # if [ "$region" == "" ]
    # then
    #   continue
    # fi

    # generate the data for the new file
    tmp=$(sed -n "$line p" < $con)
    echo $tmp | awk -v region="${region}" -F, '{print region","$12","$13","$14","$7","$8","$9","$5","$10}' >> all.$con


    line=$((line+1))
  done <coords.txt

  sort -u -t, -k1,1 all.$con > new.$con

done

#cleaning
rm coords.txt

#region=$(/usr/lib/afni/bin/whereami -spm -space MNI -atlas TT_Daemon $(sed -n '14p' < coords.txt) 2> /dev/null | grep "Focus point:" | cut -c 17-)
#cat dEDT.csv | awk -v region="${region}" -F, '{print region","$12","$13","$14","$7","$8","$9","$10}'
