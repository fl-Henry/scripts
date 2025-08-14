
# SSL. TLDR
Move `henry-jefferson.com_ssl_certificate.cer` and `_.henry-jefferson.com_private_key.key` files to the server
```bash
sudo mkdir /etc/ssl/henry_jefferson_com/
sudo cp henry-jefferson.com_ssl_certificate.cer /etc/ssl/henry_jefferson_com/henry-jefferson.com_ssl_certificate.cer
sudo cp _.henry-jefferson.com_private_key.key /etc/ssl/henry_jefferson_com/_.henry-jefferson.com_private_key.key
sudo chmod 644 -R /etc/ssl/henry_jefferson_com/

sudo vim /etc/nginx/sites-enabled/henry-jefferson.com.conf
```

```conf
server {
    listen 80;
    server_name henry-jefferson.com www.henry-jefferson.com;

    # Redirect HTTP to HTTPS
    return 301 https://$host$request_uri;
}

server {
    listen 443 ssl;
    server_name henry-jefferson.com www.henry-jefferson.com;
    access_log /var/log/nginx/nginx.vhost.access.log;
    error_log /var/log/nginx/nginx.vhost.error.log;

    # SSL certificates
    ssl_certificate /etc/ssl/henry_jefferson_com/henry-jefferson.com_ssl_certificate.cer;
    ssl_certificate_key /etc/ssl/henry_jefferson_com/_.henry-jefferson.com_private_key.key;
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_prefer_server_ciphers on;

    root /var/www/apps/checkpoint_bot;
    index index.html index.htm;
}
```

```bash
sudo nginx -t
sudo nginx -s reload
# sudo systemctl restart nginx
```


# SSL. Detailed guide

To set up Nginx to use HTTPS with your SSL certificates, you'll need to configure the server block for your domain and provide the paths to the necessary certificate files.

### Step 1: Combine Your Certificates
You have three files:

- `henry-jefferson.com_ssl_certificate.cer` (your domain certificate)
- `intermediate1.cer` and `intermediate2.cer` (your intermediate certificates)

For Nginx to work properly with HTTPS, you need to concatenate your certificates into one file, with the domain certificate first, followed by the intermediate certificates. This is known as a **certificate chain**.

1. **Combine your certificate and intermediate certificates into a single file**:
   ```bash
   sudo mkdir /etc/ssl/henry_jefferson_com/
   sudo cat henry-jefferson.com_ssl_certificate.cer intermediate1.cer intermediate2.cer > henry-jefferson.com_combined.crt
   sudo cp henry-jefferson.com_combined.crt /etc/ssl/henry_jefferson_com/henry-jefferson.com_combined.crt
   ```

   This command combines `henry-jefferson.com_ssl_certificate.cer` (your domain certificate) and the intermediate certificates (`intermediate1.cer` and `intermediate2.cer`) into a new file called `henry-jefferson.com_combined.crt`.

2. **Make sure the permissions are correct**:
   Ensure that Nginx has access to this file:
   ```bash
   sudo chmod 644 /etc/ssl/henry_jefferson_com/henry-jefferson.com_combined.crt
   ```

### Step 2: Configure Nginx to Use SSL

1. **Edit the Nginx configuration**:
   Open the Nginx configuration file for your site. If you don't know where it is, it is usually in `/etc/nginx/sites-available/your_site.conf` or `/etc/nginx/nginx.conf` (or a similar file depending on your setup).

   Edit it with your preferred text editor:

   ```bash
   sudo vim /etc/nginx/sites-available/henry-jefferson.com.conf
   ```

2. **Set up the SSL configuration**:

   Update your server block to enable SSL and specify the paths to your SSL certificate files. For example:

   ```nginx
   server {
       listen 80;
       server_name henry-jefferson.com www.henry-jefferson.com;

       # Redirect HTTP to HTTPS
       return 301 https://$host$request_uri;
   }

   server {
       listen 443 ssl;
       server_name henry-jefferson.com www.henry-jefferson.com;

       # SSL certificates
       ssl_certificate /etc/nginx/ssl/henry-jefferson.com_combined.crt;
       ssl_certificate_key /etc/nginx/ssl/henry-jefferson.com_private.key; # Path to your private key

       # SSL settings (optional for better security)
       ssl_protocols TLSv1.2 TLSv1.3;
       ssl_ciphers 'ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:...'; # You can use a secure set of ciphers
       ssl_prefer_server_ciphers on;

       # Other settings for your site (e.g., root, index, etc.)
       root /var/www/your_site;
       index index.html index.htm;

       # Your other configurations, e.g., location blocks
   }
   ```

   - Replace `/etc/nginx/ssl/henry-jefferson.com_combined.crt` with the path to the combined certificate file you created earlier.
   - Replace `/etc/nginx/ssl/henry-jefferson.com_private.key` with the path to your private key file (`henry-jefferson.com_private.key`).

   **Important**: If you do not have a private key file yet (or if it's different), you'll need to use the key you created when generating the CSR (Certificate Signing Request). If you need a new one, you can generate it by running:
   ```bash
   openssl genpkey -algorithm RSA -out /etc/nginx/ssl/henry-jefferson.com_private.key -pkeyopt rsa_keygen_bits:2048
   ```

### Step 3: Test the Nginx Configuration

Before restarting Nginx, it's a good idea to test the configuration for syntax errors:

```bash
sudo nginx -t
```

If you see `syntax is okay` and `test is successful`, proceed to restart Nginx.

### Step 4: Restart Nginx

Finally, restart Nginx to apply the changes:

```bash
sudo systemctl restart nginx
```

### Step 5: Verify HTTPS

Once Nginx has restarted, try accessing your site using `https://henry-jefferson.com`. You should see the padlock icon in the browser's address bar, indicating that your connection is secure.


# Examples

## Complete Example
```conf
server {
    listen 80;
    server_name leslieserver.com;
    return 301 https://$host$request_uri;
}

server {

    listen              443 ssl;

    ssl_certificate /etc/letsencrypt/live/leslieserver.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/leslieserver.com/privkey.pem; # managed by Certbot

    server_name leslieserver.com;
    access_log /var/log/nginx/nginx.vhost.access.log;
    error_log /var/log/nginx/nginx.vhost.error.log;

    root /usr/share/leslieserver.com/html;
    # index index.html;
    index index.php index.html index.htm index.nginx-debian.html adminer.php;

    location /media/ {
        alias /home/www/media/;
        expires 30d;
        add_header Cache-Control "public, no-transform";
    }

    location / {
            proxy_pass http://127.0.0.1:8001/;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
            proxy_set_header X-Forwarded-Host $host;
            proxy_set_header X-Forwarded-Prefix /;

    }


    location /adminer/ {

            proxy_pass http://127.0.0.1:8044/;
    }
}
```

NodeJS + React
```
server {
    listen 80;
    server_name henry-jefferson.com www.henry-jefferson.com;

    # Redirect HTTP to HTTPS
    return 301 https://$host$request_uri;
}

server {
    listen 443 ssl;
    server_name henry-jefferson.com www.henry-jefferson.com;

    # SSL certificates
    ssl_certificate /etc/ssl/henry_jefferson_com/henry-jefferson.com_ssl_certificate.cer;
    ssl_certificate_key /etc/ssl/henry_jefferson_com/_.henry-jefferson.com_private_key.key;
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_prefer_server_ciphers on;

    access_log /var/log/nginx/nginx.vhost.access.log;
    error_log /var/log/nginx/nginx.vhost.error.log;

    root /var/www/henry-jefferson.com;
    index index.html index.htm;

    location /learn_arg/api/ {
        rewrite ^/learn_arg/api/(.*)$ /$1 break;
        proxy_pass http://localhost:8084;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }

}
```