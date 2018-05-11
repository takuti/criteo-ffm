DROP TABLE IF EXISTS criteo.test_exploded;
CREATE TABLE criteo.test_exploded AS
SELECT
  t1.rowid,
  t2.i,
  t2.j,
  t2.Xi,
  t2.Xj
from
  criteo.test_vectorized t1
  LATERAL VIEW feature_pairs(t1.features, '-ffm') t2 AS i, j, Xi, Xj
;

WITH predicted AS (
  SELECT
    rowid,
    avg(score) AS predicted
  FROM (
    SELECT
      t1.rowid,
      p1.model_id,
      sigmoid(ffm_predict(p1.Wi, p1.Vi, p2.Vi, t1.Xi, t1.Xj)) AS score
    FROM
      criteo.test_exploded t1
      JOIN criteo.ffm_model p1 ON (p1.i = t1.i) -- at least p1.i = 0 and t1.i = 0 exists
      LEFT OUTER JOIN criteo.ffm_model p2 ON (p2.model_id = p1.model_id and p2.i = t1.j)
    WHERE
      p1.Wi is not null OR p2.Vi is not null
    GROUP BY
      t1.rowid, p1.model_id
  ) t
  GROUP BY
    rowid
)
SELECT
  logloss(t1.predicted, t2.label)
FROM
  predicted t1
JOIN
  criteo.test_vectorized t2
  ON t1.rowid = t2.rowid
;
