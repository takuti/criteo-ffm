DROP TABLE IF EXISTS criteo.ffm_model;
CREATE TABLE  criteo.ffm_model (
  model_id int,
  i int,
  Wi float,
  Vi array<float>
);

INSERT OVERWRITE TABLE criteo.ffm_model
SELECT
  train_ffm(
    features,
    label,
    '-init_v random -seed 43 -max_init_value 0.5 -classification -iterations 15 -factors 4 -eta 0.2 -optimizer adagrad -lambda 0.00002'
  )
FROM (
  SELECT
    features, label
  FROM
    criteo.train_vectorized
  CLUSTER BY rand(1)
) t
;
