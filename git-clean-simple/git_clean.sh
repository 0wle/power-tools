#!/bin/bash

#TODO flags für logs oder nicht
#TODO flags für quiet
#TODO filepath mit datum

didSomething=false
for DIR in */; do
cd $DIR 
output=$(git clean -x -f)
if [ "$output" != "" ]; then
    didSomething=true
    echo "$output" >> ../log.txt
fi 
cd ..; done

if [ "$didSomething" = false ]; then
    echo "No files were deleted!"
fi