<img src="file:///C:/Users/Administrator/Documents/Hotel%20Elmiriam%20-%20Microservice%20Architecture.png" title="" alt="Hotel Elmiriam - Microservice Architecture.png" data-align="center">

# User Panel

Deps:

```shell
npm i amqplib
```

## ~~Charts~~

[X] ~~Add charts to the overview page i.e bar graphs and pie charts specifically.~~

## API - Debugs & Config

Hotel API 

[ * ] Add invoice ID to Bookings schema

[ * ] Add status & payment_method field for Invoice schema

> If **Payment** is though ***Cash*** then its status remains ***Pending*** until the receipt is uploaded for reconciliations and the cash submited is equal to the amount claimed to be paid. 

Bar API

[ ] Add drinks route for drink categories

Email API

[ ] Introduce email service locally ([Mailpit](https:mailpit.org)) for testing emails being sent by the client

Payment API
[ ] Introduce payment service for M-pesa payments  

## Deploying CI/CD Setup for a Home lab & K8s
