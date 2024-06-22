# Fibonacci - Spin App

spin.toml

```toml
spin_version = "1"
authors = ["MikeTeddyOmondi <mike_omondi@outlook.com>"]
description = ""
name = "fibonacci-spin-app"
trigger = { type = "http", base = "/" }
version = "0.1.0"

[[component]]
id = "fibonacci-spin-app"
source = "target/wasm32-wasi/release/fibonacci_spin_app.wasm"
key_value_stores = ["default"]
[component.trigger]
route = "/..."
[component.build]
command = "cargo build --target wasm32-wasi --release"
```

src/lib.rs

```rust
use anyhow::Result;
use spin_sdk::{
    http::{Request, Response},
    http_component,
    key_value::{Error, Store},
};
use serde::{Serialize, Deserialize};
use serde_json::{from_slice, json, to_string, to_vec};

#[derive(Debug, Serialize, Deserialize)]
struct ReqBody {
    number: i64
}

fn fibonacci(n: i64) -> usize {
    if n == 0 {
        return 0;
    } else if n == 1 {
        return 1;
    }

    let mut prev_prev: usize = 0;
    let mut prev: usize = 1;
    let mut curr: usize;

    for _ in 2..=n {
        curr = prev + prev_prev;
        prev_prev = prev;
        prev = curr;
    }

    return prev;
}

/// A simple Spin HTTP component.
#[http_component]
fn fibonacci_spin_app(req: Request) -> Result<Response> {
    let store = Store::open_default()?;

    println!("headers: {:#?}", req.headers());

    let value = req.body(); //.unwrap();

    let v = match value {
        Some(v) => v,
        None => todo!()
    };
    // println!("v: {:#?}", v);

    let request_body: ReqBody = from_slice(&v).unwrap();
    println!("req_body: {:#?}", request_body);

    let ReqBody { number } = request_body;
    let result = fibonacci(number);

    // let response_body = format!("The fibonacci of number {} is {}", number, result);
    let response_body = json!({"result": result});
    let response_body = to_string(&response_body)?;

    store.set("fibonacci_result".to_string(), to_vec(&response_body).unwrap())?;

    // let stored_value = store.get("fibonacci_result".to_string()).unwrap();
    // println!("{:#?}", from_slice::<ReqBody>(&stored_value));

    Ok(http::Response::builder()
        .status(200)
        .header("foo", "bar")
        .body(Some(response_body.into()))?)
}
```
