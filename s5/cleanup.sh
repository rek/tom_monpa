#!/bin/bash

. ./path.sh || exit 1
. ./cmd.sh || exit 1

if [ $# -eq 0 ]
then
        echo
        echo "Missing target (test|train), example usage: ./cleanup.sh test"
        echo
        exit 1
fi

rm -rf ../data/$1/spk2utt ../data/$1/cmvn.scp ../data/$1/feats.scp ../data/$1/split1 ../data/$1/utt2dur ../data/$1/utt2num_frames ../data/$1/frame_shift
