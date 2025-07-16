
## 🧰 Step-by-Step: Install & Configure Squid Proxy

---

### 🧱 1. **Install Squid**

```bash
sudo apt update
sudo apt install squid -y
```

### ⚙️ 2. **Configure Squid**

Main config file:

```bash
sudo vim /etc/squid/squid.conf
```

```bash
sudo tee /etc/squid/squid.conf > /dev/null <<EOF
acl localnet src 181.15.228.245/32      # Replace with your IP or subnet
http_access allow localnet

acl localnet src 0.0.0.1-0.255.255.255  # RFC 1122 "this" network (LAN)
acl localnet src 10.0.0.0/8             # RFC 1918 local private network (LAN)
acl localnet src 100.64.0.0/10          # RFC 6598 shared address space (CGN)
acl localnet src 169.254.0.0/16         # RFC 3927 link-local (directly plugged) machines
acl localnet src 172.16.0.0/12          # RFC 1918 local private network (LAN)
acl localnet src 192.168.0.0/16         # RFC 1918 local private network (LAN)
acl localnet src fc00::/7               # RFC 4193 local private network range
acl localnet src fe80::/10              # RFC 4291 link-local (directly plugged) machines

acl SSL_ports port 443
acl Safe_ports port 80          # http
acl Safe_ports port 21          # ftp
acl Safe_ports port 443         # https
acl Safe_ports port 70          # gopher
acl Safe_ports port 210         # wais
acl Safe_ports port 1025-65535  # unregistered ports
acl Safe_ports port 280         # http-mgmt
acl Safe_ports port 488         # gss-http
acl Safe_ports port 591         # filemaker
acl Safe_ports port 777         # multiling http
acl CONNECT method CONNECT

http_access deny !Safe_ports
http_access deny CONNECT !SSL_ports

http_access allow localhost manager
http_access deny manager

include /etc/squid/conf.d/*.conf

http_access allow localhost

http_access deny all

http_port 3128

coredump_dir /var/spool/squid

refresh_pattern ^ftp:           1440    20%     10080
refresh_pattern ^gopher:        1440    0%      1440
refresh_pattern -i (/cgi-bin/|\?) 0     0%      0
refresh_pattern .               0       20%     4320
EOF
```

---

### 🔥 3. **Enable and Start the Squid Service**

```bash
sudo systemctl enable squid
sudo systemctl start squid
sudo systemctl restart squid
sudo systemctl status squid
```

---

### 🔐 4. **Allow Squid Through the Firewall**


```bash
sudo ufw allow from 181.15.228.245 to any port 3128
```

---

### 🧪 5. **Test the Proxy**

From a client system or using `curl`:

```bash
curl -x http://66.179.255.244:3128 https://ifconfig.me/
```

You should get the HTML of the page if it's working.

---

### 📁 Optional: Logging & Caching

Logs:

```bash
sudo less /var/log/squid/access.log
```
Cache configuration (defaults are usually fine for basic use) can be adjusted in `squid.conf`.
