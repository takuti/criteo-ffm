CREATE DATABASE IF NOT EXISTS criteo;
use criteo;

DROP TABLE IF EXISTS train;
CREATE EXTERNAL TABLE train (
  label int,
  -- quantitative features
  i1 string,i2 string,i3 string,i4 string,i5 string,i6 string,i7 string,i8 string,i9 string,i10 string,i11 string,i12 string,i13 string,
  -- categorical features
  c1 string,c2 string,c3 string,c4 string,c5 string,c6 string,c7 string,c8 string,c9 string,c10 string,c11 string,c12 string,c13 string,c14 string,c15 string,c16 string,c17 string,c18 string,c19 string,c20 string,c21 string,c22 string,c23 string,c24 string,c25 string,c26 string
) ROW FORMAT
DELIMITED FIELDS TERMINATED BY ' '
STORED AS TEXTFILE LOCATION '/criteo/ffm/train';

DROP TABLE IF EXISTS train_vectorized;
CREATE TABLE train_vectorized AS
SELECT
  row_number() OVER () AS rowid,
  array(
    i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12, i13,
    c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17, c18, c19, c20, c21, c22, c23, c24, c25, c26
  ) AS features,
  label
FROM
  train
;

DROP TABLE IF EXISTS test;
CREATE EXTERNAL TABLE test (
  label int,
  -- quantitative features
  i1 string,i2 string,i3 string,i4 string,i5 string,i6 string,i7 string,i8 string,i9 string,i10 string,i11 string,i12 string,i13 string,
  -- categorical features
  c1 string,c2 string,c3 string,c4 string,c5 string,c6 string,c7 string,c8 string,c9 string,c10 string,c11 string,c12 string,c13 string,c14 string,c15 string,c16 string,c17 string,c18 string,c19 string,c20 string,c21 string,c22 string,c23 string,c24 string,c25 string,c26 string
) ROW FORMAT
DELIMITED FIELDS TERMINATED BY ' '
STORED AS TEXTFILE LOCATION '/criteo/ffm/test';

DROP TABLE IF EXISTS test_vectorized;
CREATE TABLE test_vectorized AS
SELECT
  row_number() OVER () AS rowid,
  array(
    i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12, i13,
    c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17, c18, c19, c20, c21, c22, c23, c24, c25, c26
  ) AS features,
  label
FROM
  test
;
