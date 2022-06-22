#!/bin/bash

for DIR in */; do cd $DIR && git clean -x -f && cd ..; done
