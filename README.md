FFM on the Criteo data
===

Try to replicate the result of [Kaggle Display Advertising Challenge](https://www.kaggle.com/c/criteo-display-ad-challenge) by using the following implementations of field-aware factorization machines (FFMs):

- [LIBFFM](https://github.com/guestwalk/libffm)
- [Hivemall](https://github.com/apache/incubator-hivemall)

## Data

Download and convert the full dataset into CSV format:

```sh
./data.sh
ln -s train.csv tr.csv
ln -s test.csv te.csv
```

Or, use tiny data:

```sh
ln -s train.tiny.csv tr.csv
ln -s test.tiny.csv te.csv
```

## Usage

Move to [libffm/](./libffm/) or [hivemall/](./hivemall/) and follow the instructions.

## References

- [guestwalk/kaggle-2014-criteo](https://github.com/guestwalk/kaggle-2014-criteo)
- [chenhuang-learn/ffm](https://github.com/chenhuang-learn/ffm)
- https://gist.github.com/myui/aaeef548a17eb90c4e88f824c3ca1bcd
