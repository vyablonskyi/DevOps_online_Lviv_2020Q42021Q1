**Part 1**

The most popular hypervisors are:
- VMware vSphere/ESXi
- Hyper-V
- KVM / Red Hat Enterprise Virtualization
- Xen / Citrix XenServer
- Oracle Virtual Box
- VMware Workstation 

First four belong to Type 1 - they run directly on the hardware side, last two belong to Type 2 - they run on the host OS.
Also hypervisors divided on Monolithic and Microkernel, as example of the firs group can be VMware ESX, Hyper-V belogs to the second group.

Below you may see table which made at the beginning of the 2020, there compars features of the most popular Type 1 hypervisors:

Feature | Hyper-V 2019 | vSphere 6.7 | XenServer 7.6 | KVM |
------- | ------------ | ------------ | ------------ | ------------ |
RAM/Host | 24TB | 12TB | 5TB | 12TB
RAM/VM   | 12TB gen2, 1TB gen1 | 6TB | 1.5TB | 6TB
CPUs/VM | 240 gen2, 64 gen1 |	128 |	32 |	240
VM Disk	| 64TB VHDX, 2040GB VHD |	62TB |	2TB |	10TB
VM Live Migration |	Yes |	Yes |	Yes |	Yes
VM Replication supports |	Yes |	Yes |	Yes |	Yes
Overcommit resources |	No |	Yes |	No |	Yes
Disk I/O Throttling |	Yes |	Yes |	Yes |	Yes
Hot plug of virtual resources |	Yes |	Yes |	Yes |	Yes


**Part 2**

According to the points  1.1 - 1.3 there were installed Oracle VirtualBox on my PC and was built new VM with the newest Ubuntu server on board:

[view screenshot](screenshots/001.JPG)

Existed VM was cloned and both machines was added to the ne group:

[view screenshot](screenshots/002.JPG)

For the first VM there were taken a few smapshots:

[view screenshot](screenshots/003.JPG)

Also this VM was exported to \*.ova file:

[view screenshot](screenshots/004.JPG)

after that from this file there was built new VM:

[view screenshot](screenshots/005.JPG)

[view screenshot](screenshots/006.JPG)

Also was tested adding USB device to VM:

[view screenshot](screenshots/007.JPG)

and configured shared folder:

[view screenshot](screenshots/008.JPG)

There was checked all network modes and as result I'd got the following table:
 
--- | VM > Host |	Host > VM |	VM1 <> VM2 |	VM > LAN |	LAN > VM
 --- |--- | --- | --- | --- | --- 
NAT |	+ |	Port forwarding |	- |	+ |	Port forwarding
Bridged Adapter |	+ |	+ |	+ |	+ |	+
Internal Network |	- |	- |	+ |	- |	-
Host-only Adapter |	+ |	+ |	+ |	- |	-
NAT network |	+ |	Port forwarding |	+ |	+ |	Port forwarding


Also I experimented with *VBoxManage* and manage VMs via command line interface


**Part 3**

Vagrant was installed on my PC and environment with the default Vagrant was initiated:

[view screenshot](screenshots/009.JPG)

after running this machine I was able to access it via SSH from host mashine via forwarded SSH port:

[view screenshot](screenshots/010.JPG)

After that was created my own vagrant environment which contains two Ubuntu 16 based VPSes. Appropriate *Vagrantfile* may be found [here](Vagrantfile) 




