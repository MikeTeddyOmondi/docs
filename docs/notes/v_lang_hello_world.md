# V-lang - Hello World

src/main.v

```v
module main

import json
import db.sqlite

struct User {
    name  string
    score i64
}

// sets a custom table name. Default is struct name (case-sensitive)
[table: 'customers']
struct Customer {
    id        int    [primary; sql: serial] // a field named `id` of integer type must be the first field
    name      string [nonull]
    nr_orders int
    country   string [nonull]
}

fn main() {
        println('Hello World!')

        db := sqlite.connect('customers.db')!

        // you can create tables:
        // CREATE TABLE IF NOT EXISTS `Customer` (
        //      `id` INTEGER PRIMARY KEY,
        //      `name` TEXT NOT NULL,
        //      `nr_orders` INTEGER,
        //      `country` TEXT NOT NULL
        // )
        sql db {
                create table Customer
        }!

        // select count(*) from customers
        nr_customers := sql db {
                select count from Customer
        }!

        println('number of all customers: ${nr_customers}')

        // V syntax can be used to build queries
        uk_customers := sql db {
                select from Customer where country == 'uk' && nr_orders > 0
        }!

        println(uk_customers.len)

        for customer in uk_customers {
                println('${customer.id} - ${customer.name}')
        }

        // insert a new customer
        // new_customer := Customer{
        //      name: 'Unco'
        //      nr_orders: 20
        //      country: 'uk'
        // }

        // sql db {
        //      insert new_customer into Customer
        // }!

        mut data := map[string]int{}
        user := &User{
                name: 'Pierre'
                score: 1024
        }

        data['x'] = 42
        data['y'] = 360

        println(json.encode(data)) // {"x":42,"y":360}
        println(json.encode(user)) // {"name":"Pierre","score":1024}
}
```
