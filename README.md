## Prepare data

```sh
./data.sh
ln -s train.csv tr.csv
ln -s test.csv te.csv
```

```sh
ln -s train.tiny.csv tr.csv
ln -s test.tiny.csv te.csv
```

## Build solver

```sh
make
```

## Create submission file

```sh
./preprocess.sh
```

```sh
./run.sh
```