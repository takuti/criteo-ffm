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

Move to `libffm/` or `hivemall/` and follow the instructions.

## References

- [guestwalk/kaggle-2014-criteo](https://github.com/guestwalk/kaggle-2014-criteo)
- [chenhuang-learn/ffm](https://github.com/chenhuang-learn/ffm)
- Hivemall FFM on the criteo data: https://gist.github.com/myui/aaeef548a17eb90c4e88f824c3ca1bcd