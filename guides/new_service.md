## Add New service

```bash
#sudo vim /etc/systemd/system/myproject.service

[Unit]
Description=Gunicorn instance to serve myproject
After=network.target

[Service]
User=www
Group=www-data

WorkingDirectory=/home/www/myproject
Environment="PATH=/home/www/myproject/myprojectenv/bin"
ExecStart=/home/www/myproject/myprojectenv/bin/gunicorn --access-logfile="/home/www/myproject/gunicorn.log" -c "/home/www/myproject/gunicorn_config.py" -m 007 wsgi:app

[Install]
WantedBy=multi-user.target
```

## Run service

```
sudo systemctl start myproject 
sudo systemctl enable myproject
sudo systemctl status myproject
```

## To rename service file

```
sudo mv /etc/systemd/system/myproject.service /etc/systemd/system/<NEW_NAME>.service
```
