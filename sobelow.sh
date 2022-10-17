#!/bin/sh -l

if [ "$2" = "false" ]; then
    mix sobelow $1
else
    mix sobelow $1 --format sarif >> results.sarif
fi