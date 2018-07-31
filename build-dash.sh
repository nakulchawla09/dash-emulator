#!/bin/sh

# sudo -y add-apt-repository ppa:bitcoin/bitcoin
# sudo apt-get update

# checkAndInstallPackage (libdb4.8-dev) 
# checkAndInstallPackage (libdb4.8++-dev)

git clone https://github.com/dashpay/dash.git 
# git checkout shard

# Build dependencies

cd dash/depends
make NO_QT=1

# Configure Dash Core for static build

cd ..
./autogen.sh
./configure --without-gui --disable-tests --prefix=$PWD/depends/x86_64-pc-linux-gnu --enable-glibc-back-compat --enable-reduce-exports LDFLAGS=-static-libstdc++ --enable-static
make
# strip src/dashd src/dash-cli src/dash-tx
sudo make install

