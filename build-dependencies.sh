#!/bin/sh

checkAndInstallPackage()
{
	dpkg -s $1
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
checkAndInstallPackage "libncurses5-dev" 
checkAndInstallPackage "libreadline-dev"
checkAndInstallPackage "nettle-dev"
checkAndInstallPackage "libgnutls-dev"
checkAndInstallPackage "cython3"
checkAndInstallPackage "python3-dev"
checkAndInstallPackage "python3-setuptools"
checkAndInstallPackage "build-essential"
checkAndInstallPackage "cmake"



wget https://github.com/msgpack/msgpack-c/releases/download/cpp-2.1.1/msgpack-2.1.1.tar.gz
tar -xzf msgpack-2.1.1.tar.gz
cd msgpack-2.1.1 && mkdir build && cd build
cmake -DMSGPACK_CXX11=ON -DMSGPACK_BUILD_EXAMPLES=OFF -DCMAKE_INSTALL_PREFIX=/usr ..
make -j4
sudo make install

cd ..
rm -rf msgpack-2.1.1.tar.gz
rm -rf msgpack-2.1.1

# clone the repo
git clone https://github.com/savoirfairelinux/opendht.git

# build and install
cd opendht
mkdir build && cd build
cmake -DOPENDHT_PYTHON=ON -DCMAKE_INSTALL_PREFIX=/usr ..
make -j4
sudo make install

cd ..
rm -rf opendht
