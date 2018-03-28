reset
set xlabel ''
set ylabel 'time(sec)'
set term png enhanced font 'Verdana,10'
set output 'runtime.png'

plot [:][:0.0015] 'cpy_bench.txt' using 1:2 with points title 'cpy', \
'ref_bench.txt' using 1:2 with points title 'ref'
