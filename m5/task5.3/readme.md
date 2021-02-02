**Part1**


1. *How many states could has a process in Linux?*

Processes can be at one of the following six states:
- created
- ready
- running
- waiting
- zombie
- terminated


2. *Examine the pstree command. Make output (highlight) the chain (ancestors) of the current process.*

The ***-h*** key of the ***pstree*** command provides the [output](screenshots/001.JPG) wish highlighted chain of current process (the "pstree -p -h" command that run in shell)


3. *What is a proc file system?*

The ***proc*** filesystem is a pseudo-filesystem that provides an interface to kernel data structures.  It is mountedd at ***/proc***.  It contains the useful information about the processes that are currently running, it is regarded as control and information centre for kernel.
The proc file system also provides communication medium between kernel space and user space.

Below is view of /proc on my test Ubuntu18 VPS:
```
root@test1:~# ls -a /proc
.      10858  11705  15   20   24   32   404  455  758  81   871        cgroups    driver       irq          kpageflags  mtrr          slabinfo       timer_list
..     11     11706  16   207  25   332  405  513  772  82   89         cmdline    execdomains  kallsyms     loadavg     net           softirqs       tty
1      115    11843  166  208  26   333  406  6    773  822  9          consoles   fb           kcore        locks       pagetypeinfo  stat           uptime
10     11519  11877  17   209  27   34   407  632  78   83   98         cpuinfo    filesystems  keys         mdstat      partitions    swaps          version
10847  11524  11894  18   21   28   35   408  650  782  846  acpi       crypto     fs           key-users    meminfo     sched_debug   sys            version_signature
10850  11541  12     189  210  280  36   409  7    79   853  asound     devices    interrupts   kmsg         misc        schedstat     sysrq-trigger  vmallocinfo
10854  11558  13     19   22   29   398  417  745  8    857  buddyinfo  diskstats  iomem        kpagecgroup  modules     scsi          sysvipc        vmstat
10857  11568  14     2    23   30   4    425  754  80   870  bus        dma        ioports      kpagecount   mounts      self          thread-self    zoneinfo
root@test1:~#
```


4. *Print information about the processor (its type, supported technologies, etc.).*

Below is presented output of the ***lscpu*** command that shows all information about CPU:
```
root@test1:~# lscpu
Architecture:        x86_64
CPU op-mode(s):      32-bit, 64-bit
Byte Order:          Little Endian
CPU(s):              1
On-line CPU(s) list: 0
Thread(s) per core:  1
Core(s) per socket:  1
Socket(s):           1
NUMA node(s):        1
Vendor ID:           GenuineIntel
CPU family:          6
Model:               142
Model name:          Intel(R) Core(TM) i5-8365U CPU @ 1.60GHz
Stepping:            12
CPU MHz:             1896.001
BogoMIPS:            3792.00
Hypervisor vendor:   KVM
Virtualization type: full
L1d cache:           32K
L1i cache:           32K
L2 cache:            256K
L3 cache:            6144K
NUMA node0 CPU(s):   0
Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx rdtscp lm constant_tsc rep_good nopl xtopology nonstop_tsc cpuid tsc_known_freq pni pclmulqdq monitor ssse3 cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx rdrand hypervisor lahf_lm abm 3dnowprefetch invpcid_single fsgsbase avx2 invpcid rdseed clflushopt md_clear flush_l1d arch_capabilities
root@test1:~#
```


5. *Use the ps command to get information about the process. The information should be as follows: the owner of the process, the arguments with which the process was launched for execution, the group owner of this process, etc.*

The following example of the ***ps*** command with bunch of keys outputs detailed information about bash process where the command was running:
```
tester@test1:~$ ps o user,pid,group,gid,%cpu,%mem,vsz,rss,tty,stat,start,time,comm -p 11944
USER       PID GROUP      GID %CPU %MEM    VSZ   RSS TT       STAT  STARTED     TIME COMMAND
tester   11944 testers   1000  0.0  0.4  21276  5036 pts/0    S    12:37:26 00:00:00 bash
tester@test1:~$
```


6. *How to define kernel processes and user processes?*

All kernel processes may be defined by checking output of the ***ps ax*** command. Commands all of them are between square brackets as in the example below:
```
tester@test1:~$ ps aux
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         2  0.0  0.0      0     0 ?        S    11:00   0:00 [kthreadd]
root         4  0.0  0.0      0     0 ?        I<   11:00   0:00 [kworker/0:0H]
root         6  0.0  0.0      0     0 ?        I<   11:00   0:00 [mm_percpu_wq]
root         7  0.0  0.0      0     0 ?        S    11:00   0:00 [ksoftirqd/0]
root         8  0.0  0.0      0     0 ?        R    11:00   0:01 [rcu_sched]
root         9  0.0  0.0      0     0 ?        I    11:00   0:00 [rcu_bh]
```


7. *Print the list of processes to the terminal. Briefly describe the statuses of the processes. What condition are they in, or can they be arriving in?*

The ***ps*** command describes status of each process by the following codes:
- D - uninterruptible sleep (usually IO)
- R - running or runnable (on run queue)
- S - interruptible sleep (waiting for an event to complete)
- T - stopped by job control signal
- t - stopped by debugger during the tracing
- W - paging (not valid since the 2.6.xx kernel)
- X - dead (should never be seen)
- Z - defunct ("zombie") process, terminated but not reaped by its parent

For BSD formats and when the stat keyword is used, additional characters may also be displayed:
 - < - high-priority (not nice to other users)
 - N - low-priority (nice to other users)
 - L - has pages locked into memory (for real-time and custom IO)
 - s - is a session leader
 - l - is multi-threaded (using CLONE_THREAD, like NPTL pthreads do)
 - \+ - is in the foreground process group

Below is the list of processs that are run under root SSH session where the ps command has been run:
```
root@test1:~# ps a
  PID TTY      STAT   TIME COMMAND
  870 tty1     Ss     0:00 /bin/login -p --
11541 tty1     S+     0:00 -bash
11705 pts/0    Ss     0:00 -bash
12046 pts/0    R+     0:00 ps a

```
Three processes are sleeping and one is running.


8. *Display only the processes of a specific user.*

Below presented all processes that was running under the "tester" user at the moment of checking:
```
root@test1:~# ps aux | grep ^tester
tester   12264  0.0  0.7  76684  7672 ?        Ss   20:23   0:00 /lib/systemd/systemd --user
tester   12265  0.0  0.2 111684  2336 ?        S    20:23   0:00 (sd-pam)
tester   12275  0.0  0.5  21468  5464 tty1     S    20:23   0:00 -bash
tester   12312  0.0  0.0   6216   836 tty1     S+   20:25   0:00 dd if=/dev/random of=/dev/null
```


9. *What utilities can be used to analyze existing running tasks (by analyzing the help for the ps command)?*

Man of the ***ps*** command recommends also to take a look at the  ***pgrep, pstree, top*** and ***proc*** utilities.


10. *What information does top command display?*

The ***top*** connamd displays sorted information about currenly running processes in real time, also it shows load average, CPU load, RAM and SWAP usage, time while the OS is up.


11. *Display the processes of the specific user using the top command.*

Below presented output of the ***top -u tester*** command which shows all processes of the ***tester** user:
```
top - 20:53:17 up  9:52,  2 users,  load average: 0.02, 0.01, 0.00
Tasks:  95 total,   1 running,  51 sleeping,   2 stopped,   0 zombie
%Cpu(s):  0.3 us,  0.3 sy,  0.0 ni, 99.3 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
KiB Mem :  1008776 total,   116176 free,   113276 used,   779324 buff/cache
KiB Swap:  2017276 total,  2017008 free,      268 used.   735364 avail Mem

  PID USER      PR  NI    VIRT    RES    SHR S %CPU %MEM     TIME+ COMMAND
12444 tester    20   0   76688   7728   6688 S  0.0  0.8   0:00.01 systemd
12445 tester    20   0  111684   2340     84 S  0.0  0.2   0:00.00 (sd-pam)
12455 tester    20   0   21468   5200   3500 S  0.0  0.5   0:00.05 bash
12467 tester    20   0    6216    872    808 S  0.0  0.1   0:00.00 dd
```

12. *What interactive commands can be used to control the top command? Give a couple of examples.*

I always use the ***"Shift+F"*** hotkeys after the ***top -c*** command is run, this allows to select dditional parameters from the list and select parameter that processes will be sorted by:
```
   Navigate with Up/Dn, Right selects for move then <Enter> or Left commits,
   'd' or <Space> toggles display, 's' sets sort.  Use 'q' or <Esc> to end!

* PID     = Process Id             TGID    = Thread Group Id
* USER    = Effective User Name    OOMa    = OOMEM Adjustment
* PR      = Priority               OOMs    = OOMEM Score current
* NI      = Nice Value             ENVIRON = Environment vars
* VIRT    = Virtual Image (KiB)    vMj     = Major Faults delta
* RES     = Resident Size (KiB)    vMn     = Minor Faults delta
* SHR     = Shared Memory (KiB)    USED    = Res+Swap Size (KiB)
* S       = Process Status         nsIPC   = IPC namespace Inode
* %CPU    = CPU Usage              nsMNT   = MNT namespace Inode
* %MEM    = Memory Usage (RES)     nsNET   = NET namespace Inode
* TIME+   = CPU Time, hundredths   nsPID   = PID namespace Inode
* COMMAND = Command Name/Line      nsUSER  = USER namespace Inode
* PPID    = Parent Process pid     nsUTS   = UTS namespace Inode
* UID     = Effective User Id      LXC     = LXC container name
* RUID    = Real User Id           RSan    = RES Anonymous (KiB)
  RUSER   = Real User Name         RSfd    = RES File-based (KiB)
* SUID    = Saved User Id          RSlk    = RES Locked (KiB)
  SUSER   = Saved User Name        RSsh    = RES Shared (KiB)
  GID     = Group Id               CGNAME  = Control Group name
* GROUP   = Group Name
  PGRP    = Process Group Id
  TTY     = Controlling Tty
  TPGID   = Tty Process Grp Id
  SID     = Session Id
  nTH     = Number of Threads
  P       = Last Used Cpu (SMP)
  TIME    = CPU Time
* SWAP    = Swapped Size (KiB)
  CODE    = Code Size (KiB)
  DATA    = Data+Stack (KiB)
  nMaj    = Major Page Faults
  nMin    = Minor Page Faults
  nDRT    = Dirty Pages Count
  WCHAN   = Sleeping in Function
  Flags   = Task Flags <sched.h>
  CGROUPS = Control Groups
  SUPGIDS = Supp Groups IDs
  SUPGRPS = Supp Groups Names
```


13. *Sort the contents of the processes window using various parameters (for example, the amount of processor time taken up, etc.)*

Bellow is the output of the ***top -c*** command with added SWAP usage for each process and it is sorted by SWAP usage:
```
top - 21:13:33 up 10:12,  2 users,  load average: 0.00, 0.00, 0.00
Tasks:  95 total,   1 running,  51 sleeping,   2 stopped,   0 zombie
%Cpu(s):  0.0 us,  0.7 sy,  0.0 ni, 99.3 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
KiB Mem :  1008776 total,   116176 free,   113268 used,   779332 buff/cache
KiB Swap:  2017276 total,  2017008 free,      268 used.   735372 avail Mem

  PID USER      PR  NI    VIRT    RES    SHR S %CPU %MEM     TIME+ COMMAND                                                                                         SWAP
  853 root      20   0  185948  20016  12120 S  0.0  2.0   0:00.06 /usr/bin/python3 /usr/share/unattended-upgrades/unattended-upgrade-shutdown --wait-for-signal    36
    1 root      20   0   77704   8828   6728 S  0.0  0.9   0:01.57 /sbin/init maybe-ubiquity                                                                         0
    2 root      20   0       0      0      0 S  0.0  0.0   0:00.00 [kthreadd]                                                                                        0
    4 root       0 -20       0      0      0 I  0.0  0.0   0:00.00 [kworker/0:0H]                                                                                    0
    6 root       0 -20       0      0      0 I  0.0  0.0   0:00.00 [mm_percpu_wq]                                                                                    0
    7 root      20   0       0      0      0 S  0.0  0.0   0:00.34 [ksoftirqd/0]                                                                                     0
    8 root      20   0       0      0      0 I  0.0  0.0   0:08.18 [rcu_sched]                                                                                       0
    9 root      20   0       0      0      0 I  0.0  0.0   0:00.00 [rcu_bh]                                                                                          0
   10 root      rt   0       0      0      0 S  0.0  0.0   0:00.00 [migration/0]                                                                                     0
   11 root      rt   0       0      0      0 S  0.0  0.0   0:00.19 [watchdog/0]                                                                                      0
   12 root      20   0       0      0      0 S  0.0  0.0   0:00.00 [cpuhp/0]                                                                                         0
   ```


14. *Concept of priority, what commands are used to set priority?*

All processes in Linux are started by default with the same priority and they are equal. The defauld priority value is 20 and it can be in 0 - 39 range. It is possible to start process with different priority by using the ***nice*** command or change priority of running process by using ***renice*** command or by usyng the ***r*** hotkey during the ***top*** utility is running.


15. *Can I change the priority of a process using the top command? If so, how?*

The ***r*** hotkey/command of the ***top*** utility allows to change priority of processes.

After pressing the "r" there will be possible to enter PID and then the value to nice it to. A  positive nice value will cause a process to lose priority, a negative nice value will cause a process to be viewed more prior by the kernel.  Ordinary users can only increase the nice value (make priority lower) and are prevented from lowering it(increase priority).


16. *Examine the kill command. How to send with the kill command process control signal? Give an example of commonly used signals.*

The syntax of the ***kill*** command is:
```
kill [OPTIONS] [PID]....
```
The ***kill*** command sends a signal to specified processes or process groups and causing them to behave according to the signal. When the signal is not specified, it hs default value ***-15*** (-TERM).

The most commonly used signals are:
- 1 (HUP) - Reload a process.
- 9 (KILL) - Kill a process.
- 15 (TERM) - Gracefully stop a process.

To get a list of all available signals, you should run the command with the ***-l*** option.


17. *Commands jobs, fg, bg, nohup. What are they for? Use the sleep, yes command to demonstrate the process control mechanism with fg, bg.*

The ***jobs, fg, bg, nohup*** commands are used to manage foregroud/background processes:
- ***jobs*** command shows list of background processes
```
root@test1:~# dd if=/dev/random of=/dev/null &
[1] 13458
root@test1:~# jobs
[1]+  Running                 dd if=/dev/random of=/dev/null &
root@test1:~#
```
- ***bg*** When some process is running it can be stopped and moved to background by pressing the "Ctrl"+"z" and after that the "bg" command is entered the process starts working again.

```
root@test1:~# yes testdrive >> /dev/null
^Z
[1]+  Stopped                 yes testdrive >> /dev/null
root@test1:~# jobs
[1]+  Stopped                 yes testdrive >> /dev/null
root@test1:~# bg
[1]+ yes testdrive >> /dev/null &
root@test1:~# jobs
[1]+  Running                 yes testdrive >> /dev/null &
root@test1:~#
```
- ***fg*** command get the process back to foreground
```
root@test1:~# date
Mon Feb  1 00:26:15 UTC 2021
root@test1:~# sleep 30 &
[1] 14032
root@test1:~# jobs
[1]+  Running                 sleep 30 &
root@test1:~# fg 1
sleep 30
root@test1:~# date
Mon Feb  1 00:26:52 UTC 2021
root@test1:~#
```
- ***nohup*** command allows to run any program after log out or exit from the system



**Part2**


1. *Check the implementability of the most frequently used OPENSSH commands in the MS Windows operating system. (Description of the expected result of the commands + screenshots: command – result should be presented)*

Below there is screenshots of the Windows PowerShell where were run most usable by me OPENSSH commands:
- [***ssh***](screenshots/002.JPG) the 192.168.0.106 VPS with Ubuntu18 onboard has been successfully accessed as expected.
- [***ssh-keygen***](screenshots/003.JPG) provate/public keys have been generated as expected
- [***scp***](screenshots/004.JPG) the "testfile.txt" hs been successfully uploaded on the 192.168.0.106 server

I can only confirm that all threee tested commands work as expected


2. *Implement basic SSH settings to increase the security of the client-server connection*

- SSH port on the 192.168.0.106 server has been changed from the ***22*** to ***27517***
- ***PasswordAuthentication*** has been disabled
- ***PermitRootLogin*** has been disabled
After these reconfiguration have been implemented MobaXterm session settings may been seen [in the screenshot](screenshots/005.JPG)


3. *List the options for choosing keys for encryption in SSH. Implement 3 of them.*



4. *Implement port forwarding for the SSH client from the host machine to the guest Linux virtual machine behind NAT.*

On the host machine [192.168.0.109](screenshots/006.JPG) there was run second test VPS with the NAT network adapter that was [configured with port forwarding](screenshots/007.JPG) and the 27517 port of the host machine is being forwarded to default 22 SSH port on the guest machine. As you may see in the [screenshot](screenshots/008.JPG) VPS is accessible via SSH smooothly.


5*. Intercept (capture) traffic (tcpdump, wireshark) while authorizing the remote client on the server using ssh, telnet, rlogin. Analyze the result.


