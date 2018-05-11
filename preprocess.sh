#! /bin/sh -x

utils/count.py tr.csv > fc.trva.t10.txt

thread_num=10
converters/parallelizer-b.py -s ${thread_num} converters/pre-b.py tr.csv tr.ffm
converters/parallelizer-b.py -s ${thread_num} converters/pre-b.py te.csv te.ffm
