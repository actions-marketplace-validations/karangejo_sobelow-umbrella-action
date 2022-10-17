#!/bin/sh -l

mix deps.get
MIX_ENV=test mix deps.compile --force

if [ "$2" = "false" ]; then
    mix sobelow $1
else
    mix sobelow $1 --format sarif >>results.sarif
fi
