#!/bin/bash

#TODO flags für logs oder nicht
#TODO flags für quiet
#TODO dry run functionality with logging

function delete {
    output=$(git clean -x -f);
    if [ "$output" != "" ]; then
        if [ "$1" = false ]; then
            echo "TIME: $(date +%H-%M-%S)" >> ".$2";
            didSomething=true;
        fi
        if [ "$3" = true ]; then
            echo "$output" >> ".$2";
        fi
        if [ "$4" = false ]; then
            echo "$output";
        fi
    fi
}

function checkForNoDeletions {
    if [ "$1" = false ]; then
        if [ "$3" = true ]; then
            echo "TIME: $(date +%H-%M-%S)" >> "$2";
            echo "No deletions occured" >> "$2";
        fi
        if [ "$4" = false ]; then
            echo "No files were deleted!"
        fi
    fi
}

filepath="./$(date +%d-%m-%y)_clean-log.txt"
didSomething=false
shouldLog=true
isQuiet=false
for DIR in */; do
cd $DIR 
    delete $didSomething $filepath $shouldLog $isQuiet
cd ..; done
checkForNoDeletions $didSomething $filepath $shouldLog $isQuiet
