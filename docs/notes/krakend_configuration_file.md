# KrakenD API Gateway

KrakenD is an open-source API gateway that allows developers to create, operate and manage high-performance APIs. It provides a centralized point of control for all incoming and outgoing API traffic and offers a variety of features, including:

1. Routing: KrakenD allows developers to route incoming requests to the appropriate backend service or microservice.

2. Protocol transformation: KrakenD supports multiple protocols such as REST, gRPC, GraphQL, and WebSockets and can transform incoming requests and outgoing responses into the appropriate format.

3. Load balancing: KrakenD provides load balancing capabilities that can distribute incoming requests across multiple backend services to improve performance and availability.

4. Caching: KrakenD supports caching of frequently accessed resources to improve API response times.

5. Authentication and authorization: KrakenD provides a variety of authentication and authorization mechanisms, including JWT, OAuth2, and basic authentication.

6. Monitoring and logging: KrakenD provides real-time monitoring and logging of API traffic to help developers identify and troubleshoot issues.

KrakenD is built using the Go programming language and is designed to be highly performant and scalable. It can be deployed on-premises or in the cloud and can integrate with a variety of backend services and systems.

An example of a KrakenD configuration file that routes traffic to three different services

```json
{
    "version": 2,
    "timeout": "3000ms",
    "endpoints": [
        {
            "endpoint": "/users",
            "method": "GET",
            "backend": [
                {
                    "url_pattern": "/users",
                    "host": "http://users-service:8080"
                }
            ]
        },
        {
            "endpoint": "/products",
            "method": "GET",
            "backend": [
                {
                    "url_pattern": "/products",
                    "host": "http://products-service:8080"
                }
            ]
        },
        {
            "endpoint": "/orders",
            "method": "GET",
            "backend": [
                {
                    "url_pattern": "/orders",
                    "host": "http://orders-service:8080"
                }
            ]
        }
    ]
}
```

This configuration file defines three endpoints, each of which has a single backend service. The `/users` endpoint routes traffic to the `users-service` on port `8080`, the `/products` endpoint routes traffic to the `products-service` on port `8080`, and the `/orders` endpoint routes traffic to the `orders-service` on port `8080`.

This is a simple example, but KrakenD is highly configurable and can handle much more complex routing scenarios.

Using version 3 of the configuration file for KrakenD not 2 in json

```json
{
    "version": 3,
    "timeout": "3000ms",
    "endpoints": [
        {
            "endpoint": "/users",
            "method": "GET",
            "output_encoding": "json",
            "backend": [
                {
                    "url_pattern": "/users",
                    "host": [
                        "http://users-service:8080"
                    ],
                    "encoding": "json",
                    "sd": "dns",
                    "healthcheck": {
                        "path": "/healthcheck",
                        "interval": "10s",
                        "timeout": "2s",
                        "strategy": "http"
                    }
                }
            ]
        },
        {
            "endpoint": "/products",
            "method": "GET",
            "output_encoding": "json",
            "backend": [
                {
                    "url_pattern": "/products",
                    "host": [
                        "http://products-service:8080"
                    ],
                    "encoding": "json",
                    "sd": "dns",
                    "healthcheck": {
                        "path": "/healthcheck",
                        "interval": "10s",
                        "timeout": "2s",
                        "strategy": "http"
                    }
                }
            ]
        },
        {
            "endpoint": "/orders",
            "method": "GET",
            "output_encoding": "json",
            "backend": [
                {
                    "url_pattern": "/orders",
                    "host": [
                        "http://orders-service:8080"
                    ],
                    "encoding": "json",
                    "sd": "dns",
                    "healthcheck": {
                        "path": "/healthcheck",
                        "interval": "10s",
                        "timeout": "2s",
                        "strategy": "http"
                    }
                }
            ]
        }
    ]
}
```

This configuration file uses the version 3 syntax, which includes additional options for health checks and service discovery. It defines the same three endpoints as the previous example, but also includes health checks for each backend service to ensure they are available and working properly.

Note that the `encoding` field is set to `json` for each backend service, indicating that requests and responses should be encoded in JSON format. Also, the `sd` field is set to `dns`, indicating that service discovery should be done using DNS lookups.

Overall, KrakenD's version 3 syntax provides additional flexibility and functionality for configuring API gateways.

The equivalent configurations in YAML:

```yaml
version: 3
timeout: 3000ms
endpoints:
  - endpoint: "/users"
    method: GET
    output_encoding: json
    backend:
      - url_pattern: "/users"
        host:
          - "http://users-service:8080"
        encoding: json
        sd: dns
        healthcheck:
          path: "/healthcheck"
          interval: 10s
          timeout: 2s
          strategy: http
  - endpoint: "/products"
    method: GET
    output_encoding: json
    backend:
      - url_pattern: "/products"
        host:
          - "http://products-service:8080"
        encoding: json
        sd: dns
        healthcheck:
          path: "/healthcheck"
          interval: 10s
          timeout: 2s
          strategy: http
  - endpoint: "/orders"
    method: GET
    output_encoding: json
    backend:
      - url_pattern: "/orders"
        host:
          - "http://orders-service:8080"
        encoding: json
        sd: dns
        healthcheck:
          path: "/healthcheck"
          interval: 10s
          timeout: 2s
          strategy: http
```

This configuration file uses the same YAML syntax as the previous example, but with the appropriate syntax changes. YAML is a human-readable data serialization language and is often easier to read and edit than JSON.

Note that the structure of the YAML file is similar to the JSON file, but uses indentation to denote nested objects and arrays. The `-` character is used to indicate list items in arrays. Overall, YAML provides a more readable and flexible format for KrakenD configuration files.

---

# Cross-Origin Resource Sharing (CORS) Configuration | KrakenD

When KrakenD endpoints are consumed from a browser, you should enable the **Cross-Origin Resource Sharing (CORS)** module, as browsers restrict cross-origin HTTP requests initiated from scripts.

When the Cross-Origin Resource Sharing (CORS) configuration is enabled, KrakenD uses additional HTTP headers to tell browsers that they can **use resources from a different origin** (domain, protocol, or port). For instance, you will need this configuration if your web page is hosted at [https://www.domain.com](https://www.domain.com/) and the Javascript references the KrakenD API at [https://api.domain.com](https://api.domain.com/).

## Configuration

CORS configuration lives in the root of the file, as it’s a service component. Add the namespace `security/cors` under the global `extra_config` as follows:

```json
{
  "version": 3,
  "extra_config": {
    "security/cors": {
      "allow_origins": [
        "*"
      ],
      "allow_methods": [
        "GET",
        "HEAD",
        "POST"
      ],
      "expose_headers": [
        "Content-Length",
        "Content-Type"
      ],
      "allow_headers": [
        "Accept-Language"
      ],
      "max_age": "12h",
      "allow_credentials": false,
      "debug": false
    }
  }
```

The configuration options of this component are as follows:

| ##### [`allow_credentials`](https://www.krakend.io/docs/service-settings/cors/#allow_credentials "Click to copy link to allow_credentials")<br><br>  <br>*boolean* | When requests can include user credentials like cookies, HTTP authentication or client side SSL certificates.  <br>Defaults to `false` |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------- |

| ##### [`allow_headers`](https://www.krakend.io/docs/service-settings/cors/#allow_headers "Click to copy link to allow_headers")<br><br>  <br>*array* | An array with the headers allowed, but `Origin`is always appended to the list. Requests with headers not in this list are rejected.  <br>Defaults to `[]` |
| ---------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------- |

| ##### [`allow_methods`](https://www.krakend.io/docs/service-settings/cors/#allow_methods "Click to copy link to allow_methods")<br><br>  <br>*array* | An array with all the HTTP methods allowed, in uppercase. Possible values are `GET`, `HEAD`,`POST`,`PUT`,`PATCH`,`DELETE`, or `OPTIONS`  <br>Defaults to `["GET","HEAD","POST"]` |
| ---------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |

| ##### [`allow_origins`](https://www.krakend.io/docs/service-settings/cors/#allow_origins "Click to copy link to allow_origins")<br><br>  <br>*array* | An array with all the origins allowed, examples of values are `https://example.com`, or `*` (any origin).  <br>Defaults to `["*"]` |
| ---------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------- |

| ##### [`debug`](https://www.krakend.io/docs/service-settings/cors/#debug "Click to copy link to debug")<br><br>  <br>*boolean* | Show debugging information in the logger, **use it only during development**.  <br>Defaults to `false` |
| ------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------ |

| ##### [`expose_headers`](https://www.krakend.io/docs/service-settings/cors/#expose_headers "Click to copy link to expose_headers")<br><br>  <br>*array* | List of headers that are safe to expose to the API of a CORS API specification.  <br>Defaults to `["Content-Length","Content-Type"]` |
| ------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |

| ##### [`max_age`](https://www.krakend.io/docs/service-settings/cors/#max_age "Click to copy link to max_age")<br><br>  <br>*string* | For how long the response can be cached. For zero values the `Access-Control-Max-Age` header is not set.  <br>Valid *duration units* are: `ns` (nanosec.), `us` or `µs` (microsec.), `ms` (millisec.), `s` (sec.), `m` (minutes), `h` (hours).  <br>Defaults to `"0h"` |
| ----------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |

> Allow credentials and wildcards
> 
> According to the CORS specification, you are not allowed to use wildcards and credentials at the same time. If you need to do this, [check this workaround](https://github.com/krakendio/krakend-cors/issues/9)

## Debugging configuration

The following configuration might help you debug your CORS configuration. Check the inline `@comments`:

```json
{
  "endpoints":[
        {
            "@comment": "this will fail due to double CORS validation",
            "endpoint":"/cors/no-op",
            "input_headers":["*"],
            "output_encoding": "no-op",
            "backend":[
                {
                    "url_pattern": "/__debug/cors",
                    "host": ["http://localhost:8080"],
                    "encoding": "no-op"
                }
            ]
        },
        {
            "@comment": "this won't fail because CORS preflight headers are removed from the request to the backend",
            "endpoint":"/cors/no-op/martian",
            "input_headers":["*"],
            "output_encoding": "no-op",
            "backend":[
                {
                    "url_pattern": "/__debug/cors/martian",
                    "host": ["http://localhost:8080"],
                    "encoding": "no-op",
                    "extra_config":{
                      "modifier/martian": {
                          "fifo.Group": {
                              "scope": ["request", "response"],
                              "aggregateErrors": true,
                              "modifiers": [
                                  {
                                    "header.Blacklist": {
                                      "scope": ["request"],
                                      "names": [
                                        "Access-Control-Request-Method",
                                        "Sec-Fetch-Dest",
                                        "Sec-Fetch-Mode",
                                        "Sec-Fetch-Site",
                                        "Origin"
                                      ]
                                    }
                                  }
                              ]
                          }
                      }
                    }
                }
            ]
        },
        {
            "@comment": "this won't fail because no headers are added to the request to the backend",
            "endpoint":"/cors/no-op/no-headers",
            "output_encoding": "no-op",
            "backend":[
                {
                    "url_pattern": "/__debug/cors/no-headers",
                    "host": ["http://localhost:8080"],
                    "encoding": "no-op"
                }
            ]
        }
]}
```

## Adding the OPTIONS method

When working in a SPA, you will usually receive `OPTIONS` calls to KrakenD; although this configuration is not related to CORS, it usually goes in hand.

To support `OPTIONS` in your endpoints, you only need to add the [flag `auto_options`](https://www.krakend.io/docs/service-settings/router-options/#auto_options) as follows:

{
"version": 3,
  "extra_config": {
    "router": {
       "auto_options": true
    },
    "security/cors": {
      "@comment": "...CORS configuration inside this block..."
    }

}

| ##### [`auto_options`](https://www.krakend.io/docs/service-settings/cors/#auto_options "Click to copy link to auto_options")<br><br>  <br>*boolean* | When true, enables the autogenerated OPTIONS endpoint for all the registered paths |
| --------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------- |

# Extensive Configuration File

```json
{
    "$schema": "https://www.krakend.io/schema/v3.json",
    "version": 3,
    "name": "KrakenD - API Gateway",
    "debug_endpoint": true,
    "tls": {
        "private_key": "/etc/krakend-src/tls/tls.key",
        "public_key": "/etc/krakend-src/tls/tls.crt",
        "ca_certs": [
            "/etc/krakend-src/tlsCA/service-ca.crt"
        ]
    },
    "extra_config": {

        "qos/ratelimit/service": {
            "max_rate": 5,
            "key": "",
            "strategy": "ip",
            "client_max_rate": 5
        },

        "telemetry/metrics": {
            "collection_time": "60s",
            "proxy_disabled": false,
            "router_disabled": false,
            "backend_disabled": false,
            "endpoint_disabled": false,
            "listen_address": ":8090"
        },

        "telemetry/logging": {
            "level": "DEBUG",
            "prefix": "[KRAKEND]",
            "syslog": false,
            "stdout": true
        },

        "router": {
            "auto_options": true
        },

        "security/cors": {
            "allow_origins": [
                "http://localhost:3000"
            ],
            "allow_methods": [
                "GET",
                "POST",
                "HEAD",
                "OPTIONS"
            ],
            "expose_headers": [
                "Content-Length",
                "Content-Type"
            ],
            "allow_headers": [
                "Accept",
                "Authorization",
                "Accept-Language",
                "Accept-Encoding",
                "Access-Control-Request-Headers",
                "Access-Control-Request-Method",
                "Access-Control-Allow-Origin",
                "Origin",
                "Content-Type",
                "Cache-Control",
                "Pragma",
                "Host",
                "User-Agent",
                "Connection",
                "Referer",
                "Sec-Fetch-Dest",
                "Sec-Fetch-Mode",
                "Sec-Fetch-Site"
            ],
            "max_age": "12h",
            "allow_credentials": true,
            "debug": true
        }
    },
    "timeout": "3000ms",
    "cache_ttl": "300s",
    "endpoints": [




        {
            "endpoint": "/dwapp/krakend/api/v1/parties/-/find",
            "output_encoding": "no-op",
            "method": "GET",
            "backend": [{
                "encoding": "no-op",
                "url_pattern": "/api/v1/parties/-/find",
                "method": "GET",
                "host": [
                    "https://k5-dwapp-partydir.banking-solutions-dev.svc"
                ],
                "extra_config": {

                    "modifier/martian": {
                        "header.Blacklist": {
                            "scope": ["request"],
                            "names": ["Access-Control-Request-Method", "Origin", "Sec-Fetch-Dest", "Sec-Fetch-Mode", "Sec-Fetch-Site", "Access-Control-Request-Header", "Access-Control-Request-Method"]
                        }
                    }
                }
            }],
            "input_headers": [
                "Authorization",
                "Content-Type",
                "Accept-Encoding",
                "Accept-Language",
                "X-B3-ParentSpanId",
                "X-B3-SpanId",
                "X-B3-TraceId",
                "X-B3-Sampled",
                "X-DEBUG-SESSION"
            ],
            "input_query_strings": [


                "considerHistorisedAddresses"

                ,
                "includeDeletedParties"

                ,
                "townName"

                ,
                "taxIdentificationNumber"

                ,
                "partyType"

                ,
                "country"

                ,
                "givenName"

                ,
                "middleName"

                ,
                "legalName"

                ,
                "birthDate"

                ,
                "establishmentDate"

            ]
        }

        , {
            "endpoint": "/dwapp/krakend/api/v1/parties/-/person/create",
            "output_encoding": "no-op",
            "method": "POST",
            "backend": [{
                "encoding": "no-op",
                "url_pattern": "/api/v1/parties/-/person/create",
                "method": "POST",
                "host": [
                    "https://k5-dwapp-partydir.banking-solutions-dev.svc"
                ],
                "extra_config": {

                    "modifier/martian": {
                        "header.Blacklist": {
                            "scope": ["request"],
                            "names": ["Access-Control-Request-Method", "Origin", "Sec-Fetch-Dest", "Sec-Fetch-Mode", "Sec-Fetch-Site", "Access-Control-Request-Header", "Access-Control-Request-Method"]
                        }
                    }
                }
            }],
            "input_headers": [
                "Authorization",
                "Content-Type",
                "Accept-Encoding",
                "Accept-Language",
                "X-B3-ParentSpanId",
                "X-B3-SpanId",
                "X-B3-TraceId",
                "X-B3-Sampled",
                "X-DEBUG-SESSION"
            ]
        }

        , {
            "endpoint": "/dwapp/krakend/api/v1/parties/-/organisation/create",
            "output_encoding": "no-op",
            "method": "POST",
            "backend": [{
                "encoding": "no-op",
                "url_pattern": "/api/v1/parties/-/organisation/create",
                "method": "POST",
                "host": [
                    "https://k5-dwapp-partydir.banking-solutions-dev.svc"
                ],
                "extra_config": {

                    "modifier/martian": {
                        "header.Blacklist": {
                            "scope": ["request"],
                            "names": ["Access-Control-Request-Method", "Origin", "Sec-Fetch-Dest", "Sec-Fetch-Mode", "Sec-Fetch-Site", "Access-Control-Request-Header", "Access-Control-Request-Method"]
                        }
                    }
                }
            }],
            "input_headers": [
                "Authorization",
                "Content-Type",
                "Accept-Encoding",
                "Accept-Language",
                "X-B3-ParentSpanId",
                "X-B3-SpanId",
                "X-B3-TraceId",
                "X-B3-Sampled",
                "X-DEBUG-SESSION"
            ]
        }


        ,


        {
            "endpoint": "/dwapp/krakend/api/v1/notifications/{userLogin}/retrieve",
            "output_encoding": "no-op",
            "method": "GET",
            "backend": [{
                "encoding": "no-op",
                "url_pattern": "/api/v1/notification-preferences/{userLogin}/retrieve",
                "method": "GET",
                "host": [
                    "https://k5-usrnoti.banking-solutions-dev.svc"
                ],
                "extra_config": {

                    "modifier/martian": {
                        "header.Blacklist": {
                            "scope": ["request"],
                            "names": ["Access-Control-Request-Method", "Origin", "Sec-Fetch-Dest", "Sec-Fetch-Mode", "Sec-Fetch-Site", "Access-Control-Request-Header", "Access-Control-Request-Method"]
                        }
                    }
                }
            }],
            "input_headers": [
                "Authorization",
                "Content-Type",
                "Accept-Encoding",
                "Accept-Language",
                "X-B3-ParentSpanId",
                "X-B3-SpanId",
                "X-B3-TraceId",
                "X-B3-Sampled",
                "X-DEBUG-SESSION"
            ]
        }

        , {
            "endpoint": "/dwapp/krakend/api/v1/notifications/{userLogin}/retrieve",
            "output_encoding": "no-op",
            "method": "POST",
            "backend": [{
                "encoding": "no-op",
                "url_pattern": "/api/v1/user-notifications/{userLogin}/retrieve",
                "method": "POST",
                "host": [
                    "https://k5-usrnoti.banking-solutions-dev.svc"
                ],
                "extra_config": {

                    "modifier/martian": {
                        "header.Blacklist": {
                            "scope": ["request"],
                            "names": ["Access-Control-Request-Method", "Origin", "Sec-Fetch-Dest", "Sec-Fetch-Mode", "Sec-Fetch-Site", "Access-Control-Request-Header", "Access-Control-Request-Method"]
                        }
                    }
                }
            }],
            "input_headers": [
                "Authorization",
                "Content-Type",
                "Accept-Encoding",
                "Accept-Language",
                "X-B3-ParentSpanId",
                "X-B3-SpanId",
                "X-B3-TraceId",
                "X-B3-Sampled",
                "X-DEBUG-SESSION"
            ]
        }

        , {
            "endpoint": "/dwapp/krakend/api/v1/notifications/-/dismiss",
            "output_encoding": "no-op",
            "method": "POST",
            "backend": [{
                "encoding": "no-op",
                "url_pattern": "/api/v1/user-notifications/-/dismiss",
                "method": "POST",
                "host": [
                    "https://k5-usrnoti.banking-solutions-dev.svc"
                ],
                "extra_config": {

                    "modifier/martian": {
                        "header.Blacklist": {
                            "scope": ["request"],
                            "names": ["Access-Control-Request-Method", "Origin", "Sec-Fetch-Dest", "Sec-Fetch-Mode", "Sec-Fetch-Site", "Access-Control-Request-Header", "Access-Control-Request-Method"]
                        }
                    }
                }
            }],
            "input_headers": [
                "Authorization",
                "Content-Type",
                "Accept-Encoding",
                "Accept-Language",
                "X-B3-ParentSpanId",
                "X-B3-SpanId",
                "X-B3-TraceId",
                "X-B3-Sampled",
                "X-DEBUG-SESSION"
            ]
        }

        , {
            "endpoint": "/dwapp/krakend/api/v1/notifications/{userLogin}/update",
            "output_encoding": "no-op",
            "method": "PUT",
            "backend": [{
                "encoding": "no-op",
                "url_pattern": "/api/v1/notification-preferences/{userLogin}/update",
                "method": "PUT",
                "host": [
                    "https://k5-usrnoti.banking-solutions-dev.svc"
                ],
                "extra_config": {

                    "modifier/martian": {
                        "header.Blacklist": {
                            "scope": ["request"],
                            "names": ["Access-Control-Request-Method", "Origin", "Sec-Fetch-Dest", "Sec-Fetch-Mode", "Sec-Fetch-Site", "Access-Control-Request-Header", "Access-Control-Request-Method"]
                        }
                    }
                }
            }],
            "input_headers": [
                "Authorization",
                "Content-Type",
                "Accept-Encoding",
                "Accept-Language",
                "X-B3-ParentSpanId",
                "X-B3-SpanId",
                "X-B3-TraceId",
                "X-B3-Sampled",
                "X-DEBUG-SESSION"
            ]
        }


        ,


        {
            "endpoint": "/dwapp/krakend/api/v1/customers/-/find",
            "output_encoding": "json",
            "method": "GET",
            "backend": [{
                "encoding": "json",
                "url_pattern": "/api/v1/customers/-/find",
                "method": "GET",
                "host": [
                    "https://k5-dwapp-customer.banking-solutions-dev.svc"
                ],
                "extra_config": {

                    "modifier/martian": {
                        "header.Blacklist": {
                            "scope": ["request"],
                            "names": ["Access-Control-Request-Method", "Origin", "Sec-Fetch-Dest", "Sec-Fetch-Mode", "Sec-Fetch-Site", "Access-Control-Request-Header", "Access-Control-Request-Method"]
                        }
                    }
                }
            }],
            "input_headers": [
                "Authorization",
                "Content-Type",
                "Accept-Encoding",
                "Accept-Language",
                "X-B3-ParentSpanId",
                "X-B3-SpanId",
                "X-B3-TraceId",
                "X-B3-Sampled",
                "X-DEBUG-SESSION"
            ],
            "input_query_strings": [


                "name"

                ,
                "includeHistory"

                ,
                "employeeId"

                ,
                "employeeEmail"

                ,
                "partyId"

            ]
        }


        ,


        {
            "endpoint": "/dwapp/krakend/indexes/{index_uid}/search",
            "output_encoding": "no-op",
            "method": "POST",
            "backend": [{
                "encoding": "no-op",
                "url_pattern": "/indexes/{index_uid}/search",
                "method": "POST",
                "host": [
                    "http://dwapp-meilisearch-banking-solutions-dev.banking-solutions-dev.svc:7700"
                ],
                "extra_config": {

                    "modifier/martian": {
                        "header.Blacklist": {
                            "scope": ["request"],
                            "names": ["Access-Control-Request-Method", "Origin", "Sec-Fetch-Dest", "Sec-Fetch-Mode", "Sec-Fetch-Site", "Access-Control-Request-Header", "Access-Control-Request-Method"]
                        }
                    }
                }
            }],
            "input_headers": [
                "Authorization",
                "Content-Type",
                "Accept-Encoding",
                "Accept-Language",
                "X-B3-ParentSpanId",
                "X-B3-SpanId",
                "X-B3-TraceId",
                "X-B3-Sampled",
                "X-DEBUG-SESSION"
            ]
        }

        , {
            "endpoint": "/dwapp/krakend/indexes/{index_uid}/search",
            "output_encoding": "no-op",
            "method": "GET",
            "backend": [{
                "encoding": "no-op",
                "url_pattern": "/indexes/{index_uid}/search",
                "method": "GET",
                "host": [
                    "http://dwapp-meilisearch-banking-solutions-dev.banking-solutions-dev.svc:7700"
                ],
                "extra_config": {

                    "modifier/martian": {
                        "header.Blacklist": {
                            "scope": ["request"],
                            "names": ["Access-Control-Request-Method", "Origin", "Sec-Fetch-Dest", "Sec-Fetch-Mode", "Sec-Fetch-Site", "Access-Control-Request-Header", "Access-Control-Request-Method"]
                        }
                    }
                }
            }],
            "input_headers": [
                "Authorization",
                "Content-Type",
                "Accept-Encoding",
                "Accept-Language",
                "X-B3-ParentSpanId",
                "X-B3-SpanId",
                "X-B3-TraceId",
                "X-B3-Sampled",
                "X-DEBUG-SESSION"
            ]
        }

        , {
            "endpoint": "/dwapp/krakend/indexes/{index_uid}/documents",
            "output_encoding": "no-op",
            "method": "POST",
            "backend": [{
                "encoding": "no-op",
                "url_pattern": "/indexes/{index_uid}/documents",
                "method": "POST",
                "host": [
                    "http://dwapp-meilisearch-banking-solutions-dev.banking-solutions-dev.svc:7700"
                ],
                "extra_config": {

                    "modifier/martian": {
                        "header.Blacklist": {
                            "scope": ["request"],
                            "names": ["Access-Control-Request-Method", "Origin", "Sec-Fetch-Dest", "Sec-Fetch-Mode", "Sec-Fetch-Site", "Access-Control-Request-Header", "Access-Control-Request-Method"]
                        }
                    }
                }
            }],
            "input_headers": [
                "Authorization",
                "Content-Type",
                "Accept-Encoding",
                "Accept-Language",
                "X-B3-ParentSpanId",
                "X-B3-SpanId",
                "X-B3-TraceId",
                "X-B3-Sampled",
                "X-DEBUG-SESSION"
            ]
        }


    ]
}
```

# Google Groups (KrakenD):

Link: [Can't get CORS config to work (google.com)](https://groups.google.com/a/krakend.io/g/community/c/UGxS0PE3Ybs/m/S5Hyw4FKAQAJ)

The auto_options in the router section enables the OPTION method for all registered endpoints in the gateway. **It is completely unrelated to the CORS configuration**. When using auto_options, the gateway does not call or involve any backend when used, as it simply returns an "allow" header with the supported methods. For instance:

$ curl -XOPTIONS -i http://localhost:8080/test HTTP/1.1 200 OK **Allow: DELETE, GET** X-Krakend: Version 2.3.2-ee
Date: Fri, 07 Jul 2023 08:52:05 GMT
Content-Length: 0

The backend has not been called.

Now to the CORS part. When you enable the CORS middleware (I am using your configuration), if the client does not set any CORS-related headers (i.e. Origin or Access-Control-Request-Method) it keeps having the same output as before and CORS does not trigger:

$ curl -XOPTIONS -i http://localhost:8080/test HTTP/1.1 200 OK **Allow: DELETE, GET** X-Krakend: Version 2.3.2-ee
Date: Fri, 07 Jul 2023 08:52:05 GMT
Content-Length: 0

When you pass CORS header, such as the header Access-Control-Request-Method, CORS is triggered, and you can see the **Vary** header added by the CORS middleware:

$ curl -H'Access-Control-Request-Method: GET' -XOPTIONS -i http://localhost:8080/test HTTP/1.1 204 No Content **Vary: Origin
Vary: Access-Control-Request-Method
Vary: Access-Control-Request-Headers** Date: Fri, 07 Jul 2023 08:55:49 GMT

And you can see in the KrakenD logs in this case:

2023/07/07 08:57:09 KRAKEND DEBUG: [CORS] 2023/07/07 08:57:09 Handler: Preflight request
origin **missing origin**

As you can see, the origin is missing in our previous test. Let's add it:

$ curl **-H'Origin: [http://localhost:8080](http://localhost:8080/)'** **-H'Access-Control-Request-Method: GET'** -XOPTIONS -i http://localhost:8080/test HTTP/1.1 204 No Content
Access-Control-Allow-Credentials: true
Access-Control-Allow-Methods: GET
Access-Control-Allow-Origin: [http://localhost:8080](http://localhost:8080/) Access-Control-Max-Age: 43200
Vary: Origin
Vary: Access-Control-Request-Method
Vary: Access-Control-Request-Headers
Date: Fri, 07 Jul 2023 08:58:04 GMT

And now you see in the KrakenD logs:

2023/07/07 08:58:25 KRAKEND DEBUG: [CORS] 2023/07/07 08:58:25 Handler: Preflight request
s: map[Access-Control-Allow-Credentials:[true] Access-Control-Allow-Methods:[GET] Access-Control-Allow-Origin:[[http://localhost:8080](http://localhost:8080/)] Access-Control-Max-Age:[43200] Vary:[Origin Access-Control-Request-Method Access-Control-Request-Headers]]
2023/07/07 08:58:25 KRAKEND DEBUG: [CORS] 2023/07/07 08:58:25 Preflight response headers: map[Access-Control-Allow-Credentials:[true] Access-Control-Allow-Methods:[GET] Access-Control-Allow-Origin:[[http://localhost:8080](http://localhost:8080/)] Access-Control-Max-Age:[43200] Vary:[Origin Access-Control-Request-Method Access-Control-Request-Headers]]

CORS is working.

To better understand the flow, you can have a look at the source code of the component: https://github.com/rs/cors/blob/master/cors.go

I would start with an allow of ["*"] for your tests, and also for input_headers and make it more restrictive. Also, as a backend, you can use temporarily a KrakenD backend (with an echo endpoint) to discard problems with the backend integration.  

From here, honestly, I don't know how I can offer more practical help, as you don't specify your testing process, what headers you are sending, and so on... If it's impossible to reproduce what you are doing, it isn't easy to help.

Your configuration is correct, the tests above are copy and paste of the config you pasted, replacing the 3000 port with 8080.
