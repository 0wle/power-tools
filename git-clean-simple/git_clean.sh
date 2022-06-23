#!/bin/bash

#TODO flags für logs oder nicht
#TODO flags für quiet
#TODO filepath mit datum

filepath="../$(date +%d-%m-%y)_clean-log.txt"
didSomething=false
for DIR in */; do
cd $DIR 
output=$(git clean -x -f)
if [ "$output" != "" ]; then
    if [ "$didSomething" = false ]; then
        echo "TIME: $(date +%H-%M-%S)" >> "${filepath}"
        didSomething=true
    fi
    echo "$output" >> "${filepath}"
fi 
cd ..; done

if [ "$didSomething" = false ]; then
    echo "No files were deleted!"
fi