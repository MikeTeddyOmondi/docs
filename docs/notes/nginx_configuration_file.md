# NGINX - Configuration File

--- 

API Gateway config file 

```nginx
upstream backend {
    server localhost:8080;
}
server {
    listen 80;
    server_name localhost;
    location / {
        proxy_pass http://backend;
        error_page 400 401 403 404 500 502 503 504 /error;
    }
    location = /error {
        content_type application/json;
        return 400 '{"error": "Bad Request"}';
    }
}
```

Extensive config file

```nginx
user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /var/run/nginx.pid;
events {
    worker_connections 1024;
}
http {
    include /etc/nginx/mime.types;
    default_type application/octet-stream;
    access_log /var/log/nginx/access.log;
    sendfile on;
    tcp_nopush on;
    tcp_nodelay on;
    keepalive_timeout 65;
    gzip on;
    gzip_disable "msie6";
    server {
        listen 80;
        server_name localhost;
        location / {
            root /usr/share/nginx/html;
            index index.html index.htm;
        }
        error_page 404 /404.html;
        error_page 500 502 503 504 /50x.html;
        location = /50x.html {
            root /usr/share/nginx/html;
        }
    }
}
```

```nginx
server {
    listen 80;

    location / {
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

        proxy_set_header Host $http_host;
        proxy_set_header X-NginX-Proxy true;
        proxy_pass http://web:8080;
        proxy_redirect off;

    }

    location /api {
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

        proxy_set_header Host $http_host;
        proxy_set_header X-NginX-Proxy true;
        proxy_pass http://api:5000;
        proxy_redirect off;

    }

}
```
