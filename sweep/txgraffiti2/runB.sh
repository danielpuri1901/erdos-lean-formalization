#!/bin/bash
cd "$(dirname "$0")"
if [ "$1" = climb ]; then
  for n in 12 14 16 18 20 22 24; do timeout 100 ./zf climb $n 100000000 $n > climb_$n.log 2>&1; done; echo DONE > climb_done.log
fi
if [ "$1" = sub ]; then
  for p in 0.05 0.1 0.2 0.3; do for n in 11 12 13 14 15 16 18 20 22 24 26 28; do timeout 25 ./zf2 rand $n 300000 3 $p; done; done > randsub.log 2>&1; echo DONE >> randsub.log
fi
if [ "$1" = cub ]; then
  for n in 16 18 20 22 24 26 28 30 32 34 36 40 44 48; do timeout 40 ./zf2 rand $n 2000000 7 0; done > randcubic.log 2>&1; echo DONE >> randcubic.log
fi
if [ "$1" = l8 ]; then timeout 400 ./zf3 all 8 > all8.log 2>&1; fi
if [ "$1" = ess ]; then
  for p in 0.0 0.03 0.08 0.15 0.25; do for n in 9 10 11 12 13 14 15 16 17 18; do timeout 15 ./zf3 rand $n 400000 11 $p ; done; done > ess.log 2>&1; echo DONE >> ess.log
fi
if [ "$1" = sclimb ]; then
  for n in 11 12 13 14 15 16 17 18; do timeout 50 ./zf3 sclimb $n 100000000 $n > sclimb_$n.log 2>&1; done; echo DONE > sclimb_done.log
fi
if [ "$1" = bfs ]; then
  for k in 8 9 10 11 12 13 14 15 16; do s=$(date +%s); timeout 900 ./bfsgen $k; echo "n=$k secs=$(( $(date +%s) - s ))"; done > bfs.log 2>&1; echo DONE >> bfs.log
fi
if [ "$1" = val8 ]; then
  ./bfsgen 8 dump | timeout 900 python3 validate.py 8 > val8.log 2>&1
fi
if [ "$1" = cub18 ]; then
  for k in 18 20; do s=$(date +%s); timeout 1500 ./bfsgen2 $k cubic; echo "cubic n=$k secs=$(( $(date +%s) - s ))"; done > bfscubic.log 2>&1; echo DONE >> bfscubic.log
fi
if [ "$1" = sub17 ]; then
  s=$(date +%s); timeout 1700 ./bfsgen2 17; echo "n=17 secs=$(( $(date +%s) - s ))" ; echo DONE
fi
if [ "$1" = climb2 ]; then
  for n in 14 16 18 20; do timeout 150 ./zf5 climb2 $n 100000000 $((n+100)) > climb2_$n.log 2>&1; done; echo DONE > climb2_done.log
fi
if [ "$1" = p17 ]; then
  s=$(date +%s); timeout 1800 ./bfsgen3 17 part $2 3; echo "part $2 n=17 secs=$(( $(date +%s) - s ))"; echo DONE
fi
