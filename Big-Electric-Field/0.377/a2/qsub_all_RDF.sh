#!/bin/bash 
#!/usr/local/bin/gnuplot -persist

array=(7 8 9 10 11 12 13 14 15 16 17 18 19 20     )

for j in "${array[@]}"
do


cd V$j
cp ../V7/RDF_V_Field.sh RDF_V_Field.sh

qsub RDF_V_Field.sh

cd ..
done
