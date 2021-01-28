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
 - + - is in the foreground process group

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




9. *What utilities can be used to analyze existing running tasks (by analyzing the help for the ps command)?*



10. What information does top command display?



11. Display the processes of the specific user using the top command.



12. What interactive commands can be used to control the top command? Give a couple of examples.



13. Sort the contents of the processes window using various parameters (for example, the amount of processor time taken up, etc.)



14. Concept of priority, what commands are used to set priority?



15. Can I change the priority of a process using the top command? If so, how?


16. Examine the kill command. How to send with the kill command process control signal? Give an example of commonly used signals.



17. Commands jobs, fg, bg, nohup. What are they for? Use the sleep, yes command to demonstrate the process control mechanism with fg, bg.




**Part2**


1. Check the implementability of the most frequently used OPENSSH commands in the MS Windows operating system. (Description of the expected result of the commands + screenshots: command – result should be presented)



2. Implement basic SSH settings to increase the security of the client-server connection (at least 



3. List the options for choosing keys for encryption in SSH. Implement 3 of them.



4. Implement port forwarding for the SSH client from the host machine to the guest Linux virtual machine behind NAT.



5*. Intercept (capture) traffic (tcpdump, wireshark) while authorizing the remote client on the server using ssh, telnet, rlogin. Analyze the result.
