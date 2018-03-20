#!/bin/sh

## Install dependencies

sudo -y apt-get install libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev
sudo -y add-apt-repository ppa:bitcoin/bitcoin
sudo apt-get update
sudo -y apt-get install libdb4.8-dev libdb4.8++-dev

## Install Berkeley db

# Pick some path to install BDB to, here we create a directory within the dash directory
BDB_PREFIX="${DASH_ROOT}/db4"
mkdir -p $BDB_PREFIX

# Fetch the source and verify that it is not tampered with
wget 'http://download.oracle.com/berkeley-db/db-4.8.30.NC.tar.gz'
echo '12edc0df75bf9abd7f82f821795bcee50f42cb2e5f76a6a281b85732798364ef  db-4.8.30.NC.tar.gz' | sha256sum -c
# -> db-4.8.30.NC.tar.gz: OK
tar -xzvf db-4.8.30.NC.tar.gz

# Build the library and install to our prefix
cd db-4.8.30.NC/build_unix/
#  Note: Do a static build so that it can be embedded into the executable, instead of having to find a .so at runtime
../dist/configure --enable-cxx --disable-shared --with-pic --prefix=$BDB_PREFIX
sudo make install
cd ../../

rm -rf db*

# git clone https://github.com/nakulchawla09/dash.git

# Configure Dash Core to use our own-built instance of BDB

cd dash
./autogen.sh
./configure LDFLAGS="-L${BDB_PREFIX}/lib/" CPPFLAGS="-I${BDB_PREFIX}/include/" # (other args...)
make
strip src/dashd src/dash-cli src/dash-tx
sudo make install

cd ..

# rm -rf dash

cp /usr/local/bin/dashd .
cp /usr/local/bin/dash-cli .
cp /usr/local/bin/dash-tx .

