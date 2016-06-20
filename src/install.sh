# installer for NODE+NPM

#!/bin/bash

# Required to update system
sudo apt-get update

# Store current location of dir
CURR_LOC=`pwd`;

# Ask for preferred node version
echo "-----------------"
echo "|Node version?: |"
echo "-----------------"

# store input into variable
read NODE_VERSION

# Ask for NPM version
echo "-----------------"
echo "|NPM version?:  |"
echo "-----------------"

# store input into variable
read NPM_VERSION

#### Node installation starts

# Get architecture of the host system
SYS_ARCH=`uname -i`

if [ $SYS_ARCH = 'x86_64' ]; then
  NODE_ARCH=x64
else
  NODE_ARCH=x86
fi

# Install essential libs required for node
sudo apt-get -y install build-essential libssl-dev git curl

NODE_DIST=node-v${NODE_VERSION}-linux-${NODE_ARCH}

# Download node package into /tmp dir
cd /tmp

# delete existing node package if any from dir
rm -rf ${NODE_DIST}*

# download package with given node version as input
wget http://nodejs.org/dist/v${NODE_VERSION}/${NODE_DIST}.tar.gz

# extract package from tar
tar -xvzf ${NODE_DIST}.tar.gz

# change dir to ./bin folder
cd ${NODE_DIST}/bin

# move node file from /tmp to /usr/bin
sudo mv /tmp/${NODE_DIST}/bin/node /usr/bin/node

##### Node installation ends

##### NPM installation starts

cd /tmp

# download NPM package with given npm version as input
wget https://registry.npmjs.org/npm/-/npm-${NPM_VERSION}.tgz

# extract from tar
tar -xvzf npm-${NPM_VERSION}.tgz

# delete existing npm files
sudo rm -rf /opt/npm
sudo rm -rf /tmp/npm

# create new npm dir
mkdir npm

# move package contents into /npm folder
sudo mv ./package/* ./npm/

# move npm folder to ./opt
sudo mv npm /opt/npm

# move cli.js file to ./bin
sudo ln -sf /opt/npm/bin/npm-cli.js /usr/local/bin/npm

# change dir to original dir at begining
cd $CURR_LOC

# echo installed node, npm versions
echo "--------------------------------------------"
echo "|Your current NODE version is " `node -v` "   |"
echo "--------------------------------------------"

echo "-------------------------------------------"
echo "|Your current NPM version is " `npm -v` "   |"
echo "-------------------------------------------"
