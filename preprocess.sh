#! /bin/sh -x

utils/count.py tr.csv > fc.trva.t10.txt

thread_num=10
converters/parallelizer-b.py -s ${thread_num} converters/pre-b.py tr.csv tr.ffm
converters/parallelizer-b.py -s ${thread_num} converters/pre-b.py te.csv te.ffm

converters/change_format.py tr.ffm tr.ffm.formatted
converters/change_format.py te.ffm te.ffm.formatted

mv tr.ffm.formatted tr.ffm
mv te.ffm.formatted te.ffm

converters/split.py tr.ffm tr.sp va.sp
