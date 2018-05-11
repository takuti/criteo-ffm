#! /usr/bin/env python
import sys
import random

input_file = sys.argv[1]

output_file_tr = sys.argv[2]
f_tr = open(output_file_tr, 'w')

output_file_va = sys.argv[3]
f_va = open(output_file_va, 'w')

for line in open(input_file):
    if random.random() < 0.2:
        f_tr.write(line)
    else:
        f_va.write(line)

f_tr.close()
f_va.close()
