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

By running the ***w*** command there was determined who is logged into the system and what commands they run:
```
root@test1:~# w
 19:12:07 up 55 min,  2 users,  load average: 0.08, 0.02, 0.01
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT
tester   tty1     -                19:12    6.00s  0.08s  0.06s -bash
root     pts/0    192.168.0.104    18:58    1.00s  0.09s  0.00s w
root@test1:~#
```
Similar information may be get by the ***who*** command:
```
root@test1:~# who
tester   tty1         2021-01-17 19:12
root     pts/0        2021-01-17 18:58 (192.168.0.104)
root@test1:~#
```
These command show also type of connections, start time of sessions, remote hosts, CPU usage


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

There was cretaed the /home/tester/.plan file with the "working on the Lab1 in laboratory" string inside and after that the ***finger tester*** command showed the following^
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
