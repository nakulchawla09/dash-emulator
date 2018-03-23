#!/bin/sh

func checkAndInstallPackage
{
	apt-cache show $1
	if [ $? -ne 0 ]; then
		sudo apt-get -y install $1
	fi

}

checkAndInstallPackage "libboost-system-dev"
checkAndInstallPackage "libboost-filesystem-dev"
checkAndInstallPackage "libboost-chrono-dev"
checkAndInstallPackage "libboost-program-options-dev"
checkAndInstallPackage "libboost-test-dev"
checkAndInstallPackage "libboost-thread-dev"


# sudo -y add-apt-repository ppa:bitcoin/bitcoin
# sudo apt-get update

# checkAndInstallPackage (libdb4.8-dev) 
# checkAndInstallPackage (libdb4.8++-dev)

git clone https://github.com/nakulchawla09/dash.git

# Build dependencies

cd dash/depends
make NO_QT=1

# Configure Dash Core for static build

cd ..
./autogen.sh
./configure --without-gui --disable-tests --prefix=$PWD/depends/x86_64-pc-linux-gnu --enable-glibc-back-compat --enable-reduce-exports LDFLAGS=-static-libstdc++ --enable-static
make
strip src/dashd src/dash-cli src/dash-tx
sudo make install

