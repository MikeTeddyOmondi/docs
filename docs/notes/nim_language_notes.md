# Nim Language - Notes

## Use Cases

1. Systems programming

2. Embedded programming - IoT devices

3. CPU intensive operations

4. I/O intensive operations - Web servers 

5. CLI applications

## Web Frameworks:

1. [Jester](https://github.com/dom96/jester)

> 📌 **Cross-compilation:**
> 
> More information about cross-compilation can be found in the Nim Compiler User
> Guide: http://nim-lang.org/docs/nimc.html#cross-compilation

---

## CLI Chat Application w/ Nim

Project directory structure:

MyAwesomeApp
├── bin
│ └── MyAwesomeApp
├── images
│ └── logo.png
├── src
│ └── MyAwesomeApp.nim
└── tests
└── generictest.nim

---

## CRUD Web Server w/ Jester Web Framework

```nim
# This example using
# Nim: 0.18.0
# Jester: 0.2.1
# Using Jester >= 0.3.0 is preferrable if your Nim version > 0.18.0
# In case you're using Jester >= 0.3.0, look the syntax different
# in its example because it's not backward compatible

import db_sqlite, asyncdispatch, json, strformat, strutils, sequtils

import jester

var db = open("person.db", "", "", "person")

# exec can raise exception, in this case we let it crash because this
# is just configuration
db.exec(sql"""
CREATE TABLE IF NOT EXISTS person_info(
  id INTEGER PRIMARY KEY,
  name VARCHAR(20) NOT NULL,
  age INTEGER)""")

proc msgjson(msg: string): string =
  """{"msg": $#}""" % [msg]

settings:
  port = Port 3000

routes:
  get "/info/@id":
    let
      id = try: parseInt(@"id")
           except ValueError: -1
    if id == -1:
      resp(Http400, msgjson("Invalid id format"), contentType = "application/json")
    let
      row = try:
              db.getRow(sql"SELECT * FROM person_info WHERE id=?", id)
            except:nil
    if row.isNil or row.all(proc(x: string): bool = x.isNil or x == ""):
      # why cannot row.all(isNil) :/
      resp(Http404, msgjson(fmt"id {id} not found"),
        contentType="application/json")
    else:
      echo row
      resp(Http200, $(%*{
        "id": id,
        "name": row[1],
        "age": row[2]
        }), contentType = "application/json")

  post "/register":
    let body = try: request.body.parseJson
               except: newJNull()
    if body.isNil:
      resp(Http400, msgjson("Invalid json"),
        contentType="application/json")
    try:
      db.exec(sql"""
        INSERT INTO person_info(name, age)
        VALUES (?, ?);""",
        body["name"].getStr, body["age"].getInt)
      var id = db.getRow(sql"SELECT LAST_INSERT_ROWID();")[0].parseInt
      resp(Http200, $(%*{"id": id}) , contentType="application/json")
    except:
      resp(Http500, msgjson("something happened"), contentType="application/json")

runForever()
```
