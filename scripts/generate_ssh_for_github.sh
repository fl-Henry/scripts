#!/bin/bash
ssh-keygen -t rsa -b 4096 -C "fl.henry.jefferson@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
echo "Copy this key to "
echo "Github account settings > SSH and GPG keys > New SSH key"
echo ""
cat ~/.ssh/id_rsa.pub
