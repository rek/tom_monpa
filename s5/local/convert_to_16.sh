#!/bin/bash

if [ $# -eq 0 ]
then
        echo
        echo "Missing target folder to convert, example usage: ../audio/train/phorpa-2"
        echo
        exit 1
fi

dataDir=$1

for file in "$dataDir"/*
do
    if [[ -f $file ]]; then
		echo "file: $file"
		ffmpeg -i "$file" -acodec pcm_s16le -ac 1 -ar 16000 -y "$file"
    fi
done
