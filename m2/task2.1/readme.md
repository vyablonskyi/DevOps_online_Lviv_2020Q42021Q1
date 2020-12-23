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
|Feature  |Windows Hyper-V 2019 |vSphere 6.7  |XenServer 7.6  |KVM  |
|RAM/Host |24TB                 |12TB         |5TB            |12TB |
|RAM/VM	12 TB for generation 2;	6 TB	1.5TB	6 TB
|1 TB for generation 1
|CPUs/VM	240 for generation 2;	128	32	240
|64 for generation 1;
|VM Disk	64 TB for VHDX format;	62TB	2TB	10TB
|2040 GB for VHD format
|VM Live Migration	Yes	Yes	Yes	Yes
|VM Replication supports	Yes	Yes	Yes	Yes
|Overcommit resources	No	Yes	No	Yes
|Disk I/O Throttling	Yes	Yes	Yes	Yes
|Hot plug of virtual resources	Yes	Yes	Yes	Yes
