DROP TABLE IF EXISTS criteo.ffm_model;
CREATE TABLE  criteo.ffm_model (
  model_id int,
  i int,
  Wi float,
  Vi array<float>
);

INSERT OVERWRITE TABLE criteo.ffm_model
SELECT
  train_ffm(features, label, '-init_v random -max_init_value 1.0 -classification -iterations 15 -factors 4 -eta 0.2 -l2norm -optimizer adagrad -lambda 0.00002 -cv_rate 0.0 -disable_wi')
FROM (
  SELECT
    features, label
  FROM
    criteo.train_vectorized
  CLUSTER BY rand(1)
) t
;
