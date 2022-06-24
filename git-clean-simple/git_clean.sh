#!/bin/bash

#TODO flags für logs oder nicht
# -l
#TODO flag für filepath specification logs
# -L value
#TODO flags für quiet
# -q
#TODO dry run functionality with logging
# -t
#TODO recursive flag
# -r
#TODO cleanup directory specification
# -d value


function delete {
    output=$(git clean -x -f);
    if [ "$output" != "" ]; then
        if [ "$1" = false ]; then
            echo "TIME: $(date +%H-%M-%S)" >> "$2";
            didSomething=true;
        fi
        if [ "$3" = true ]; then
            echo "$output" >> "$2";
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

while getopts 'lLqtrdhelp:' OPTION; do
    case "$OPTION" in
        l)
            echo "Du willst logs!"
            ;;
        L)
            echo "Du willst logs, an einem bestimmenten path!"
            ;;
        q)
            echo "Du willst keine Konsolenausgaben!"
            ;;
        t)
            echo "Du willst einen dry-run ohne tatsächliche Löschngen machen!"
            ;;
        r)
            echo "Du willst rekursiv doch die Ordner iterieren"
            ;;
        d)
            echo "Du willst einen Startpunkt spezifizieren!"
        
        ?)
            echo "Hier kommt die Spezifikation des Programms"
            exit 1
            ;;
    esac
done

specifiedLocation=false
filepath=""
if [ specifiedLocation = false ];
then
    filepath=$(pwd);
else
    # exchange this for the arg value
    filepath=$(pwd);
fi

filepath="$filepath/$(date +%d-%m-%y)_clean-log.txt"
didSomething=false
shouldLog=true
isQuiet=false
for DIR in */; do
cd $DIR 
    delete $didSomething $filepath $shouldLog $isQuiet
cd ..; done
checkForNoDeletions $didSomething $filepath $shouldLog $isQuiet