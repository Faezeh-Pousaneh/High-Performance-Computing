#!/bin/bash
#PBS -A nn9573k
#PBS -l walltime=29:30:60
#PBS -l select=4:ncpus=32:mpiprocs=16
 

module purge
module load intelcomp/17.0.0
module load mpt/2.14
module load gromacs/2016.1

case=$PBS_JOBNAME
cd $PBS_O_WORKDIR


rm NVT_vis* LL_* tcaf*
rm *#*
rm *sh.*
rm *#*

gmx convert-tpr  -s  NVT_F.tpr -extend  5000 -o NVT_F.tpr
mpiexec_mpt  mdrun   -s  NVT_F.tpr    -deffnm NVT_F -append    -cpi  NVT_F.cpt   -table Table_HS_modif.xvg


cp ../IMPUT/NVT_vis.mdp NVT_vis.mdp

sed "s/ nsteps                    =/ nsteps                    =80000000;/" NVT_vis.mdp -i
sed "s/ nstxout                   =/ nstxout                   =1000;/" NVT_vis.mdp -i
sed "s/ nstvout                   =/ nstvout                   =1000;/" NVT_vis.mdp -i


 gmx grompp  -f  NVT_vis.mdp   -c   NVT_F.gro   -p  topol.top  -o   NVT_vis.tpr   -maxwarn 3 -t  NVT.cpt
 mpiexec_mpt  mdrun   -s  NVT_vis.tpr    -deffnm NVT_vis   -table Table_HS_modif.xvg

echo 0 | gmx tcaf  -f NVT_vis.trr -s NVT_vis.tpr -normalize -b 10000  -ov  LL_4000.xvg
echo 0 | gmx tcaf  -f NVT_vis.trr -s NVT_vis.tpr -normalize -b 20000  -ov  LL_8000.xvg
echo 0 | gmx tcaf  -f NVT_vis.trr -s NVT_vis.tpr -normalize -b 30000  -ov  LL_12000.xvg
echo 0 | gmx tcaf  -f NVT_vis.trr -s NVT_vis.tpr -normalize -b 40000  -ov  LL_16000.xvg

rm *#*
rm NVT_vis.t*
rm NVT_vis.x*
rm NVT_vis.cpt
rm tcaf*
