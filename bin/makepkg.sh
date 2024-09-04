#!/bin/bash

filename=$(basename -- "$1")
extension="${filename##*.}"
filename="${filename%.*}"

mkdir -p "$filename"
echo "package $filename" >> $filename/$filename.$extension
