**Part1**


1) Log in to the system as root.

There was built new virtual machine with Ubuntu 18.04LTS on board, set up root password and log into the sustem as root [see results](screenshots/001.JPG)


2) Use the passwd command to change the password. Examine the basic parameters of the command. What system file does it change *?

Passwords of "root" and "tester" users were changed by running the ***passwd*** commnads:
- clear password of the "tester" user
```
root@test1:~# passwd -d tester
passwd: password expiry information changed.
```
- set password of the "tester" user
```
root@test1:~# passwd tester
Enter new UNIX password:
Retype new UNIX password:
passwd: password updated successfully
root@test1:~#
```
- changed lifetime of the root's password to 90 days and showed status of root password
```
root@test1:~# passwd -x90 root
passwd: password expiry information changed.
root@test1:~# passwd -S
root P 01/17/2021 0 90 7 -1
root@test1:~#
```

The "passwd" command changes the following syspem files:
/etc/passwd
/etc/shadow
/etc/pam.d/passwd

It may be used with the bunch of options, but at my mind most useful are:
***-d*** - make password empty
***-x*** - set amount of days, after that password should be changed


3) Determine the users registered in the system, as well as what commands they execute. What additional information can be gleaned from the command execution?
4) Change personal information about yourself.
5) Become familiar with the Linux help system and the man and info commands. Get help on the previously discussed commands, define and describe any two keys for these commands. Give examples.
6) Explore the more and less commands using the help system. View the contents of files .bash* using commands.
7) * Describe in plans that you are working on laboratory work 1. Tip: You should read the documentation for the finger command.
8) * List the contents of the home directory using the ls command, define its files and directories. Hint: Use the help system to familiarize yourself with the ls command.
