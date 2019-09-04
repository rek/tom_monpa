#!/bin/bash

. ./path.sh || exit 1
. ./cmd.sh || exit 1

if [ $# -eq 0 ]
then
        echo
        echo "Missing target (test|train), example usage: ./validate.sh test"
        echo
        exit 1
fi

echo
echo "Testing: $1"
echo '-------------'
utils/validate_data_dir.sh ../data/$1     # script for checking prepared data - here: for data/train directory
echo
echo "Fixing: $1"
echo '------------'
utils/fix_data_dir.sh ../data/$1          # tool for data proper sorting if needed - here: for data/train directory
echo
echo "Re-Testing: $1"
echo '----------------'
utils/validate_data_dir.sh ../data/$1     # script for checking prepared data - here: for data/train directory
