Prepare database and tables:

```sh
hadoop fs -put tr.sp /criteo/ffm/train
hadoop fs -put va.sp /criteo/ffm/test
hive < prep.sql
```

Run `train.sql` and `predict.sql` sequentially.

`train.sql` outputs cumulative loss calculated in each iteration:

```
$ hive --hiveconf hive.root.logger=INFO,console
hive> INSERT OVERWRITE TABLE criteo.ffm_model
    > SELECT
    >   train_ffm(features, label, '-init_v random -max_init_value 1.0 -classification -iterations 15 -factors 4 -eta 0.2 -l2norm -optimizer sgd -lambda 0.00002 -cv_rate 0.0 -disable_wi')
    > FROM (
    >   SELECT
    >     features, label
    >   FROM
    >     criteo.train_vectorized
    >   CLUSTER BY rand(1)
    > ) t
    > ;
Record training examples to a file: /var/folders/rg/6mhvj7h567x_ys7brmf2bb6w0000gn/T/hivemall_fm6211397472147242886.sgmt
Iteration #2 | average loss=0.5316043797079182, current cumulative loss=843.6561505964662, previous cumulative loss=1214.5909560888044, change rate=0.30539895232450376, #trainingExamples=1587
Iteration #3 | average loss=0.5065999656968238, current cumulative loss=803.9741455608594, previous cumulative loss=843.6561505964662, change rate=0.04703575622313853, #trainingExamples=1587
Iteration #4 | average loss=0.49634490612175397, current cumulative loss=787.6993660152235, previous cumulative loss=803.9741455608594, change rate=0.0202429140731664, #trainingExamples=1587
Iteration #5 | average loss=0.48804954980765963, current cumulative loss=774.5346355447558, previous cumulative loss=787.6993660152235, change rate=0.0167128869698916, #trainingExamples=1587
Iteration #6 | average loss=0.48072518575956447, current cumulative loss=762.9108698004288, previous cumulative loss=774.5346355447558, change rate=0.015007418920848658, #trainingExamples=1587
Iteration #7 | average loss=0.47402279755334875, current cumulative loss=752.2741797171644, previous cumulative loss=762.9108698004288, change rate=0.013942244768444403, #trainingExamples=1587
Iteration #8 | average loss=0.4677507471836629, current cumulative loss=742.320435780473, previous cumulative loss=752.2741797171644, change rate=0.013231537390308698, #trainingExamples=1587
Iteration #9 | average loss=0.4618142861358177, current cumulative loss=732.8992720975427, previous cumulative loss=742.320435780473, change rate=0.012691505216375798, #trainingExamples=1587
Iteration #10 | average loss=0.4561878517855827, current cumulative loss=723.9701207837197, previous cumulative loss=732.8992720975427, change rate=0.012183326759580433, #trainingExamples=1587
Iteration #11 | average loss=0.45087834343992406, current cumulative loss=715.5439310391595, previous cumulative loss=723.9701207837197, change rate=0.01163886395675921, #trainingExamples=1587
Iteration #12 | average loss=0.4458864402438874, current cumulative loss=707.6217806670493, previous cumulative loss=715.5439310391595, change rate=0.011071508021324606, #trainingExamples=1587
Iteration #13 | average loss=0.44118468270053807, current cumulative loss=700.1600914457539, previous cumulative loss=707.6217806670493, change rate=0.010544742156271002, #trainingExamples=1587
Iteration #14 | average loss=0.4367191822212713, current cumulative loss=693.0733421851576, previous cumulative loss=700.1600914457539, change rate=0.01012161268141256, #trainingExamples=1587
Iteration #15 | average loss=0.4324248854220929, current cumulative loss=686.2582931648615, previous cumulative loss=693.0733421851576, change rate=0.009833084906727563, #trainingExamples=1587
Performed 15 iterations of 1,587 training examples on memory (thus 23,805 training updates in total)
```

`predict.sql` eventually make prediction for the validation set and evaluate the accuracy in LogLoss:

```
hive> WITH predicted AS (
    >   SELECT
    >     rowid,
    >     avg(score) AS predicted
    >   FROM (
    >     SELECT
    >       t1.rowid,
    >       p1.model_id,
    >       sigmoid(ffm_predict(p1.Wi, p1.Vi, p2.Vi, t1.Xi, t1.Xj)) AS score
    >     FROM
    >       criteo.test_exploded t1
    >       JOIN criteo.ffm_model p1 ON (p1.i = t1.i) -- at least p1.i = 0 and t1.i = 0 exists
    >       LEFT OUTER JOIN criteo.ffm_model p2 ON (p2.model_id = p1.model_id and p2.i = t1.j)
    >     WHERE
    >       p1.Wi is not null OR p2.Vi is not null
    >     GROUP BY
    >       t1.rowid, p1.model_id
    >   ) t
    >   GROUP BY
    >     rowid
    > )
    > SELECT
    >   logloss(t1.predicted, t2.label)
    > FROM
    >   predicted t1
    > JOIN
    >   criteo.test_vectorized t2
    >   ON t1.rowid = t2.rowid
    > ;
0.47604112308042346
```
