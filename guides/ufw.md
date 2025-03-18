## Install Firewall
```bash
sudo apt update
sudo apt install ufw
sudo ufw enable
```

## Set the firewall up

```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
# sudo ufw allow from 192.168.1.100 to any port 8888
```

## Restart the firewall
```bash
sudo ufw reload
```

## Check UFW Status

```bash
sudo ufw status
```