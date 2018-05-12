```sh
make
hadoop fs -put tr.sp /criteo/ffm/train
hadoop fs -put va.sp /criteo/ffm/test
hive < prep.sql
```

Run `train.sql` and `predict.sql` sequentially.
