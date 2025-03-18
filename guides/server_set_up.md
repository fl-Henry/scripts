# Debian Server Set Up

@link: https://github.com/alexey-goloburdin/debian-set-up-for-django

In this guide we will set up clean Debian server for Python.

[Youtube video guide (in Russian)](https://www.youtube.com/watch?v=FLiKTJqyyvs)

## Install basic tools
```bash
sudo apt-get update ; \
sudo apt-get install -y vim htop git curl wget unzip zip gcc build-essential make
```

## Create user
```bash
useradd -m -s /bin/bash www
usermod -aG sudo www
passwd www
```

## Configure SSH:
`sudo vim /etc/ssh/sshd_config`
```vim
AllowUsers www
PermitRootLogin no
PasswordAuthentication no
```

## Restart SSH server:
```bash
sudo service ssh restart
```

## Init — must-have packages

```bash
sudo apt-get install -y tree redis-server nginx zlib1g-dev libbz2-dev libreadline-dev llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev liblzma-dev python3-dev  python3-lxml libxslt-dev libffi-dev libssl-dev gnumeric libsqlite3-dev libpq-dev libxml2-dev libxslt1-dev libjpeg-dev libfreetype6-dev libcurl4-openssl-dev
```

## Install python 

```bash
mkdir ~/install && cd ~/install
sudo wget https://www.python.org/ftp/python/3.12.1/Python-3.12.1.tgz 
sudo tar xzf Python-3.12.1.tgz
cd Python-3.12.1 
sudo ./configure --enable-optimizations --prefix=/home/www/.python
sudo make altinstall
export PATH="$HOME/.python/bin:$PATH"
python3.12 -V
sudo apt-get install -y python3.12-venv python3-pip
python3.12 -m pip install -U pip
```

```
sudo apt update
sudo apt install ufw
sudo ufw enable
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
```
