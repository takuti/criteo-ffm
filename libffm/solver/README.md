This folder provides modified version of [LIBFFM](https://github.com/guestwalk/libffm).

### Data Format

The data format of LIBFFM is:

```
<label> <field1>:<feature1>:<value1> <field2>:<feature2>:<value2> ...
.
.
.
```

`field` and `feature` should be non-negative integers.

It is important to understand the difference between `field` and `feature`. For example, if we have a raw data like this:

|Click|Advertiser|Publisher|
|:---:|:---:|:---:|
|    0    |    Nike    |    CNN |
|    1    |    ESPN    |    BBC |

Here, we have

* 2 fields: Advertiser and Publisher
* 4 features: Advertiser-Nike, Advertiser-ESPN, Publisher-CNN, Publisher-BBC

Usually you will need to build two dictionaries, one for field and one for features, like this:

```
DictField[Advertiser] -> 0
DictField[Publisher]  -> 1
```

```
DictFeature[Advertiser-Nike] -> 0
DictFeature[Publisher-CNN]   -> 1
DictFeature[Advertiser-ESPN] -> 2
DictFeature[Publisher-BBC]   -> 3
```

Then, you can generate FFM format data:

```
0 0:0:1 1:1:1
1 0:2:1 1:3:1
```

Note that because these features are categorical, the values here are all ones.
