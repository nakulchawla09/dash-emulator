./dashd -regtest -daemon -debug -use-grapheneblocks=1 -port=8330 -rpcport=8331 -datadir=/home/nchawla3/.dashcore_data_1
sleep 5
./dash-cli -regtest -debug -use-grapheneblocks=1 -port=8330 -rpcport=8331 generate 202
./dash-cli -regtest -debug -use-grapheneblocks=1 -port=8330 -rpcport=8331 getnewaddress
# ./dashd -regtest -daemon -debug -use-grapheneblocks=1 -port=8333 -rpcport=8332 -datadir=/home/nchawla3/.dashcore_data_2


 
