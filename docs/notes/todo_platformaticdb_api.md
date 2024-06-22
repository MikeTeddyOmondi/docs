# Todo PlatformaticDB API



package.json

```json
{
  "scripts": {
    "start": "platformatic db start"
  },
  "devDependencies": {
    "fastify": "^4.11.0",
    "platformatic-prisma": "^1.1.0",
    "prisma": "^4.8.1"
  },
  "dependencies": {
    "@platformatic/sql-graphql": "^0.12.1",
    "@platformatic/sql-mapper": "^0.12.1",
    "platformatic": "^0.12.1"
  },
  "engines": {
    "node": "^16.17.0 || ^18.8.0 || >=19"
  }
}
```



prisma/schema.prisma

```prisma
datasource db {
  // Any provider supported by Platformatic
  // https://oss.platformatic.dev/docs/reference/db/introduction#supported-databases
  provider = "mysql"
  url      = env("DATABASE_URL")
}

model Todo {
  id        Int      @id @default(autoincrement())
  title     String   @db.VarChar(255)
  completed Boolean  @default(false)
}

// Table used by Platformatic/Postgrator to manage migrations
model Version {
  version BigInt    @id
  name    String?
  md5     String?
  run_at  DateTime? @db.Timestamp(6)

  @@map("versions")
  @@ignore
}
```



platformatic.db.schema.json

```json
{
  "$schema": "./platformatic.db.schema.json",
  "server": {
    "hostname": "{PLT_SERVER_HOSTNAME}",
    "port": "{PORT}",
    "cors": {
      "origin": "{PLT_SERVER_CORS_ORIGIN}"
    },
    "logger": {
      "level": "{PLT_SERVER_LOGGER_LEVEL}"
    }
  },
  "core": {
    "connectionString": "{DATABASE_URL}",
    "graphql": true,
    "openapi": true
  },
  "migrations": {
    "dir": "migrations"
  },
  "plugin": {
    "path": "plugin.js"
  },
  "types": {
    "autogenerate": true
  }
}
```



.env

```
PLT_SERVER_HOSTNAME=127.0.0.1
PORT=3042
PLT_SERVER_LOGGER_LEVEL=info
DATABASE_URL=mysql://root:password@127.0.0.1:3306/todo-platformatic-api
PLT_SERVER_CORS_ORIGIN=http://127.0.0.1:5500
```


