docker run -td -p 18444:18444 -p 18332:18332 --name=alice --hostname=alice --rm dash
docker exec -t alice dashd -regtest -daemon
docker exec -t alice dash-cli -regtest getinfo 
