# Spin Outbound PostgreSQL Database

GitHub Link: [spin/examples/rust-outbound-pg/src/lib.rs at main · fermyon/spin (github.com)](https://github.com/fermyon/spin/blob/main/examples/rust-outbound-pg/src/lib.rs)

src (lib.rs) :

```rust
#![allow(dead_code)]
use anyhow::Result;
use spin_sdk::{
    http::{Request, Response},
    http_component,
    pg::{self, Decode},
};

// The environment variable set in `spin.toml` that points to the
// address of the Pg server that the component will write to
const DB_URL_ENV: &str = "DB_URL";

#[derive(Debug, Clone)]
struct Article {
    id: i32,
    title: String,
    content: String,
    authorname: String,
    coauthor: Option<String>,
}

impl TryFrom<&pg::Row> for Article {
    type Error = anyhow::Error;

    fn try_from(row: &pg::Row) -> Result<Self, Self::Error> {
        let id = i32::decode(&row[0])?;
        let title = String::decode(&row[1])?;
        let content = String::decode(&row[2])?;
        let authorname = String::decode(&row[3])?;
        let coauthor = Option::<String>::decode(&row[4])?;

        Ok(Self {
            id,
            title,
            content,
            authorname,
            coauthor,
        })
    }
}

#[http_component]
fn process(req: Request) -> Result<Response> {
    match req.uri().path() {
        "/read" => read(req),
        "/write" => write(req),
        "/pg_backend_pid" => pg_backend_pid(req),
        _ => Ok(http::Response::builder()
            .status(404)
            .body(Some("Not found".into()))?),
    }
}

fn read(_req: Request) -> Result<Response> {
    let address = std::env::var(DB_URL_ENV)?;

    let sql = "SELECT id, title, content, authorname, coauthor FROM articletest";
    let rowset = pg::query(&address, sql, &[])?;

    let column_summary = rowset
        .columns
        .iter()
        .map(format_col)
        .collect::<Vec<_>>()
        .join(", ");

    let mut response_lines = vec![];

    for row in rowset.rows {
        let article = Article::try_from(&row)?;

        println!("article: {:#?}", article);
        response_lines.push(format!("article: {:#?}", article));
    }

    // use it in business logic

    let response = format!(
        "Found {} article(s) as follows:\n{}\n\n(Column info: {})\n",
        response_lines.len(),
        response_lines.join("\n"),
        column_summary,
    );

    Ok(http::Response::builder()
        .status(200)
        .body(Some(response.into()))?)
}

fn write(_req: Request) -> Result<Response> {
    let address = std::env::var(DB_URL_ENV)?;

    let sql = "INSERT INTO articletest (title, content, authorname) VALUES ('aaa', 'bbb', 'ccc')";
    let nrow_executed = pg::execute(&address, sql, &[])?;

    println!("nrow_executed: {}", nrow_executed);

    let sql = "SELECT COUNT(id) FROM articletest";
    let rowset = pg::query(&address, sql, &[])?;
    let row = &rowset.rows[0];
    let count = i64::decode(&row[0])?;
    let response = format!("Count: {}\n", count);

    Ok(http::Response::builder()
        .status(200)
        .body(Some(response.into()))?)
}

fn pg_backend_pid(_req: Request) -> Result<Response> {
    let address = std::env::var(DB_URL_ENV)?;
    let sql = "SELECT pg_backend_pid()";

    let get_pid = || {
        let rowset = pg::query(&address, sql, &[])?;
        let row = &rowset.rows[0];

        i32::decode(&row[0])
    };

    assert_eq!(get_pid()?, get_pid()?);

    let response = format!("pg_backend_pid: {}\n", get_pid()?);

    Ok(http::Response::builder()
        .status(200)
        .body(Some(response.into()))?)
}

fn format_col(column: &pg::Column) -> String {
    format!("{}:{:?}", column.name, column.data_type)
}
```

db (testdata.sql) :

```sql
CREATE TABLE articletest (
   id integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
   title varchar(40) NOT NULL,
   content text NOT NULL,
   authorname varchar(40) NOT NULL,
   coauthor text
);

INSERT INTO articletest (title, content, authorname) VALUES
(
   'My Life as a Goat',
   'I went to Nepal to live as a goat, and it was much better than being a butler.',
   'E. Blackadder'
),
(
   'Magnificent Octopus',
   'Once upon a time there was a lovely little sausage.',
   'S. Baldrick'
);
```

spin.toml :

```toml
spin_manifest_version = "1"
authors = ["Fermyon Engineering <engineering@fermyon.com>"]
name = "rust-outbound-pg-example"
trigger = { type = "http" }
version = "0.1.0"

[[component]]
environment = { DB_URL = "host=localhost user=postgres dbname=spin_dev" }
id = "outbound-pg"
source = "target/wasm32-wasi/release/rust_outbound_pg.wasm"
[component.trigger]
route = "/..."
[component.build]
command = "cargo build --target wasm32-wasi --release"
```

Spin up:

```shell
createdb spin_dev
psql -d spin_dev -f db/testdata.sql
RUST_LOG=spin=trace spin build --up
```

curl the read route :

```shell
$ curl -i localhost:3000/read
HTTP/1.1 200 OK
content-length: 501
date: Sun, 25 Sep 2022 15:45:02 GMT

Found 2 article(s) as follows:
article: Article {
    id: 1,
    title: "My Life as a Goat",
    content: "I went to Nepal to live as a goat, and it was much better than being a butler.",
    authorname: "E. Blackadder",
}
article: Article {
    id: 2,
    title: "Magnificent Octopus",
    content: "Once upon a time there was a lovely little sausage.",
    authorname: "S. Baldrick",
}

(Column info: id:DbDataType::Int32, title:DbDataType::Str, content:DbDataType::Str, authorname:DbDataType::Str)
```

curl the write route : 

```shell
$ curl -i localhost:3000/write
HTTP/1.1 200 OK
content-length: 9
date: Sun, 25 Sep 2022 15:46:22 GMT

Count: 3
```
