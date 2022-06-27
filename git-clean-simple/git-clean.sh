#!/bin/bash

#TODO dry run functionality with logging
# -t
#TODO recursive flag
# -r
# TODO help page

#TODO add repository name in outputs as prefix

function delete {
    output=$(git clean -x -f);
    if [ "$output" != "" ]; then
        if [ "$3" = true ]; then
            if [ "$1" = false ]; then
            echo "TIME: $(date +%H-%M-%S)" >> "$2";
            fi
            echo "$5$output" >> "$2";
        fi
        if [ "$4" = false ]; then
            echo "$5$output";
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
while getopts 'lL:qtrd:' OPTION; do
    case "$OPTION" in
        l)
            shouldLog=true;
            ;;
        L)
            shouldLog=true;
            filepathLog=$(realpath "$OPTARG");
            ;;
        q)
            isQuiet=true
            ;;
        t)
            echo "Not implemented"
            ;;
        r)
            echo "Not implemented"
            ;;
        d)
            filepathStart=$(realpath "$OPTARG");
            ;;
        ?)
            echo "git_clean [-l | -L directory] [-q] [-t] [-r] [-d]"
            echo "l     log will be dumped in current directory"
            echo "L     log will be dumped in specified directory"
            echo "q     quiet mode"
            echo "t     dry run without any actual deletions"
            echo "r     recursively iterate through every sub directory"
            echo "d     specify the starting directory"
            exit 1
            ;;
    esac
done
shift "$(($OPTIND -1))"

cd $filepathStart
filepathLog="$filepathLog/$(date +%d-%m-%y)_clean-log.txt"
didSomething=false
for DIR in */; do
runDelete $didSomething $filepathLog $shouldLog $isQuiet $DIR
cd $DIR
    runDelete $didSomething $filepathLog $shouldLog $isQuiet $DIR
cd ..; done
checkForNoDeletions $didSomething $filepathLog $shouldLog $isQuiet