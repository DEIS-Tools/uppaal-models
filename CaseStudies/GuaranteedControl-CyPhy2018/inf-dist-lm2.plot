#!/usr/bin/gnuplot
reset
set terminal pdf enhanced # size 9cm, 5.4cm
set output "inf-dist-lm2.pdf"
set datafile separator ","
set autoscale fix
set grid
set termoption dash
# set title "Distance"
set key top center Left reverse
set tmargin at screen 0.98
#set bmargin at screen 0.15
#set lmargin at screen 0.1
set rmargin at screen 0.99

#set key off

set xrange [-23:32]
set yrange [0:150]
set xlabel "v=(velocityFront - velocityEgo)"
set ylabel "infimum: distance"

plot "inf-dist.csv" using 1:2 title "model" with points pt 6 lt rgb "black", \
     "inf-dist-lm1.csv" using 1:2 title "Quadratic regression" with lines dashtype 2 lc rgb "blue", \
     "inf-dist-lm2.csv" using 1:2 title "Qubic regression" with lines linetype 1 lc rgb "red"

# pause -1
