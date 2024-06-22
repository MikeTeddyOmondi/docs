# Eleventy-starter-ghost

Files:

 .env 

.dockerignore

Dockerfile

docker-compose.yaml

ghost/config.development.json

ghost/config.production.json

.env

```env
GHOST_API_URL=http://localhost:2368
GHOST_CONTENT_API_KEY=2c2a3f3b04b09082ecc74a5175
SITE_URL=http://localhost:8080

MYSQL_ROOT_PASSWORD=password
MYSQL_DATABASE=ghost
MYSQL_USER=ghost
MYSQL_PASSWORD=password
GHOST_URL=http://ghost:2368

SMTP_HOST=your_smtp_server_host
SMTP_PORT=your_smtp_server_port
SMTP_USER=your_smtp_username
SMTP_PASSWORD=your_smtp_password
SMTP_FROM=your_email_from_address
```

Dockerfile

```dockerfile
# Base image
FROM node:18.13.0-alpine

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json / yarn .lock
COPY package*.json ./
COPY yarn.lock ./

# Install dependencies
RUN yarn global add npm@9.6.1 && yarn

# Copy the rest of the application code
COPY . .

# Build the website
RUN npx @11ty/eleventy

# Expose port 8080
EXPOSE 8080

# Start the server
# CMD [ "npx", "eleventy", "--serve", "--port", "8080" ]
CMD [ "yarn", "start" ]
```

docker-compose-yaml

```yaml
version: "3.7"

services:
  db:
    image: mysql:8.0
    container_name: ghost-db
    restart: always
    ports:
      - "3306:3306"
    environment:
      MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
      MYSQL_USER: ${MYSQL_USER}
      MYSQL_PASSWORD: ${MYSQL_PASSWORD}
      MYSQL_DATABASE: ${MYSQL_DATABASE}
    volumes:
      - mysql-data:/var/lib/mysql

  phpmyadmin:
    image: phpmyadmin:5.2-apache
    container_name: phpmyadmin
    restart: always
    ports:
      - "8484:80"
    environment:
      PMA_HOST: db
      MYSQL_ROOT_PASSWORD: password
    depends_on:
      - db

  ghost:
    # build:
    #   context: ./ghost
    #   dockerfile: Dockerfile
    image: ghost:5.37
    container_name: ghost-cms
    restart: always
    ports:
      - "2368:2368"
    volumes:
      - ghost-content:/var/lib/ghost/content
      - ./ghost/config.development.json:/var/lib/ghost/config.production.json
    environment:
      database__client: mysql
      database__connection__host: db
      database__connection__user: ${MYSQL_USER}
      database__connection__password: ${MYSQL_PASSWORD}
      database__connection__database: ${MYSQL_DATABASE}
      NODE_ENV: production
    depends_on:
      - db

  # eleventy:
  #   build:
  #     context: ./
  #     dockerfile: Dockerfile
  #   container_name: eleventy-starter-ghost
  #   restart: always
  #   ports:
  #     - "8080:8080"
  #   volumes:
  #     - eleventy-content:/usr/src/app/_site
  #   environment:
  #     GHOST_API_URL: http://ghost:2368
  #     NODE_ENV: production
  #   depends_on:
  #     - ghost

volumes:
  ghost-content:
  # eleventy-content:
  mysql-data:
```

## Ghost config

config.development.json

```json
{
  "url": "http://localhost:2368",
  "server": {
    "port": 2368,
    "host": "0.0.0.0"
  },
  "database": {
    "client": "mysql",
    "connection": {
      "host": "db",
      "user": "ghost",
      "password": "password",
      "database": "ghost",
      "charset": "utf8mb4"
    }
  },
  "mail": {
    "transport": "Direct"
  },
  "logging": {
    "transports": ["stdout"]
  }
}
```

config.production.json

```json
{
  "url": "https://yourdomain.com",
  "server": {
    "port": 2368,
    "host": "0.0.0.0"
  },
  "database": {
    "client": "mysql",
    "connection": {
      "host": "localhost",
      "user": "ghost",
      "password": "yourpassword",
      "database": "ghost",
      "charset": "utf8mb4"
    }
  },
  "mail": {
    "transport": "SMTP",
    "options": {
      "host": "smtp.gmail.com",
      "port": 465,
      "secureConnection": true,
      "auth": {
        "user": "youremail@gmail.com",
        "pass": "yourpassword"
      }
    }
  },
  {
  "fileStorage": {
    "active": "ghost-google-cloud-storage",
    "storagePath": "/var/lib/ghost/content/images",
    "ghost-google-cloud-storage": {
      "bucket": "my-bucket",
      "projectId": "my-project-id",
      "keyFilename": "/var/lib/ghost/content/gcloud-service-key.json",
      "assetDomain": "https://storage.googleapis.com",
      "cdn": true
      }
    }
  },
  "logging": {
    "transports": [
      "file",
      {
        "level": "warn",
        "path": "/var/log/ghost/ghost.log"
      }
    ]
  },
  "process": "systemd",
  "paths": {
    "contentPath": "/var/lib/ghost/content"
  },
  "bootstrap": {
    "process": true,
    "client": false
  },
  "production": {
    "useMinFiles": true,
    "cacheAssetBusting": true,
    "minify": {
      "enabled": true,
      "html": {
        "enabled": true,
        "exclude": [],
        "options": {}
      },
      "css": {
        "enabled": true,
        "options": {}
      },
      "js": {
        "enabled": true,
        "options": {}
      }
    }
  }
}
```
