## Usage

Build LIBFFM and preprocess data as the [winning solution did](https://www.csie.ntu.edu.tw/~r01922136/kaggle-2014-criteo.pdf):

```sh
make
```

Note: This repository does not undergo GDBT-based preprocessing stage called `Pre-A` in the document.

Seek the best set of hyperparams with validation set as:

```sh
./ffm-train -k 4 -t 18 -s 10 -p va.sp tr.sp model
```

Build final model and predict probability for test data:

```sh
./ffm-train -k 4 -t 18 -s 10 tr.ffm model
./ffm-predict te.ffm model submission.csv
```