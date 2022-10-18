#!/bin/sh -l
# install hex and sobelow
mix local.hex --force
mix escript.install hex sobelow --force

# sometimes running the script for the first time raises
# an ssl warning to stdout and since we are writing to
# a sarif file we want to get rid of this warning first
~/.mix/escripts/sobelow --quiet

i=1
if [ "$2" = "false" ]; then
    for d in apps/*/; do
        # just run sobelow
        cd $d
        ~/.mix/escripts/sobelow $1
        cd ../../
    done
else
    for d in apps/*/; do
        # just run sobelow and merge the sarif files for
        # upload to github security tab
        cd $d
        file=../../results${i}.sarif
        ~/.mix/escripts/sobelow $1 --format sarif >$file
        cd ../../
        i=$((i + 1))
        elixir /merge_sarif.exs
    done
fi
