#! /bin/bash

sudo apt update
wget https://nodejs.org/dist/v24.11.1/node-v24.11.1-linux-x64.tar.xz
sudo mkdir -p /usr/local/lib/nodejs
sudo tar -xJvf node-v24.11.1-linux-x64.tar.xz -C /usr/local/lib/nodejs
export PATH=/usr/local/lib/nodejs/node-v24.11.1-linux-x64/bin:$PATH
node --version
npm --version