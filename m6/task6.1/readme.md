**Networking with Linux**


On the ***host machine 192.168.0.109*** there in VirtualBox were built two VMs with Ubuntu 18.4 onboard:

1. ***gateway*** with [two network interfaces](screenshots/001.jpg):
- NAT adapter with IP ***10.0.2.15*** that was assigned by dhcp and where 22 port is being forwrded to 27517 port of host machine 
- Internal adapter with manually [by netplan](screenshots/002.jpg) configured ***192.168.23.1*** IP address
2.***localmachine*** with one Internal adapter that configured to get IP address via DHCP


On the ***gateway*** machine there was installed ***isc-dhcp-server*** that [is listening on the Internal interface](screenchots/003.jpg) with the simple [dhcpd.conf](screenshot/004.jpg) configuration file.
After running the *netplan apply* command on the ***localmachine*** network interface was provided with IP address ***192.168.23.20*** and [other settings](screenshots/005.jpg)




1. Create virtual machines connection according to figure 1:VM1VM2HOSTINTERNETFigure 1 – VMs connection

2. VM2 has one interface (internal), VM1 has 2 interfaces (NAT and internal). Configure  all networkinterfaces in order to make VM2 has an access to the Internet (iptables, forward, masquerade).   

3. Check the route from VM2 to Host.

4. Check the access to the Internet, (just ping, for example, 8.8.8.8). 

5. Determine, which  resource has an IP address 8.8.8.8.

6. Determine, which  IP address belongs to resource epam.com.

7. Determine the default gateway for your HOST and display routing table.

8. Trace the route to google.com. 
