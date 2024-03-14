# Typescript

---

## Contents:

1. Intro to Javascript Language
  
2. Deep Dive into Typescript Language
  

---

## Intro to Javascript Language

---

### Keywords

`var` `let` `const` `string` `number` e.t.c

### Naming Conventions

`camelCase`

### Shortcomings of Javascript

Examples:

```js
// examples here
```

---

## Deep Dive into Typescript Language

---

### **Type Annotations**

This is providing types to variables

```js
// string
let name: string = "Jon";

// number
let age: number = 23;

// boolean
let isEmployed: boolean = true;
```

### **Type inference**

A feature in TS that allows the compiler to automatically determine the type of a variable based on its value.

```js
// string
let name = "Jon"
let age = 23
let isEmployed = true
```

### **`Any` Type**

A TS valkue that allows a variable to have any value disabling type-checking on the variable. (Not recommended)

```js
// string
let name: any = "Jon"
let age: any = 23
let isEmployed: any = true
```

### **Function Parameter Annotations**

Used to specify the expected types of the parameters that a function takes.

```js
// regular function
function addNumbers(numA: number, numB: number) {
    return numA + numB;
}

// arrow functions
const multiply(x: number, y: number) => x * y;

// using the functions
const result = addNumbers(20, 30);
console.log(result);

const product = multiply(6, 10);
console.log(product);
```

### Default value parameters

It initialises the value of the function parameter to the provided value

```js
// default value parameter
function greet(name: string = "Ghost) {
    return `Hi ${name}`;
}

const result = greet();
console.log(result);
```

### Return value type annotations

Used to specify the type of the value that a function returns to a caller.

```js
// regular function
function addNumbers(numA: number, numB: number): number {
    return numA + numB;
}

// arrow functions
const multiply(x: number, y: number): number => x * y;

// using the functions
const result = addNumbers(20, 30);
console.log(result);

const product = multiply(6, 10);
console.log(product);
```

### Void

Refers to absence of any value. Often used as a return type for functions that do not return a value

```js
// regular function
function printMessage(message: string): void {
    console.log(`Printed message: ${message}`);
}

printMessage("dummy message!");
```

### Never

Is a keyword used to indicate that a function will not return anything or that a variable can never have a value.

Useful for indicating that certain code paths should never be reached, or that certain values are inaccessible. It can help catch errors at compile-time instead of runtime.

Uses cases:

1. A function that always throw an error
  
2. A function that has an infinite loop
  
3. A variable that can never have a value
  

```js
// 1 
function throeErr(msg: string): never {
    throw new Error(msg);
}

// 2
function infiniteLoop(): never {
    while (true) {}
}

// 3
let x = never;

function neverReturns(): never {
    while (true) {}
}

// raises error
x = neverRetuns();
```

### Array Types

Is a type of object that can store multiple values of the same data type.

Arrays in TS are typed i.e. you can specify the type o values that an array can hold.

Can be initialised in two ways:

1. Using the square brackets notation [] to indicate an array of a specific type.
  
2. Using the generic Array<type> notation to indicate an array of a specific type.
  

```js
// Bracket [] notation
const numbers: number[] = [1, 2, 3, 4]; 

// Generic Array<type> notation
const names: Array<string> = ["Alice", "Bob", "Charlie"]; 
```

### Multi Dimensional Arrays

An array that contains other array as its elements.

They can be defines using the same notation as one-dimensional arrays but with nested square brackets.

```js
// 1D array
const singleDi: number[] = [1, 2, 3, 4, 5, 6]

// e.g matrix
const matrix: number[][] = [
    [1, 2],
    [3, 4]
];
```

### Objects

Is a structured data type that represents a collection of properties, each with a **key** and an associated **value**.

The properties of an objects can have **specific types** and and the object itself can be annotated with a type, often defined using an **interface** or a **type** alias.

TS uses structural typing, meaning that the shape of an object (*its structure or properties*) is what matters for type compatibility.

Syntax: `type Foo (annotations/types) = { property: value }`

```js
// examples
const person: { fisrtName: string; lastName: string; age: number } = {
    firstName: "Jon",
    lastName: "Doe",
    age: 28
}

// Objects as function return value
function printUser(): { name: string; age: number; address: string } {
    return {
        name: "Alice",
        age: 30,
        address: "NRB"
    }
}
```

### Type Aliases

Is a way to create a new name for an existing data type. It allows definitions of custom type that refers to another type and give it more descriptive name.

They are defined using the `type`keyword followed by the name alias an equal sign and then the type is refers to

Syntax: `type Foo = bar;`

```js
type Person = {
    name: string;
    age: number;
}

function printPerson(person: Person) {
    console.log(`Name: ${person.name}, Age: ${person.age}`)
}

const bob: Person = { name: "bob", age: 36 };
printPerson(bob);
```

#### Optional Properties

You can make a certain property optional in an object type by adding a question mark `?` after the property name

```js
// phoneNumber is optional 
type User = {
    name: string;
    age: number;
    email: string;
    phoneNumber?: number 
}
```

### Intersection Types

A way to combine multiple types into a single type that includes all the properties and methods of each constituent type.

Denoted by `&` symbol

```js
type Person = {
    name: string;
    age: number;
};

type Employee = {
    id: number;
    title; string;
};

type PersonAndEmployee = Person & Employee;

const alice: PersonAndEmployee = {
    name: "Alice",
    age: 30,
    id: 234567,
    title: "Manager",
};
```

### Union Types

Declares a type thast can have one of several possble types.

Useful when allowing a variable/parameter accept multiple types.

Denoted by `|` symbol

```js
type Person = {
    name: string;
    age: number;
};

type Employee = {
    id: number;
    title; string;
};

type PersonAOrEmployee = Person | Employee;

const alice: PersonOrEmployee = {
    name: "Alice",
    age: 30,
};

const bob: PersonOrEmployee = {
    id: 234567,
    title: "Manager",
} 
```

### Literal Types

Allows you to specify a value that can only be **one specific literal value** i.e a variable can have one spicific value or no other.

```js
// string literal types
let color: "red" | "blue" | "green";
color = "red"; // valid
color = "yellow"; // invalid

// number literal types
let number: 1 | 2 | 3;
number = 1; // valid
number = 5; // invalid

// boolean literal types
let isTrue: true;
isTrue = true; // valid
isTrue = false; // invalid 
```

### Tuples

A type that represents an array with a **fixed number of elements** where each element can have a different type.

The order of the types in the tuple definition corresponds to the order of the values in the actual array.

They are similar to arrays, but thay have a specific structure and can be used to model a finite sequence with known lengths.

```js
let myTuple: [string, number, boolean] = ["hello", 42, true];

// destructure the tuple
let [first, second, third] = myTuple;
```

### Enums

Is a way to define a set of **named constants**. They allow you to define a collection of related values that can be used interchangeably in your code.

```js
// e.g weather conditions
// a wather enum with its values automatic numral values starting from 0 
enum Weather {
    Sunny,
    Cloudy,
    Rainy,
    Snowy,
}

// a weather enum with its value assinged to string literals
enum Weather {
    Sunny = "sunny",
    Cloudy = "cloudy",
    Rainy = "rainy",
    Snowy = "snowy",
}

const currentWeather = Weather.Sunny;
console.log(`The current weather is ${currentWeather}!`)
// Output: The current weather is sunny! 
```

---

### Classes | Object Oriented Programming (OOP)

---

#### Class Properties Annotations

You can annotate class properties with a type. This allows you to define tha data type of the property and ensure that it is always consistent.

```js
class Person {
    name: string;
    age: number;
    readonly email: string;

    constructor(name: string, age: number, email?: string) {
        this.name = name;
        this.age = age;
    }
}

const person = new Person("jon", 20);
console.log(person)
```

#### Access Modifiers

Can be used to control visibility of class members (properties and methods).

They determine the ways in ehich class members can be accessed from within an d outside the class.

There are 3 types in TS:

1. Public - members can be accessed from anywhere, both inside and outside the class.
  
2. Private - members can only be accessed from within the class they are defined in.
  
3. Protected - members can be accessed within the class they are defined in, as well as any subclasses that extend the class.
  

```js
class Animal {
    public name: string;
    private age: number;
    protected species: string;

    constructor(name: string, age: number, species: string) {
        this.name = name;
        this.age = age;
        this.species = species;
    }    

    public getName(): string {
         return this.name;   
    }    

    private getAge(): number {
         return this.age;
    }

    protected getSpecies(): string {
        return this.species;
    }    
}

class Dog extends Animal {
    constructor(name: string, age: number) {
        super(name, age, "Carnivores")
    }

    public getInfo(): string {
        return `${this.getName()} is a ${this.getSpecies()} and is ${this.age} years old`
    }    
}
```

#### Getters & Setters

Are used to access and modify class properties.

They allow one define a property in a class that looks like a simple variable from the outside but internally has additional logic for getting and setting the value.

```js
class MyClass {
    private _prop: number = 0;

    get MyProp(): number {
        return this._prop;
    }

    set MyProp(value: number) {
        if (value < 0) {
            throw new Error("Value cannot be negative!");
        }
        this._prop = value;
    }    
}

const instance = new MyClass();
// getter
console.log(`Current value: ${instance.MyProp}`); 
// setter
```

---

### Interfaces

Is a way to define a **contract** for the shape of an object. It specifies the properties and their types that an object must have. Its a powerful tool for enforcing a certain structure in one's code.

```js
interface Person {
    firstName: string;
    lastName: string;
    age: numbe;
}

const p1: Person = {
    firstName: "Jon",
    lastName: "Doe",
    age: 30,
}
```

Interfaces are not only used to define structure of objects, but also define the shape of functions and classes.

###### Functions

```js
// interface for a function
interface MathOperation {
    (x: number, y: number): number;
}

// Usage
const add: MathOperation = (a, b) => a + b;
const subtract: MathOperation = (a, b) => a - b;
```

###### Classes

```js
// interface for a class
interface Vehicle {
    start(): void;
    stop(): void;
}

// class implementing the interface
class Car implements Vehicle {
    start() {
        console.log("Car started!");
    }

    stop() {
        console.log("Car stopped!");
    }
}

// Usage
const vitz = new Car();
vitz.start();
vitz.stop();
```

#### Declaration Merging

Once an interface is declared, it cannot be directly modified. However, TS allows **declaration merging** or **interface extansion** which is miscontrued as "re-opening".

Declaration merging - the ability to extenf or augment an existing declaration, including interfaces. Its usefil when one wants to add new properties or methods to an existing interface without modifying the original declaration.

```js
// original interface
interface Car {
    brand: string;
    start(): void;
}

// Declaration merging (interface extension)
interface Car {
    model: string;
    stop(): void;
}

// Usage
const audi: Car = {
    brand: "Audi",
    model: "A7",
    start(): {
        console.log("Car started!");
    }, 
    stop(): {
        console.log("Car stopped!");
    },
} 
```

##### More examples on Interfaces...

```js
interface Computer {
    model: string;
    guid: string;
    ram: number;
    rom: number;
}

interface Movie {
    readonly name: string;
    ratings: number;
    isFav?: boolean;
}

interface MovieGenre extends Movie {
    genre: string;
}

interface Person {
    firstName: string;
    lastName: string;
    age: number;
    sayHello(): void;
}

function greet(person: Person) {
    console.log(`Hello ${person.firstName} ${person.lastName}`);
    person.sayHello();
}

const jaha: Person = {
    firstName: "Jaha",
    lastName: "Thelonius",
    age: 53,
    sayHello() {
        console.log("Hello there!");
    },        
}; 


greet(jaha);
```

---

### Generics

Allow you to create reusable components that can work with a variety of types.

They make it possible for you to define functions, classes, and interfaces that can work with **different data types** without having to duplicate code.

```js
// regular fucntion
const printString = (x: string) => return x;
const printNumber = (y: number) => return y;
const printBoolean = (z: boolean) => return z;

cosole.log(printString("foo");
console.log(printNumber(1));
console.log(printBoolean(true));


// generic function
function print<T>(x: T): T { return x };

const printStr = print<string>("foo");
const printNum = print<number>(1_000_000);
const printBool = print<boolean>(true);

interface Dog {
    name: string;
    breed: string;
}

const printRuby = print<Dog>({name: "Ruby", breed: "rottweiller"});
const printScooby = print<Dog>({name: "Scooby", breed: "germanShepherd"});


// generic classes
class Box<T> {
    private content: T;

    constructor(initialContent: T) {
        this.content = initialContent;
    }

    getContent(): T {
        return this.content;
    }

    setContent(newContent: T) {
        this.content = newContent;
    }
}

type Mail = {
    sender: string;
    receiver: string;
    subject: string;
    message: string;
}

const mailBox = new Box<Mail>({
    sender: "Bob";
    receiver: "Alice";
    subject: "Table Banking";
    message: "Please make payment!";
});
console.log(mailBox.getContent())

mailBox.setContent({
    sender: "Charlie";
    receiver: "Bob";
    subject: "Insurance";
    message: "Reminder to make deposit!";
});
console.log(mailBox.getContent())
```

##### More examples on Generics...

```js
// Ger random key & value
functions getRandomKVPair<T>(obj: {[key: string]: T}): {
    key: string;
    value: T
} {
    const keys = Object.keys(obj);
    const randomKey = keys[Math.floor(Math.random() * keys.length)];
    return { key: randomKey, value: obj[randomKey]};
}

const fruitsBasket = {a: "apple", b: "banana", c: "cherry"};
const randomFruit = getRandomKVPair<string>(fruitsBasket);
console.log(randomFruit);

const numberBasket = {one: 1, two: 2, three: 3};
const randomNumber = getRandomKVPair<number>(numberBasket);
console.log(randomNumber);

// filter arrays
function filterArray<T>(array: T[], condition: (item: T) => boolean): T[] {
    return array.filter((item) => condition(item))
}

const numbersArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
const evenNumbers = filterArray<number>(numbersArray, (num) => num % 2 === 0);
console.log(evenNumbers);

const stringArray = ["apple", "banana", "cherry", "pears"];
const shortWords = filterArray<string>(stringArray, (str) => str.length < 6);

// Quiz: find the shotest word in the array
// const shortestWord = filterArray<string>(stringArray, (str) => {
//   for (let i = 0; i < stringArray.length; i++) {
//     console.log(i);
//     str.length < stringArray[i].length;
//   }
//   return true;
// });
// console.log(shortestWord);
```

---

### Type Narrowing

Is the process of refining a variable's type within a conditional block of code.

Allows writing precise and type-safe code.

TS provides several mechanisms for narrowing types:

1. Type guards - mechanism that help TS understand and narrow down the types more precisely. E.g `typeof` operator
  
  ```js
  // Define a union type
  type MyType = string | number;
  
  // Example function with typeof type guard
  function myFunction(value: MyType): void {
      // Type guard using typeof
      if (typeof value === "string") {
          // within this block TS knows that 'value' is a string
          console.log(value.toUpperCase());
      } else {
          // within this block TS knows that 'value' is a number
          console.log(value.toFixed(2));
      }
  }
  
  // Usage
  myFunction("hello"); // hello
  myFunction(34) // 34.00
  ```
  
2. The `instanceof` operator - allows one to check whether an object is an instance of a particular class or constructor function
  
  ```js
  class Dog {
      bark(): void {
          console.log("Woof!");
      }
  }
  
  class Cat {
      purr(): void {
          console.log("Meow!");
      }
  }
  
  // Example function with instanceof type guard
  function sound(animal: Dog | Cat): void {
      // Type guard using instanceof
      if (animal instanceof Dog) {
          // within this block TS knows that 'animal' is a Dog
          console.log(animal.bark());
      } else {
          // within this block TS knows that 'animal' is a Cat
          console.log(animal.purr());
      }
  }
  
  // Usage
  const dog = new Dog();
  const cat = new Cat();
  
  sound(dog); // Woof!
  sound(cat); // Meow!
  ```
  
3. Intersection types - allows one to combine multiple types into a single type. The resulting type will have all the properties of each individual type. Created by the `&` operator.
  
  ```js
  type Person = {
      name: string;
      age: number;
  };
  
  type Employee = {
      id: number;
      title; string;
  };
  
  type PersonAndEmployee = Person & Employee;
  
  const alice: PersonAndEmployee = {
      name: "Alice",
      age: 30,
      id: 234567,
      title: "Manager",
  };
  ```
  
4. ~~Discriminated unions~~
  

---

## Setting Up a Typescript Project

Install Typescript compiler as dev dependency or globally

```shell
npm i -D typescript # as dev dependency
npm i -g typescript # globally
```

Create a project folder and change directory into the folder

```shell
mkdir typescript-course
cd typescript-course
```

Initialise typescript in a project

```shell
# Creates a tsconfig.json with the recommended settings in the working directory.
tsc --init 
```

Configure the `tsconfig.json` file to your project's preference

```json
{
  "compilerOptions": {
    "target": "es6",
    "allowJs": true,
    "strict": true,
    "noEmit": true,
    "esModuleInterop": true,
    "module": NodeNext",
    "moduleResolution": "NodeNext",
    "isolatedModules": true,
    "incremental": true,
    "plugins": [],
    "OutDir": "./dist",
    "paths": {
      "@/*": ["./*"]
    }
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules"],
  "files": ["index.ts"] // compile specific files only
}
```

Declarative files - is the file that a developer can provide custom types required by the project. The files are named this way`<FILENAME>.d.ts`

> Source code for more type declarations [DefinitelyTyped](http://github.com/DefinitelyTyped/DefinitelyTyped)

---

## Examples:

**Axios** - HTTP Client

**Express** - HTTP framework

```shell
# install express 
npm i express

# install declaration files
npm i @types/expres
```

File: `index.ts`

```js
import express, {Request, Response} from "express";

const app = express();
const PORT = 3000;

app.get("/", (req, Request, res: Response) => {
    res.json({
        "success": true,
        "data": {
            "message": "Typescript with Express!"
        }
    });
});

app.listen(PORT, () => {
    console.log(`Server running: http://localhost:${PORT}`)
});
```

**React** - Frontend Library

**NextJs** - React Framework

---