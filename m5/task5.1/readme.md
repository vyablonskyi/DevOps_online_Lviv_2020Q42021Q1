**Part1**


1) *Log in to the system as root.*

There was built new virtual machine with Ubuntu 18.04LTS on board, set up root password and log into the sustem as root [see results](screenshots/001.JPG)


2) *Use the passwd command to change the password. Examine the basic parameters of the command. What system file does it change?*

Passwords of "root" and "tester" users were changed by running the ***passwd*** commnads:
- cleared password of the "tester" user and set new password
```
root@test1:~# passwd -d tester
passwd: password expiry information changed.
root@test1:~# passwd tester
Enter new UNIX password:
Retype new UNIX password:
passwd: password updated successfully
root@test1:~#
```
- set lifetime of the root password to 90 days and showed status of root password
```
root@test1:~# passwd -x90 root
passwd: password expiry information changed.
root@test1:~# passwd -S
root P 01/17/2021 0 90 7 -1
root@test1:~#
```
The "passwd" command changes the following syspem files:
- /etc/passwd
- /etc/shadow
- /etc/pam.d/passwd


3) *Determine the users registered in the system, as well as what commands they execute. What additional information can be gleaned from the command execution?*

By running the ***w*** command there was determined who wass logged into the system and what commands they run:
```
root@test1:~# w
 19:12:07 up 55 min,  2 users,  load average: 0.08, 0.02, 0.01
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT
tester   tty1     -                19:12    6.00s  0.08s  0.06s -bash
root     pts/0    192.168.0.104    18:58    1.00s  0.09s  0.00s w
root@test1:~#
```
Similar information was provided by the ***who*** command:
```
root@test1:~# who
tester   tty1         2021-01-17 19:12
root     pts/0        2021-01-17 18:58 (192.168.0.104)
root@test1:~#
```
These commands show also type of connections, start time of sessions, remote hosts, CPU usage


4) *Change personal information about yourself.*

Personal information about the "tester" user was changed by editing the 5th parameter in appropriate string in /etc/passwd file:
```
root@test1:~# cat /etc/passwd | grep tester
tester:x:1000:1000:tester:/home/tester:/bin/bash
root@test1:~# vipw
You have modified /etc/passwd.
You may need to modify /etc/shadow for consistency.
Please use the command 'vipw -s' to do so.
root@test1:~# cat /etc/passwd | grep tester
tester:x:1000:1000:Junior Tester:/home/tester:/bin/bash
root@test1:~#
```
The same changes may have been implemented by running the ***usermod*** command:
```
usermod -c 'Junior Tester' tester
```

5) *Become familiar with the Linux help system and the man and info commands. Get help on the previously discussed commands, define and describe any two keys for these commands. Give examples.*

As an example of using ***man*** and ***info** command I can describe ***-s*** key of the ***w*** command:

-s, --short    Use the short format.  Don't print the login time, JCPU or PCPU times.
```
root@test1:~# w -s
 20:10:52 up  1:54,  2 users,  load average: 0.00, 0.00, 0.00
USER     TTY      FROM              IDLE WHAT
tester   tty1     -                58:51  -bash
root     pts/0    192.168.0.104     4.00s w -s
```
and ***-b*** key of the ***who*** command:

-b, --boot  time of last system boot
```
root@test1:~# who -b
         system boot  2021-01-17 18:16
```


6) *Explore the more and less commands using the help system. View the contents of files .bash* using commands.*

***more*** command outputs all files which were chosen by the .bash* mask in one thread page by page
***less*** command outputs files one by one and we can navigate in each file and shoose next file by the ***:n*** command or previous file by the ***:p*** command


7) *Describe in plans that you are working on laboratory work 1. Tip: You should read the documentation for the finger command.*

There was cretaed the /home/tester/.plan file with the "working on the Lab1 in laboratory" string inside and after that the ***finger tester*** command showed the following:
```
root@test1:~# finger tester
Login: tester                           Name: Junior Tester
Directory: /home/tester                 Shell: /bin/bash
On since Sun Jan 17 19:12 (UTC) on tty1   2 hours 8 minutes idle
     (messages off)
No mail.
Plan:
working on the Lab1 in laboratory

```


8) *List the contents of the home directory using the ls command, define its files and directories. Hint: Use the help system to familiarize yourself with the ls command.*

In case of this task I can only provide output of appropriate commands:
```
root@test1:~# ls -la ~tester
total 40
drwxr-xr-x 4 tester tester 4096 Jan 17 21:20 .
drwxr-xr-x 3 root   root   4096 Jan 17 18:17 ..
-rw------- 1 tester tester   38 Jan 17 21:20 .bash_history
-rw-r--r-- 1 tester tester  220 Apr  4  2018 .bash_logout
-rw-r--r-- 1 tester tester 3771 Apr  4  2018 .bashrc
drwx------ 2 tester tester 4096 Jan 17 18:18 .cache
drwx------ 3 tester tester 4096 Jan 17 18:18 .gnupg
-rw-rw-r-- 1 tester tester   34 Jan 17 21:20 .plan
-rw-r--r-- 1 tester tester  807 Apr  4  2018 .profile
-rw-r--r-- 1 tester tester    0 Jan 17 18:20 .sudo_as_admin_successful
-rw------- 1 tester tester 1027 Jan 17 21:20 .viminfo
root@test1:~# ls -f ~tester
.cache  .bashrc  ..  .bash_logout  .profile  .gnupg  .  .viminfo  .bash_history  .plan  .sudo_as_admin_successful
root@test1:~# ls -d ~tester
/home/tester
````

**Part2**


1) *Examine the tree command. Master the technique of applying a template, for example, display all files that contain a character c, or files that contain a specific sequence of characters. List subdirectories of the root directory up to and including the second nesting level.*

- marked all files in tree output of the /var directory that contain the 'abl' substring:
```
tree -a -P *abl* /var
```
- list subdirectories of the root directory up to and including the second nesting level:
```
tree -d -L 2 /
```


2) *What command can be used to determine the type of file (for example, text or binary)? Give an example.*

There is the ***file*** command that provides with necessary information:
```
root@test1:~# file /etc/ssh/sshd_config
/etc/ssh/sshd_config: ASCII text
root@test1:~# file /sbin/route
/sbin/route: ELF 64-bit LSB shared object, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, for GNU/Linux 2.6.32, BuildID[sha1]=13406da9c2f118b683445a871320f63cc4097d21, stripped
```


3) *Master the skills of navigating the file system using relative and absolute paths. How can you go back to your home directory from anywhere in the filesystem?*

You just need to run ***cd ~*** command to go back to current user home dir or type ***cd ~username*** to go to "username" home:
```
root@test1:~# cd ~tester
root@test1:/home/tester# pwd
/home/tester
root@test1:/home/tester# cd ~
root@test1:~# pwd
/root
```


4) *Become familiar with the various options for the ls command. Give examples of listing directories using different keys. Explain the information displayed on the terminal using the -l and -a switches.*

```
ls -a
```
shows 'hidden' files/folders starting with '.'
```
ls -l
```
shows information in long (detailed) format

```
ls -d
```
shows only directories
```
ls -i 
```
shows inode (index) of each file 


5) *Perform the following sequence of operations:
- *create a subdirectory in the home directory;
```
tester@test1:~$ mkdir newdir
tester@test1:~$ cd newdir
```
- *in this subdirectory create a file containing information about directories located in the root directory (using I/O redirection operations);
```
tester@test1:~/newdir$ ls -la / > root_dir.lst
```
- *view the created file;
```
tester@test1:~/newdir$ more root_dir.lst
total 2017384
drwxr-xr-x  24 root root       4096 Jan 17 18:03 .
drwxr-xr-x  24 root root       4096 Jan 17 18:03 ..
drwxr-xr-x   2 root root       4096 Jan 17 18:12 bin
drwxr-xr-x   3 root root       4096 Jan 17 18:07 boot
drwxr-xr-x   2 root root       4096 Jan 17 18:01 cdrom
drwxr-xr-x  18 root root       3880 Jan 17 18:16 dev
drwxr-xr-x  91 root root       4096 Jan 17 21:44 etc
drwxr-xr-x   3 root root       4096 Jan 17 18:17 home
lrwxrwxrwx   1 root root         34 Jan 17 18:02 initrd.img -> boot/initrd.img-4.15.0-132-generic
lrwxrwxrwx   1 root root         34 Jan 17 18:02 initrd.img.old -> boot/initrd.img-4.15.0-132-generic
drwxr-xr-x  22 root root       4096 Jan 17 18:01 lib
drwxr-xr-x   2 root root       4096 Aug  6 22:37 lib64
drwx------   2 root root      16384 Jan 17 17:59 lost+found
drwxr-xr-x   2 root root       4096 Aug  6 22:35 media
drwxr-xr-x   2 root root       4096 Aug  6 22:35 mnt
drwxr-xr-x   2 root root       4096 Aug  6 22:35 opt
dr-xr-xr-x 103 root root          0 Jan 17 18:16 proc
drwx------   5 root root       4096 Jan 17 22:38 root
drwxr-xr-x  25 root root        840 Jan 17 21:27 run
drwxr-xr-x   2 root root      12288 Jan 17 18:12 sbin
drwxr-xr-x   2 root root       4096 Jan 17 18:17 snap
drwxr-xr-x   2 root root       4096 Aug  6 22:35 srv
-rw-------   1 root root 2065694720 Jan 17 18:03 swap.img
dr-xr-xr-x  13 root root          0 Jan 17 22:36 sys
drwxrwxrwt   9 root root       4096 Jan 17 22:39 tmp
drwxr-xr-x  10 root root       4096 Aug  6 22:35 usr
drwxr-xr-x  13 root root       4096 Aug  6 22:40 var
lrwxrwxrwx   1 root root         31 Jan 17 18:02 vmlinuz -> boot/vmlinuz-4.15.0-132-generic
lrwxrwxrwx   1 root root         31 Jan 17 18:02 vmlinuz.old -> boot/vmlinuz-4.15.0-132-generic
```
- *copy the created file to your home directory using relative and absolute addressing.
```
tester@test1:~/newdir$ cp root_dir.lst ../
tester@test1:~/newdir$ cp root_dir.lst ~/
tester@test1:~/newdir$ cp root_dir.lst /home/tester/
tester@test1:~/newdir$ tree ~
/home/tester
├── newdir
│   └── root_dir.lst
└── root_dir.lst

1 directory, 2 files
tester@test1:~/newdir$ cd ~
```
- *delete the previously created subdirectory with the file requesting removal;
```
tester@test1:~$ rm -ir newdir
rm: remove directory 'newdir'? yes
```
- *delete the file copied to the home directory.
```
tester@test1:~$ rm root_dir.lst
tester@test1:~$ tree ~
/home/tester

0 directories, 0 files
tester@test1:~$
```


6) *Perform the following sequence of operations:
- *create a subdirectory test in the home directory;
```
tester@test1:~$ mkdir test
```
- *copy the .bash_history file to this directory while changing its name to labwork2;
```
tester@test1:~$ cp .bash_history test/labwork2
```
- *create a hard and soft link to the labwork2 file in the test subdirectory;
```
tester@test1:~$ ln test/labwork2 test/hard_labwork2
tester@test1:~$ ln -s labwork2 test/sym_labwork2
```
- *how to define soft and hard link, what do these concepts;
Difference between hard and soft link is clearly shown below in the ***ls -ali*** command output.
Hard link points at the same index in filesystem 525213 that original file and both of them don't depends each other and work directly with data on drive
Symbolic link is only pointer to original file which depends on any actions that are made with this original file
```
tester@test1:~$ ls -lai test
total 16
521876 drwxrwxr-x 2 tester tester 4096 Jan 17 23:05 .
519176 drwxr-xr-x 5 tester tester 4096 Jan 17 23:00 ..
525213 -rw------- 2 tester tester   38 Jan 17 23:00 hard_labwork2
525213 -rw------- 2 tester tester   38 Jan 17 23:00 labwork2
525215 lrwxrwxrwx 1 tester tester   13 Jan 17 23:00 sym_labwork2 -> labwork2
```
- *change the data by opening a symbolic link. What changes will happen and why
In this case both original file and hardlink are changed because file on disk was changed through symlink and original file
```
tester@test1:~$ echo 'everything will be changed' >> test/sym_labwork2
tester@test1:~$ ls -lai test
total 16
521876 drwxrwxr-x 2 tester tester 4096 Jan 17 23:20 .
519176 drwxr-xr-x 5 tester tester 4096 Jan 17 23:20 ..
525213 -rw------- 2 tester tester   65 Jan 17 23:21 hard_labwork2
525213 -rw------- 2 tester tester   65 Jan 17 23:21 labwork2
525212 lrwxrwxrwx 1 tester tester    8 Jan 17 23:00 sym_labwork2 -> labwork2
```
- *rename the hard link file to hard_lnk_labwork2;
```
tester@test1:~$ mv test/hard_labwork2 test/hard_lnk_labwork2
```
- *rename the soft link file to symb_lnk_labwork2 file;
```
tester@test1:~$ mv test/sym_labwork2 test/symb_lnk_labwork2
```
- *then delete the labwork2. What changes have occurred and why?
```
tester@test1:~$ rm -rf test/labwork2
```
Was got the following results:
```
tester@test1:~$ ls -lai test
total 12
521876 drwxrwxr-x 2 tester tester 4096 Jan 17 23:31 .
519176 drwxr-xr-x 5 tester tester 4096 Jan 17 23:20 ..
525213 -rw------- 1 tester tester   65 Jan 17 23:21 hard_lnk_labwork2
525212 lrwxrwxrwx 1 tester tester    8 Jan 17 23:19 symb_lnk_labwork2 -> labwork2
```
Hardlink is still accessible because index is still alive and data on disk exists
Symlink is marked as not working and data can't be accessible via this link because original file doesn't exist and symlink points to data through this file.


7) *Using the locate utility, find all files that contain the squid and traceroute sequence.
```
root@test1:~# updatedb
root@test1:~# locate squid traceroute
/etc/alternatives/traceroute6
/etc/alternatives/traceroute6.8.gz
/lib/modules/4.15.0-132-generic/kernel/drivers/tty/n_tracerouter.ko
/usr/bin/traceroute6
/usr/bin/traceroute6.iputils
/usr/share/lxc/hooks/squid-deb-proxy-client
/usr/share/man/man8/traceroute6.8.gz
/usr/share/man/man8/traceroute6.iputils.8.gz
/usr/share/sosreport/sos/plugins/squid.py
/usr/share/sosreport/sos/plugins/__pycache__/squid.cpython-36.pyc
/usr/share/vim/vim80/syntax/squid.vim
/var/lib/dpkg/alternatives/traceroute6
```

8) *Determine which partitions are mounted in the system, as well as the types of these partitions.

As you may see in the output of commnads below there are two partitions on disk one is being used by GRUB and second, formatted in ext4 is mouned as root on the virtual machine.
```
root@test1:~# fdisk -l
Disk /dev/sda: 10.1 GiB, 10887241728 bytes, 21264144 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: BB712612-A595-49DC-93A8-0D6DEA923357

Device     Start      End  Sectors  Size Type
/dev/sda1   2048     4095     2048    1M BIOS boot
/dev/sda2   4096 21260287 21256192 10.1G Linux filesystem
root@test1:~# df -Th
Filesystem     Type      Size  Used Avail Use% Mounted on
udev           devtmpfs  462M     0  462M   0% /dev
tmpfs          tmpfs      99M  724K   98M   1% /run
/dev/sda2      ext4       10G  3.8G  5.7G  40% /
tmpfs          tmpfs     493M     0  493M   0% /dev/shm
tmpfs          tmpfs     5.0M     0  5.0M   0% /run/lock
tmpfs          tmpfs     493M     0  493M   0% /sys/fs/cgroup
tmpfs          tmpfs      99M     0   99M   0% /run/user/1000
tmpfs          tmpfs      99M     0   99M   0% /run/user/0
```


9) Count the number of lines containing a given sequence of characters in a given file.

Command below counts lines in the /var/log/dpkg.log file which contain the 'unpacked' substring
```
root@test1:~# grep unpacked /var/log/dpkg.log | wc -l
3122
```


10) Using the find command, find all files in the /etc directory containing the host character sequence.

```
find /etc -type f -exec grep -l 'host' {} +;
```

11) List all objects in /etc that contain the ss character sequence. How can I duplicate a similar command using a bunch of grep?

```
find /etc -exec grep -l 'ss' {} +;
```


12) Organize a screen-by-screen print of the contents of the /etc directory. Hint: You must use stream redirection operations.

In the ssh session there was run the following command:
```
root@test1:~# ls -la /etc > /dev/tty1
```
In the tty1 console appeared the [output](screensots/002.JPG)

13) What are the types of devices and how to determine the type of device? Give examples.


14) How to determine the type of file in the system, what types of files are there?


15) * List the first 5 directory files that were recently accessed in the /etc directory.
