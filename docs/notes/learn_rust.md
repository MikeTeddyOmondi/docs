# Learning Rust

## Intro:

Rust is a systems programming language that allows for building applications that are performant and efficient during runtime. Rust programs are memory safe and their performance metrics are close to that of C language.

## Installation:

1. Windows: `choco install rustc`

2. Linux:`curl ...`  

> 📌Be sure to check the Rust docs [here](https://rust-lang.org/docs)  

### Creating a New Project:

```shell
cargo new <PROJECT_NAME>
```

### Ownership

![](C:\Users\Administrator\AppData\Roaming\marktext\images\2023-07-16-22-05-54-image.png)

Three rules of ownership:

![](C:\Users\Administrator\AppData\Roaming\marktext\images\2023-07-16-22-07-55-image.png)

> <img title="" src="file:///C:/Users/Administrator/AppData/Roaming/marktext/images/2023-07-16-22-08-28-image.png" alt="" data-align="center">

#### Importance of ownership in Rust

Ownership prrevents memory safety issues:

1. Dangling pointers

2. Double-free - trying to free memory that has already been freed

3. Memory leaks - not freeing memory that should have been freed

### Borrowing

![](C:\Users\Administrator\AppData\Roaming\marktext\images\2023-07-16-22-26-09-image.png)

Rules of References:

<img title="" src="file:///C:/Users/Administrator/AppData/Roaming/marktext/images/2023-07-16-22-39-44-image.png" alt="" data-align="inline">
