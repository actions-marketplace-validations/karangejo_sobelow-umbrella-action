#!/bin/sh -l
mix local.hex --force
mix escript.install hex sobelow --force
~/.mix/escripts/sobelow --quiet

i=1
if [ "$2" = "false" ]; then
    for d in apps/*/; do
        cd $d
        ~/.mix/escripts/sobelow $1
        cd ../../
    done
else
    for d in apps/*/; do
        cd $d
        file=../../results${i}.sarif
        echo "writing output to:"
        echo "##########################"
        echo $file
        echo "##########################"
        ~/.mix/escripts/sobelow $1 --format sarif >$file
        cd ../../
        echo "inspecting output file:"
        echo "##########################"
        cat results${i}.sarif
        echo "##########################"
        i=$((i + 1))
    done
fi

elixir merge_sarif.exs
