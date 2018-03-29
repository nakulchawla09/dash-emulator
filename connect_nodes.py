#!/usr/bin/env python

import os
import subprocess
import sys
import random
import pdb

num_nodes=int(os.popen("docker ps | wc -l").read()) - 1
print num_nodes

min_connections = {}
max_connections = {}
nodes_connections = {}

def create_command(src,dest):
    init_command = "docker inspect node_" + str(dest) + " --format '{{ .NetworkSettings.IPAddress}}'"
    dest_ipaddress = subprocess.check_output(init_command, shell=True).strip()
    commandToReturn = "docker exec -t node_" + str(src) + " dash-cli -regtest addnode " + dest_ipaddress + " onetry"
    return commandToReturn

# change min_connections to piecewise_distribution from 8 to 20 with higher probablities to 8-10

for i in range(num_nodes):
    min_connections[i] = 8

for j in range(num_nodes):
    max_connections[j] = 12

for k in range(num_nodes):
    nodes_connections[k] = [-1]

for i in range(num_nodes):
    count = 0;

    while ( len(nodes_connections[i]) < min_connections[i] and count < 10*min_connections[i] ) :
        index = random.randint(0,num_nodes*100) % (num_nodes-1)
        candidate_peer = index

        if candidate_peer == i:
            print "Can't connect to itself"
        elif candidate_peer in nodes_connections[i]:
            print "Already connected to this peer"
        elif len(nodes_connections[i]) >= max_connections[candidate_peer]:
            # pdb.set_trace()
            print "Node already has maximum connections"
        else:
            nodes_connections[i].append(candidate_peer)
            nodes_connections[candidate_peer].append(i)
            commandToExecute = create_command(i,candidate_peer)
            subprocess.check_output(commandToExecute, shell=True)

    count +=1;



