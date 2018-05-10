#!/bin/sh

if [ ! -f criteo/train.csv ] || [ ! -f criteo/test.csv ]; then

  if [ ! -d criteo ]; then

    if [ ! -f criteo.tar.gz ]; then
      echo "> Download dataset"
      echo "You first need to accept and agree with CRITEO LABS DATA TERM OF USE at: http://labs.criteo.com/2014/02/kaggle-display-advertising-challenge-dataset/\n"
      while true; do
        read -p "Have you accepted? [Y/n] " yn
        case $yn in
          [Yy]* ) break;;
          [Nn]* ) echo "Sorry, we cannot proceed unless you accept the term of use."; exit;;
          * ) echo "Invalid input. Try again...";;
        esac
      done

      curl -o criteo.tar.gz -L https://s3-eu-west-1.amazonaws.com/criteo-labs/dac.tar.gz
      if [ ! $(md5sum criteo.tar.gz | cut -d' ' -f 1) == "df9b1b3766d9ff91d5ca3eb3d23bed27" ]; then
        exit 1
      fi
      echo "[ok] criteo.tar.gz"
    fi

    echo "> Decompress raw data"
    mkdir criteo
    tar xvzf criteo.tar.gz -C criteo

    if [ ! $(md5sum criteo/train.txt | cut -d' ' -f 1) == "4dcfe6c4b7783585d4ae3c714994f26a" ]; then
      exit 1
    fi
    if [ ! $(md5sum criteo/test.txt | cut -d' ' -f 1) == "94ccf2787a67fd3d6e78a62129af0ed9" ]; then
      exit 1
    fi
    echo "[ok] train.txt test.txt"
  fi

  echo "> Convert raw data into CSV format"
  converters/txt2csv.py tr criteo/train.txt criteo/train.csv
  if [ ! $(md5sum criteo/train.csv | cut -d' ' -f 1) == "ebf87fe3daa7d729e5c9302947050f41" ]; then
    exit 1
  fi
  echo "[ok] train.csv"

  converters/txt2csv.py te criteo/test.txt criteo/test_without_label.csv
  utils/add_dummy_label.py criteo/test_without_label.csv criteo/test.csv
  rm criteo/test_without_label.csv
  if [ ! $(md5sum criteo/test.csv | cut -d' ' -f 1) == "cd6ac893856ab5aa904ec1ad5ef9218b" ]; then
    exit 1
  fi
  echo "[ok] test.csv"
fi

mv criteo/*.csv .
