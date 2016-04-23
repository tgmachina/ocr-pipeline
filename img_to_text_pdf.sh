#!/bin/bash
START=$(pwd)
SOURCE=$1
DESTINATION_PDF=$2

function usage {
	echo "Usage: img_to_text_pdf source destination"
	exit
}

if [ -z $SOURCE ]; then
	usage
fi

if [ -z $DESTINATION_PDF ]; then
	usage
fi

function short_sha {
	echo `date | shasum | cut -c 1-5`
}

function tmp_dir {
	ssha=$(short_sha)
	echo "/tmp/$ssha"
}

function convert_to_pdf {
	dir=$1
	if [ "$(ls -A $dir)" ]; then
		for img in $dir/*
		do
			arr=(${img//./ })
			base=${arr[0]}
			tesseract $img $base pdf
		done
	fi
}

if [ "$(ls -A $SOURCE)" ]; then
	# Create a temporary, unique location
	TMP_WORK_DIR=$(tmp_dir)
	mkdir -p $TMP_WORK_DIR

	# Move all files to the temporary location
	mv $SOURCE/* $TMP_WORK_DIR

	# Run tesseract on each file
	convert_to_pdf $TMP_WORK_DIR

	# Copy all pdfs to new location
	mv $TMP_WORK_DIR/*.pdf $DESTINATION_PDF

	# TODO: Write backup to optional directory

	# Clean up
	cd $START
	rm -rf $TMP_WORK_DIR
else
	echo "No files to convert, exiting"
	exit
fi

