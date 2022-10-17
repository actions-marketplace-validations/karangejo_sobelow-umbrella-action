#!/bin/sh -l
mix local.hex --force
mix escript.install hex sobelow --force

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
		~/.mix/escripts/sobelow $1 --format sarif >>../../results${i}.sarif
		cd ../../
		i=$((i + 1))
	done
fi
python3 -m sarif copy -o results.sarif ./