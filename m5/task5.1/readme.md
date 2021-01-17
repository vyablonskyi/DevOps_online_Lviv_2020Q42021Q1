**Part1**


*1) Log in to the system as root.*

There was built new virtual machine with Ubuntu 18.04LTS on board, set up root password and log into the sustem as root [see results](screenshots/001.JPG)


*2) Use the passwd command to change the password. Examine the basic parameters of the command. What system file does it change?*

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


*3) Determine the users registered in the system, as well as what commands they execute. What additional information can be gleaned from the command execution?*

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


*4) Change personal information about yourself.*

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

*5) Become familiar with the Linux help system and the man and info commands. Get help on the previously discussed commands, define and describe any two keys for these commands. Give examples.*

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


*6) Explore the more and less commands using the help system. View the contents of files .bash* using commands.*

***more*** command outputs all files which were chosen by the .bash* mask in one thread page by page
***less*** command outputs files one by one and we can navigate in each file and shoose next file by the ***:n*** command or previous file by the ***:p*** command


*7) * Describe in plans that you are working on laboratory work 1. Tip: You should read the documentation for the finger command.*

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


*8) * List the contents of the home directory using the ls command, define its files and directories. Hint: Use the help system to familiarize yourself with the ls command.*

Incase of this task I can only provide output of appropriate commands:
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


1) Examine the tree command. Master the technique of applying a template, for example, display all files that contain a character c, or files that contain a specific sequence of characters. List subdirectories of the root directory up to and including the second nesting level.

- marked all files in tree output of the /var directory that contain the 'abl' substring:
```
tree -a -P *abl* /var
```
- list subdirectories of the root directory up to and including the second nesting level:
```
tree -d -L 2 /
```


2) What command can be used to determine the type of file (for example, text or binary)? Give an example.

There is the ***file*** command that provides with necessary information:
```
root@test1:~# file /etc/ssh/sshd_config
/etc/ssh/sshd_config: ASCII text
root@test1:~# file /sbin/route
/sbin/route: ELF 64-bit LSB shared object, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, for GNU/Linux 2.6.32, BuildID[sha1]=13406da9c2f118b683445a871320f63cc4097d21, stripped
```


3) Master the skills of navigating the file system using relative and absolute paths. How can you go back to your home directory from anywhere in the filesystem?

You just need to run ***cd ~*** command to go back to current user home dir or type ***cd ~username*** to go to "username" home:
```
root@test1:~# cd ~tester
root@test1:/home/tester# pwd
/home/tester
root@test1:/home/tester# cd ~
root@test1:~# pwd
/root
```


4) Become familiar with the various options for the ls command. Give examples of listing directories using different keys. Explain the information displayed on the terminal using the -l and -a switches.

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
5) Perform the following sequence of operations: - create a subdirectory in the home directory; - in this subdirectory create a file containing information about directories located in the root directory (using I/O redirection operations);
- view the created file;
- copy the created file to your home directory using relative and absolute addressing.
- delete the previously created subdirectory with the file requesting removal;
- delete the file copied to the home directory.


6) Perform the following sequence of operations:
- create a subdirectory test in the home directory;
- copy the .bash_history file to this directory while changing its name to labwork2;
- create a hard and soft link to the labwork2 file in the test subdirectory;
- how to define soft and hard link, what do these
concepts;
- change the data by opening a symbolic link. What changes will happen and why
- rename the hard link file to hard_lnk_labwork2;
- rename the soft link file to symb_lnk_labwork2 file;
- then delete the labwork2. What changes have occurred and why?


7) Using the locate utility, find all files that contain the squid and traceroute sequence.


8) Determine which partitions are mounted in the system, as well as the types of these partitions.


9) Count the number of lines containing a given sequence of characters in a given file.


10) Using the find command, find all files in the /etc directory containing the host character sequence.


11) List all objects in /etc that contain the ss character sequence. How can I duplicate a similar command using a bunch of grep?


12) Organize a screen-by-screen print of the contents of the /etc directory. Hint: You must use stream redirection operations.


13) What are the types of devices and how to determine the type of device? Give examples.


14) How to determine the type of file in the system, what types of files are there?


15) * List the first 5 directory files that were recently accessed in the /etc directory.
