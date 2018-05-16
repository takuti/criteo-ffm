## Usage

Note: This repository does not undergo GDBT-based preprocessing stage called `Pre-A` in the document.

Seek the best set of hyperparams with validation set as:

```sh
./ffm-train -k 4 -t 15 -l 0.00002 -r 0.2 -s 10 -p ../va.sp --cumulative-loss ../tr.sp model
```

Build final model and predict probability for test data:

```sh
./ffm-train -k 4 -t 15 -l 0.00002 -r 0.2 -s 10 --cumulative-loss ../tr.ffm model
./ffm-predict ../te.ffm model submission.csv
```
