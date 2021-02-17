**Networking with Linux**


On the ***host machine 192.168.0.109*** there in VirtualBox were built two VMs with Ubuntu 18.4 onboard:

1. ***gateway*** with [two network interfaces](screenshots/001.JPG):
  - NAT adapter with IP ***10.0.2.15*** that was assigned by dhcp and where 22 port is being forwrded to 27517 port of host machine 
  - Internal adapter with manually [by netplan](screenshots/002.JPG) configured ***192.168.23.1*** IP address

2. ***localmachine*** with one Internal adapter that configured to get IP address via DHCP


On the ***gateway*** machine there was installed ***isc-dhcp-server*** that [is listening on the Internal interface](screenchots/003.JPG) with the simple [dhcpd.conf](screenshot/004.JPG) configuration file.

After running the ```netplan apply``` command on the ***localmachine*** network interface was provided with IP address ***192.168.23.20*** and [other network settings.](screenshots/005.JPG)

As result the ***gateway*** IP address ***192.168.23.1*** [was got pingable](screenshots/005.JPG) from the ***localmachine***

On the ***gateway*** there was enabled forwarding by uncommenting the ```net.ipv4.ip_forward = 1``` string in ***/etc/sysctl.conf*** file, server was rebooted

After running the ```iptables -t nat -A POSTROUTING -o enp0s3 -j MASQUERADE``` rule on the ***gateway*** Internet was got accesible from the ***localmachine*** server:


- Route from ***localmachine*** to ***Host***:
```
root@localmachine:~# mtr -r -c 3 -n 192.168.0.109
Start: 2021-02-17T20:16:27+0000
HOST: localmachine                Loss%   Snt   Last   Avg  Best  Wrst StDev
  1.|-- 192.168.23.1               0.0%     3    1.4   1.1   0.5   1.4   0.5
  2.|-- 10.0.2.2                   0.0%     3    1.9   2.1   1.9   2.3   0.2
  3.|-- 192.168.0.109              0.0%     3    3.0   7.0   3.0  14.8   6.7
root@localmachine:~#
```

- Ping to 8.8.8.8:
```
root@localmachine:~# ping 8.8.8.8
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=117 time=35.6 ms
64 bytes from 8.8.8.8: icmp_seq=2 ttl=117 time=32.1 ms
64 bytes from 8.8.8.8: icmp_seq=3 ttl=117 time=43.6 ms

--- 8.8.8.8 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2004ms
rtt min/avg/max/mdev = 32.161/37.156/43.655/4.811 ms
root@localmachine:~#
```

- Determine, which  resource has an IP address 8.8.8.8
```
root@localmachine:~# host 8.8.8.8
8.8.8.8.in-addr.arpa domain name pointer dns.google.
root@localmachine:~#
```

- Determine, which  IP address belongs to resource epam.com.
```
root@localmachine:~# dig +short epam.com
3.214.134.159
root@localmachine:~#
```


- Determine the default gateway for your HOST and display routing table.
By running the ```netstat -r``` command on the ***Host*** machine there was determined the [routing table](screenshot/006.JPG) and that default gateway is ***192.168.0.1***


- Trace the route from the ***localmachine*** to google.com. 
```
traceroute to google.com (216.58.215.78), 30 hops max, 60 byte packets
 1  192.168.23.1  0.405 ms  0.386 ms  0.284 ms
 2  10.0.2.2  0.572 ms  0.556 ms  0.537 ms
 3  * * *
 4  * * *
 5  * * *
 6  * * *
 7  * * *
 8  * * *
 9  * * *
10  * * *
11  * * *
12  * * *
13  * * *
14  * * *
15  * * *
16  * * *
17  * * *
18  * * *
19  * * *
20  * * *
21  * * *
22  * * *
23  * * *
24  * * *
25  * * *
26  * * *
27  * * *
28  * * *
29  * * *
30  * * *
root@localmachine:~#
root@localmachine:~# mtr -r -c 2 -n google.com
Start: 2021-02-17T20:31:04+0000
HOST: localmachine                Loss%   Snt   Last   Avg  Best  Wrst StDev
  1.|-- 192.168.23.1               0.0%     2    1.0   0.8   0.6   1.0   0.3
  2.|-- 10.0.2.2                   0.0%     2    2.0   1.9   1.7   2.0   0.2
  3.|-- 192.168.0.1               50.0%     2   35.3  35.3  35.3  35.3   0.0
  4.|-- 10.1.1.1                   0.0%     2   28.1  22.3  16.5  28.1   8.2
  5.|-- 10.0.0.2                   0.0%     2  166.9  89.0  11.0 166.9 110.3
  6.|-- 193.25.181.70              0.0%     2   94.7  60.5  26.4  94.7  48.3
  7.|-- 108.170.248.146            0.0%     2  125.2  75.2  25.2 125.2  70.8
  8.|-- 142.250.227.43            50.0%     2   53.6  53.6  53.6  53.6   0.0
  9.|-- 108.170.250.193            0.0%     2   26.8  58.3  26.8  89.8  44.5
 10.|-- 216.239.41.169             0.0%     2   31.8  47.9  31.8  64.0  22.8
 11.|-- 172.217.20.206             0.0%     2   85.8 168.2  85.8 250.6 116.5
root@localmachine:~#
```
