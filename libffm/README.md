## Usage

Note: This repository does not undergo GDBT-based preprocessing stage called `Pre-A` in the document.

Seek the best set of hyperparams with validation set as:

```
$ ./ffm-train -k 4 -t 15 -l 0.00002 -r 0.2 -s 10 ../tr.sp model
iter   tr_logloss      tr_time
   1      1.04980          0.0
   2      0.53771          0.0
   3      0.50963          0.0
   4      0.48980          0.1
   5      0.47469          0.1
   6      0.46304          0.1
   7      0.45289          0.1
   8      0.44400          0.1
   9      0.43653          0.1
  10      0.42947          0.1
  11      0.42330          0.1
  12      0.41727          0.1
  13      0.41130          0.1
  14      0.40558          0.1
  15      0.40036          0.1
```

```
$ ./ffm-predict ../va.sp model submission.csv
logloss = 0.47237
```

Build final model and predict probability for test data:

```
./ffm-train -k 4 -t 15 -l 0.00002 -r 0.2 -s 10 -p ../va.sp --auto-stop ../tr.ffm model
./ffm-predict ../te.ffm model submission.csv
```
