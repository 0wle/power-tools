#!/bin/bash

#TODO dry run functionality with logging
# -t
#TODO recursive flag
# -r

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

function throwError {
    case "$1" in
        "log")
            echo "Only one logging related flag allowed"
            exit 1;
    esac
}

shouldLog=false;
filepathLog=$(pwd);
filepathStart=$(pwd);
isQuiet=false;
while getopts 'lL:qtrd:' OPTION; do
    case "$OPTION" in
        l)
            if [ shouldLog = true ]; then
                throwError "log"
            fi
            shouldLog=true;
            ;;
        L)
            if [ shouldLog = true ]; then
                throwError "log"
            fi
            shouldLog=true;
            filepathLog=$(realpath "$OPTARG");
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
            filepathStart=$(realpath "$OPTARG");
            ;;
        ?)
            echo "Hier kommt die Spezifikation des Programms"
            exit 1
            ;;
    esac
done
shift "$(($OPTIND -1))"

cd $filepathStart
filepathLog="$filepathLog/$(date +%d-%m-%y)_clean-log.txt"
didSomething=false
for DIR in */; do
runDelete $didSomething $filepathLog $shouldLog $isQuiet
cd $DIR
    runDelete $didSomething $filepathLog $shouldLog $isQuiet
cd ..; done
checkForNoDeletions $didSomething $filepathLog $shouldLog $isQuiet