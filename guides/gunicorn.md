```
gunicorn -c gconfig.py core.wsgi
gunicorn -c gconfig.py core.wsgi >> ./logs/stdout.log 2>&1
gunicorn -c gconfig.py core.wsgi --bind 0.0.0.0:8000
gunicorn -c gconfig.py core.wsgi --bind 0.0.0.0:8000  >> ./logs/stdout.log 2>&1
```

Gunicorn config `gconfig.py`
```python
"""Gunicorn config file"""

command = './venv/bin/gunicorn'
bind = '0.0.0.0:8001'
# workers = 1
user = 'www'
# limit_request_fields = 32000
# limit_request_field_size = 0
accesslog = './logs/access.log'
errorlog = './logs/error.log'

```