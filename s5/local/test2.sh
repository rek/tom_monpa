#!/bin/bash

# data/train/raw file should match format:
#
# file name 1 = lexicon text 1
# file name 2 = lexicon text 2

# get from args:
#
# first arg (source data to parse)
dataDir=../audio/train/phorpa-2
# second arg (data location)
dir=../data/train
speaker=speaker_1

tmpdir=data/local/tmp
mkdir -p $tmpdir
. ./path.sh || exit 1; # for KALDI_ROOT

mkdir -p $dir

scpFile=$dir/wav.scp
textFile=$dir/text
utt2spkFile=$dir/utt2spk

# Takes a path argument and returns it as an absolute path.
# No-op if the path is already absolute.
function to-abs-path {
    local target="$1"
    if [ "$target" == "." ]; then
        echo "$(pwd)"
    elif [ "$target" == ".." ]; then
        echo "$(dirname "$(pwd)")"
    else
        echo "$(cd "$(dirname "$1")"; pwd)/$(basename "$1")"
    fi
}

# rename files from the crazy name into a sequential numbering
COUNTER=0
for file in "$dataDir"/*
do
    if [[ -f $file ]]; then

		((COUNTER++))
		# echo "relative file: $file"
		fullfile=$(to-abs-path "$file")
		# echo "full file: $fullfile"

		dirname=$(dirname -- "$fullfile")
		filename=$(basename -- "$fullfile")
		extension="${filename##*.}"
		fullfilename="${filename%.*}"
		finalFolder="${dirname##*/}"
		# echo "filename $filename"
		# echo "dirname $dirname"
		# echo "finalFolder $finalFolder"
		# echo "fullfilename $fullfilename"
		# echo "extension $extension"
		# echo "--> $COUNTER"

		lineName="${speaker}_${finalFolder}_$COUNTER"
		newFileName="$dirname/$COUNTER.$extension"
		# echo "lineName $lineName - checking: $fullfilename"

		# 1. rename file to ordinal system (if name is different)
		# mv $fullfile $newFileName

		# 2. get file text and move it into the lexicon
		# make sure to have a space after file name, to stop partial matches
		line=$(grep "$fullfilename " $dir/raw)
		# echo "matched: $line"
		value=${line#*=}
		# echo "found: $value"
		# add line into lexicon
		# echo "${$lineName}${$value}" >> $textFile

		# 3. add file name to the wav.scp file list
		# echo "$lineName $newFileName" >> $scpFile

		# 4. add line to utt2spk
		echo "$lineName $speaker" >> $utt2spkFile
    fi
done

