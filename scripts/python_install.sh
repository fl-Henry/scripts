#! /bin/bash


mkdir ~/install && cd ~/install
sudo wget https://www.python.org/ftp/python/3.12.1/Python-3.12.1.tgz 
sudo tar xzf Python-3.12.1.tgz
cd Python-3.12.1 
sudo ./configure --enable-optimizations --prefix="$HOME/.python"
sudo make altinstall
export PATH="$HOME/.python/bin:$PATH"
python3.12 -V
sudo apt-get install -y python3.12-venv python3-pip
python3.12 -m pip install -U pip