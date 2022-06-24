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
        if [ "$3" = true ]; then
            if [ "$1" = false ]; then
            echo "TIME: $(date +%H-%M-%S)" >> "$2";
            fi
            echo "$output" >> "$2";
        fi
        if [ "$4" = false ]; then
            echo "$output";
        fi
        didSomething=true;
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

function runDelete {
    if [ -d "./.git/" ]; then
        delete $1 $2 $3 $4
    fi
}

shouldLog=false;
filepathLog=$(pwd);
filepathStart=$(pwd);
isQuiet=false;
while getopts 'lLqtrd:' OPTION; do
    case "$OPTION" in
        l)
            shouldLog=true;
            filepathLog=$(pwd);
            ;;
        L)
            shouldLog=true;
            filepathLog="$OPTARG";
            ;;
        q)
            isQuiet=true
            ;;
        t)
            echo "Du willst einen dry-run ohne tatsächliche Löschngen machen!"
            ;;
        r)
            echo "Du willst rekursiv doch die Ordner iterieren"
            ;;
        d)
            filepathStart="$OPTARG"
            ;;
        ?)
            echo "Hier kommt die Spezifikation des Programms"
            exit 1
            ;;
    esac
done

cd $filepathStart
filepathLog="$filepathLog/$(date +%d-%m-%y)_clean-log.txt"
didSomething=false
for DIR in */; do
    runDelete $didSomething $filepathLog $shouldLog $isQuiet
cd $DIR
    runDelete $didSomething $filepathLog $shouldLog $isQuiet
cd ..; done
checkForNoDeletions $didSomething $filepathLog $shouldLog $isQuiet