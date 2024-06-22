Lian_Yu | TryHackMe Documentation

____________________________________

1. Scan the machine for open ports - using Nmap tool

nmap -p- -T4 -v -A -oN nmapInfo.txt 10.10.183.14
nmap -sC -sV 10.10.183.14

```shell
sudo nmap -sV -sN -Pn 10.10.38.251
[sudo] password for kali: 
Starting Nmap 7.94 ( https://nmap.org ) at 2023-08-29 11:07 EDT
Nmap scan report for 10.10.38.251
Host is up (0.18s latency).
Not shown: 996 closed tcp ports (reset)
PORT    STATE SERVICE VERSION
21/tcp  open  ftp     vsftpd 3.0.2
22/tcp  open  ssh     OpenSSH 6.7p1 Debian 5+deb8u8 (protocol 2.0)
80/tcp  open  http    Apache httpd
111/tcp open  rpcbind 2-4 (RPC #100000)
Service Info: OSs: Unix, Linux; CPE: cpe:/o:linux:linux_kernel
```

2. Search for hidden directories in the machine - using gobuster tool

gobuster dir -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -u http://10.10.183.14
