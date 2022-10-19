#!/usr/bin/bash

rm -f *.lmp

a=3.3

atomsk --create bcc $a Nb orient [111] [1-10] [11-2] -duplicate 140 54 1 edge_Nb_110_top.cfg

atomsk --create bcc $a Nb orient [111] [1-10] [11-2] -duplicate 139 54 1 edge_Nb_110_bottom.cfg

atomsk edge_Nb_110_top.cfg -deform X -0.003571429 0.0 edge_Nb_110_top_deformed.cfg

atomsk edge_Nb_110_bottom.cfg -deform X 0.003597122 0.0 edge_Nb_110_bottom_deformed.cfg

atomsk --merge Y 2 edge_Nb_110_bottom_deformed.cfg edge_Nb_110_top_deformed.cfg edge_Nb_110_40nm_pad.cfg lmp

rm *.cfg