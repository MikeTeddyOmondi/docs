# Learn Rust

Content:

1. Basic Types & Variables
2. Control Flow
3. References, Ownership, and Borrowing
4. Pattern Matching
5. Iterators
6. Error Handling
7. Combinators
8. Multiple error types
9. Iterating over errors
10. Generics, Traits, and Lifetimes
11. Functions, Function Pointers & Closures
12. Pointers
13. Smart pointers
14. Packages, Crates, and Modules

## 1. Basic Types & Variables

Boolean

`bool`

Unsigned integers

`u8`, `u16`, `u32`, `u64`, `u128`

Signed integers

`i8`, `i16`, `i32`, `i64`, `i128`

Floating point numbers

`f32`, `f64`

Platform specific integers

`usize` - Unsigned integer. Same number of bits as the platform's pointer type.

`isize` - Signed integer. Same number of bits as the platform's pointer type.

`char` - Unicode scalar value

`&str` - String slice

`String` - Owned string

Tuple

```rust
let coordinates = (82, 64);
let score = ("Team A", 12)
```

Array & Slice

```rust
// Arrays must have a known length and all elements must be initialized
let array = [1, 2, 3, 4, 5];
let array2 = [0; 3]; // [0, 0, 0]

// Unlike arrays the length of a slice is determined at runtime
let slice = &array[1 .. 3];
```

HashMap

```rust
use std::collections::HashMap;

let mut subs = HashMap::new();
subs.insert(String::from("foo"), 100000);

// Insert key if it doesn't have a value
subs.entry("foo".to_owned()).or_insert(3)
```

Struct

```rust
// Definition
struct User {
    username: String,
    active: bool,
}

// Instantiation
let user1 = User {
    username: String::from("foo"),
    active: true,
};

// Tuple struct
struct Color(i32, i32, i32);
let black = Color(0, 0, 0);
```

Enum

```rust
// Definition
enum Command {
    Quit,
    Move { x: i32, y: i32 },
    Speak(String),
    ChangeBGColor(i32, i32, i32),
}

// Instantiation
let msg1 = Command::Quit;
let msg2 = Command::Move{ x: 1, y: 2 };
let msg3 = Command::Speak("Hi".to_owned());
let msg4 = Command::ChangeBGColor(0, 0, 0);
```

Constant

```rust
const MAX_POINTS: u32 = 100_000;
```

Static variable

```rust
// Unlike constants static variables are
// stored in a dedicated memory location
// and can be mutated.
static MAJOR_VERSION: u32 = 1;
static mut COUNTER: u32 = 0;
```

Mutability

```rust
let mut x = 5;
x = 6;
```

Shadowing

```rust
let x = 5;
let x = x * 2;
```

Type alias

```rust
// `NanoSecond` is a new name for `u64`.
type NanoSecond = u64;
```

## 2. Control Flow

if and if let

```rust
let num = Some(22);

if num.is_some() {
    println!("number is: {}", num.unwrap());
}

// match pattern and assign variable
if let Some(i) = num {
    println!("number is: {}", i);
}
```

loop

```rust
let mut count = 0;
loop {
    count += 1;
    if count == 5 {
        break; // Exit loop
    }
}
```

Nested loops & labels

```rust
'outer: loop {
    'inner: loop {
        // This breaks the inner loop
        break;
        // This breaks the outer loop
        break 'outer;
    }
}
```

Returning from loops

```rust
let mut counter = 0;

let result = loop {
    counter += 1;
    if counter == 10 {
        break counter;
    }
};
```

while and while let

```rust
while n < 101 {
    n += 1;
}

let mut optional = Some(0);

while let Some(i) = optional {
    print!("{}", i);
}
```

for loop

```rust
for n in 1..101 {
    println!("{}", n);
}

let names = vec!["Bogdan", "Wallace"];

for name in names.iter() {
    println!("{}", name);
}
```

match

```rust
let optional = Some(0);

match optional {
    Some(i) => println!("{}", i),
    None => println!("No value.")
}
```

## 3. References, Ownership, and Borrowing

Ownership rules

1. Each value in Rust has a variable that’s called its
   owner.
2. There can only be one owner at a time.
3. When the owner goes out of scope, the value will
   be dropped.

Borrowing rules

1. At any given time, you can have either one
   mutable reference or any number of immutable
   references.
2. References must always be valid.

Creating references

```rust
let s1 = String::from("hello world!");
let s1_ref = &s1; // immutable reference

let mut s2 = String::from("hello");
let s2_ref = &mut s2; // mutable reference

s2_ref.push_str(" world!");
```

Copy, Move, and Clone

```rust
// Simple values which implement the Copy trait are copied by value
let x = 5;
let y = x;
println!("{}", x); // x is still valid

// The string is moved to s2 and s1 is invalidated
let s1 = String::from("Let's Get Rusty!");
let s2 = s1; // Shallow copy a.k.a move
println!("{}", s1); // Error: s1 is invalid

let s1 = String::from("Let's Get Rusty!");
let s2 = s1.clone(); // Deep copy

// Valid because s1 isn't moved
println!("{}", s1);
```

Ownership and functions

```rust
fn main() {
    let x = 5;
    takes_copy(x); // x is copied by value
    let s = String::from("Let’s Get Rusty!");

    // s is moved into the function
    takes_ownership(s);

    // return value is moved into s1
    let s1 = gives_ownership();
    let s2 = String::from("LGR");
    let s3 = takes_and_gives_back(s2);
}

fn takes_copy(some_integer: i32) {
    println!("{}", some_integer);
}

fn takes_ownership(some_string: String) {
    println!("{}", some_string);
} // some_string goes out of scope and drop is called. The backing memory is freed.

fn gives_ownership() -> String {
    let some_string = String::from("LGR");
    some_string
}

fn takes_and_gives_back(some_string: String) -> String {
    some_string
}
```
