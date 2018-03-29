#!/bin/sh
inport=18444
outport=18332
for i in $(seq 0 23)
do
	#echo $i
	x="node_"$i
	docker run -td -p $inport:$inport -p $outport:$outport --name=$x --hostname=$x --rm dash
	docker exec -t $x dashd -regtest -daemon
	sleep 40
	docker exec -t $x dash-cli -regtest getinfo 
	outport=$((outport+1))
	inport=$((inport+1))
done
