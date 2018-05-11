#! /bin/sh -x

thread_num=10

./ffm-train -k 4 -t 18 -s ${thread_num} -p te.ffm tr.ffm model
./ffm-predict te.ffm model te.out
