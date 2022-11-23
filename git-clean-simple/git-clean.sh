#!/bin/bash

function delete {
    if [ "$6" = false ]; then
    output=$(git clean -x -f);
    else
    output=$(git clean -x -n);
    fi
    if [ "$output" != "" ]; then
        if [ "$3" = true ]; then
            if [ "$1" = false ]; then
            echo $(pwd) >> "$2";
            echo "$output" >> "$2";
            fi
        fi
        if [ "$4" = false ]; then
            echo $(pwd)
            echo "$output";
        fi
        didSomething=true;
    fi
}

function checkForNoDeletions {
    if [ "$1" = false ]; then
        if [ "$3" = true ]; then
            if [ "$5" = false ]; then
            echo "No deletions occured" >> "$2";
            else
            echo "No deletions would have occured" >> "$2";
            fi
        fi
        if [ "$4" = false ]; then
            echo "No files were deleted!";
        fi
    fi
}

function runDelete {
    if [ -d "./.git/" ]; then
        delete $1 $2 $3 $4 $5 $6
    fi
}

function deleteFromSubDirectories {
    for DIR in */; do 
    cd $DIR
        if [ $7 = true ]; then
            deleteFromSubDirectories $1 $2 $3 $4 $DIR $6 $7
        fi
        runDelete $1 $2 $3 $4 $5 $6;
    cd ..; done
}

function setupLog {
    echo "TIME: $(date +%H-%M-%S)" >> "$1";
}

function printHelp {
    echo "git_clean [-l | -L directory] [-q] [-t] [-r] [-d]";
    echo "l     log will be dumped in current directory";
    echo "L     log will be dumped in specified directory";
    echo "q     quiet mode";
    echo "n     dry run without any actual deletions";
    echo "r     recursively iterate through every sub directory";
    echo "d     specify the starting directory";
}

shouldLog=false;
filepathLog=$(pwd);
filepathStart=$(pwd);
isQuiet=false;
isDryRun=false;
isRecursive=false;
while getopts 'lL:qnrdh:' OPTION; do
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
        n)
            isDryRun=true
            ;;
        r)
            isRecursivdidSomethinge=true
            ;;
        d)
            filepathStart=$(realpath "$OPTARG");
            ;;
        h)
            printHelp
            exit 1;
            ;;
        ?)
            printHelp
            exit 1;
            ;;
    esac
done
shift "$(($OPTIND -1))"

if ! [ -x "$(command -v git)" ]; then
  echo 'Error: git is not installed.' >&2
  exit 1
fi

cd $filepathStart;
filepathLog="$filepathLog/$(date +%d-%m-%y)_clean-log.txt";
didSomething=false;
if [ $shouldLog = true ]; then
    setupLog $filepathLog
fi
runDelete $didSomething $filepathLog $shouldLog $isQuiet $filepathStart $isDryRun;
deleteFromSubDirectories $didSomething $filepathLog $shouldLog $isQuiet $filepathStart $isDryRun $isRecursive;
checkForNoDeletions $didSomething $filepathLog $shouldLog $isQuiet $isDryRun;