# Fibonnaci | Rust

Code example:

```rust
use std::env;

fn main() {
    let args: Vec<String> = env::args().collect();

    if args.len() != 2 {
        println!("Usage: fibonacci <n>");
        return;
    }

    let n: u32 = match args[1].trim().parse() {
        Ok(num) => num,
        Err(_) => {
            println!("Please enter a valid integer.");
            return;
        }
    };

    let result = fibonacci(n);

    println!("The {}th Fibonacci number is: {}", n, result);
}

fn fibonacci(n: u32) -> u64 {
    if n == 0 {
        return 0;
    } else if n == 1 {
        return 1;
    }

    let mut prev_prev: u64 = 0;
    let mut prev: u64 = 1;
    let mut curr: u64;

    for _ in 2..=n {
        curr = prev + prev_prev;
        prev_prev = prev;
        prev = curr;
    }

    return prev;
}
```

### To run this on a WASM platform

Yes, this program can be compiled to run on a WebAssembly (WASM) platform. Rust has great support for compiling to WASM, and you can use the `wasm-pack` tool to package your Rust code as a WebAssembly module that can be used in a web application.

Here are the high-level steps to compile and package this program for use in a web application:

1. Install the Rust toolchain and the `wasm-pack` tool. You can find instructions on how to install these tools on the Rust and `wasm-pack` websites, respectively.

2. Create a new Rust project using the `cargo new` command:
   
   ```
   cargo new fibonacci-wasm
   ```

3. Change to the new project directory and add the following to the `Cargo.toml` file to configure the project for building a WebAssembly module:
   
   ```
   [lib]
   crate-type = ["cdylib"]
   
   [dependencies]
   wasm-bindgen = "0.2.74"
   ```

4. Replace the contents of the `src/main.rs` file with the following:
   
   ```rust
   extern crate wasm_bindgen;
   
   use wasm_bindgen::prelude::*;
   
   #[wasm_bindgen]
   pub fn fibonacci(n: u32) -> u64 {
       if n == 0 {
           return 0;
       } else if n == 1 {
           return 1;
       }
   
       let mut prev_prev: u64 = 0;
       let mut prev: u64 = 1;
       let mut curr: u64;
   
       for _ in 2..=n {
           curr = prev + prev_prev;
           prev_prev = prev;
           prev = curr;
       }
   
       return prev;
   }
   ```
   
   This code is similar to the original program, but uses the `wasm_bindgen` crate to generate a JavaScript interface for the `fibonacci` function.

5. Build the WebAssembly module using the `wasm-pack build` command:
   
   ```
   wasm-pack build --target web
   ```

6. This will generate a `pkg/` directory containing the compiled WebAssembly module, as well as a JavaScript file that exports the `fibonacci` function.

You can now use the WebAssembly module in a web application by importing the JavaScript file and calling the `fibonacci` function as you would any other JavaScript function.
