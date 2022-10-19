#!/usr/bin/bash

rm -f *.lmp

a=3.3
d=199.602
e=248.119

x=$(echo "scale=5;$d*$a/3.326" | bc)

y=$(echo "scale=5;$e*$a/3.326" | bc)

b=$(echo "scale=5;$a*sqrt(3.)/2." | bc)

atomsk --create bcc $a Nb orient [-1-12] [1-10] [111] -duplicate 49 106 2 supercell.cfg lmp

atomsk supercell.cfg -dislocation $x $y screw z y $b dis.imd

c=$(echo "scale=5;$b/2." | bc)

awk -v var="$c" 'NR==3 {$4=var} {print}' dis.imd > dis_mod.imd

atomsk dis_mod.imd -alignx screw_Nb_110_40nm_pad.xsf

atomsk screw_Nb_110_40nm_pad.xsf screw_Nb_110_40nm_pad.cfg

awk -v var="Nb" 'NR==16 {$1=var} {print}' screw_Nb_110_40nm_pad.cfg > screw_Nb_110_40nm_pad_mod.cfg

rm screw_Nb_110_40nm_pad.cfg

atomsk screw_Nb_110_40nm_pad_mod.cfg screw_Nb_110_40nm_pad.cfg lmp

rm *.cfg *.imd *.xsf supercell.lmp