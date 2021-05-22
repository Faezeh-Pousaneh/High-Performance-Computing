#!/bin/bash 
#!/usr/local/bin/gnuplot -persist



array=( 16 17 18 19 20)

for j in "${array[@]}"
do

cp -r V15 V$j

cd V$j

Z=3.50000

echo "scale=5;($Z+$j*0.3)*1.817" | bc > p.dat
Z=`tail -1  p.dat  | awk '{print $1}'`



sed "s/B=14.53600/B=$Z/" V_0.266.sh -i
cd ..
done
