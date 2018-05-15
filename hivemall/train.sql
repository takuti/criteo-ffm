DROP TABLE IF EXISTS criteo.ffm_model;
CREATE TABLE  criteo.ffm_model (
  model_id int,
  i int,
  Wi float,
  Vi array<float>
);

INSERT OVERWRITE TABLE criteo.ffm_model
SELECT
  train_ffm(features, label, '-init_v random -classification -iterations 15 -factors 4 -eta 0.2 -l2norm -optimizer sgd -lambda 0.00002 -cv_rate 0.0')
from
  criteo.train_vectorized
;
