#!/bin/sh
inport=18444
outport=18332
for i in $(seq 1 24)
do
	x="node_"$i
	docker exec -t $x dash-cli -regtest getinfo 
done
