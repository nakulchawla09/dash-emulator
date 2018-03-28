import os
import subprocess
import sys
import random

num_nodes=int(os.popen("docker ps | wc -l").read())

min_connections = {}
max_conections = {}
nodes_connections = {}


# change min_connections to piecewise_distribution from 8 to 20 with higher probablities to 8-10

for i in num_nodes:
    min_connections[i] = 8

for j in num_nodes:
    max_connections[j] = 15

for i in num_nodes:
    count = 0;
    while ( len(nodes_connections[i]) < min_connections[i] and count < 10*min_connections[i] ) :
        index = random.randint(0,num_nodes*100) % no_nodes
        candidate_peer = index

        if candidate_peer = i:
            print "Can't connect to itself"
        elif candidate_peer in nodes_connections[i]:
            print "Already connected to this peer"
        elif nodes_connections[candidate_peer] >= max_connections[candidate_peer]:
            print "Node already has maximum connections"
        else:
            nodes_connections[i].append(candidate_peer)
            nodes_connections[candidate_peer].append(i)
            # os.system(

        # elif len(nodes_connections
            



