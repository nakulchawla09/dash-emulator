#!/usr/bin/env python

import os
import subprocess
import sys
import random
import pdb

num_nodes=int(os.popen("sudo docker ps | wc -l").read()) - 1
min_connections = 4
max_connections = 6

def test1():
    num_nodes=int(os.popen("sudo docker ps | wc -l").read()) - 1
    if num_nodes < 24:
        print "test 1 failed"

def test2():
    for i in range(num_nodes):
        connections_cmd = "sudo docker exec -t node_" + str(i) + " dash-cli -regtest getconnectioncount"
        connections_count = int(subprocess.check_output(connections_cmd, shell=True).strip())
        count_min_low = 0
        if connections_count < min_connections:
            count_min_low += 1

    if count_min_low > 0:
        print "test 2 failed"

def test3():
    for i in range(num_nodes):
        connections_cmd = "sudo docker exec -t node_" + str(i) + " dash-cli -regtest getconnectioncount"
        connections_count = int(subprocess.check_output(connections_cmd, shell=True).strip())
        count_max_high = 0
        if connections_count > max_connections:
            count_max_high += 1

    if count_max_high > 0:
        print "test 3 failed"

def main():
    test1()
    test2()
    test3()

if __name__ == "__main__":
    main()
