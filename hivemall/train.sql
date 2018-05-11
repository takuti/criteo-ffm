DROP TABLE IF EXISTS criteo.ffm_model;
CREATE TABLE  criteo.ffm_model (
  model_id int,
  i int,
  Wi float,
  Vi array<float>
);

INSERT OVERWRITE TABLE criteo.ffm_model
SELECT
  train_ffm(features, label, '-c -iters 18 -factors 4')
from
  criteo.train_vectorized
;
