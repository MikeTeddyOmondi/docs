# Python Sockets

Contents:

1. Multi-threaded TCP socket server

2. TCP socket client

---

## 1. Multi-threaded TCP socket server

When run with no arguments, this program starts a TCP socket server that listens for connections to 127.0.0.1 on
GoalKicker.com – Python® Notes for Professionals 529
port 5000. The server handles each connection in a separate thread.
When run with the -c argument, this program connects to the server, reads the client list, and prints it out. The
client list is transferred as a JSON string. The client name may be specified by passing the -n argument. By passing
different names, the effect on the client list may be observed.

### client_list.py



```python
import argparse
import json
import socket
import threading

def handle_client(client_list, conn, address):
 name = conn.recv(1024)
 entry = dict(zip(['name', 'address', 'port'], [name, address[0], address[1]]))
 client_list[name] = entry
 conn.sendall(json.dumps(client_list))
 conn.shutdown(socket.SHUT_RDWR)
 conn.close()

def server(client_list):
 print "Starting server..."
 s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
 s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
 s.bind(('127.0.0.1', 5000))
 s.listen(5)
 while True:
 (conn, address) = s.accept()
 t = threading.Thread(target=handle_client, args=(client_list, conn, address))
 t.daemon = True
 t.start()

def client(name):
 s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
 s.connect(('127.0.0.1', 5000))
 s.send(name)
 data = s.recv(1024)
 result = json.loads(data)
 print json.dumps(result, indent=4)

def parse_arguments():
 parser = argparse.ArgumentParser()
 parser.add_argument('-c', dest='client', action='store_true')
 parser.add_argument('-n', dest='name', type=str, default='name')
 result = parser.parse_args()
 return result

def main():
 client_list = dict()
 args = parse_arguments()
 if args.client:
     client(args.name)
 else:
 try:
     server(client_list)
 except KeyboardInterrupt:
     print "Keyboard interrupt"

if __name__ == '__main__':
 main()


```

### Server Output

```shell
$ python client_list.py
Starting server...
```

### Client Output

```shell
$ python client_list.py -c -n name1
{
 "name1": {
 "address": "127.0.0.1",
 "port": 62210,
 "name": "name1"
 }
}
```


The receive buffers are limited to 1024 bytes. If the JSON string representation of the client list exceeds this size, it
will be truncated. This will cause the following exception to be raised:
ValueError: Unterminated string starting at: line 1 column 1023 (char 1022)
