***Task 5.2.***


1) *Analyze the structure of the /etc/passwd and /etc/group file, what fields are present in it, what users exist on the system? Specify several pseudo-users, how to define them?*

The **/etc/passwd** file contains information about the users registered in system.
Each string in this file consists of 7 fields separated by the ":" symbol 

Below is example of the string and description of each parameter.
```
tester:x:1000:1000:first Tester, laborathory 543:/home/tester:/bin/bash
```
field number | example | description
--- | --- | ----
1 | tester | username (logname)
2 | x |  information used to validate a user's password
3 | 1000 | user identifier number
4 | 1000 | group identifier number
5 | first Tester, laborathory 543 |Gecos field, commentary that describes the person or account
6 | /home/tester | Path to the user's home directory.
7 | /bin/bash | program that is started every time the user logs into the system

The **/etc/group** file contains information about the groups registered in system.
Each string in this file consists of 4 fields separated by the ":" symbol 

Below is example of the string and description of each parameter.
```
sudo:x:27:tester,second
```
field number | example | description
--- | --- | ----
1 | sudo | groupname
2 | x |  group password
3 | 27 | group identifier number
4 | tester,second | list of users in group

All users on the system can be devided on three groups: superuser - root, pseudo-users, real users
- superuser "root" has all possible permissions on the system
- pseudo-users: special users that are ownerships of processes. The **sshd**, **mail**, **proxy** are pseudo-users. 
- real users: regular users


2) *What are the uid ranges? What is UID? How to define it?*

UID is the number that uniquelly identifies user in the system
There are three UID ranges:
- 0: UID for root
- 1-999: UIDs for pseudo users
- 1000-2^32(in most current OS): UIDs for regular users

UID may be defined by editing the **/etc/passwd** file or by runnind  **useradd** or **adduser** or **usermod** commands.


3) *What is GID? How to define it?*

GID is the nubber that uniquelly identifies group in the system
GID may be defined by editing the **/etc/group** file or by runnind the **groupadd** command or by creating new user via running **useradd** or **adduser** commands or by editing group via running the **groupmod** command.

4) *How to determine belonging of user to the specific group?*

GIDs of all groups that user belongs to may be determine by running the **id** command:
```
root@test1:~# id tester
uid=1000(tester) gid=1000(tester) groups=1000(tester),4(adm),24(cdrom),27(sudo),30(dip),46(plugdev),108(lxd)
```
also it is possible to check record of the appropriate group in the **/etc/group** file


5) *What are the commands for adding a user to the system? What are the basic parameters required to create a user?*

New user can be add to the system by running **useradd** or **adduser** command or by editing the /etc/passwd file in case of adduser home dir for the new user will be created automatically.

Bellow there is example of creating new user **second** and adding it to existed the **testers** group
```
root@test1:~# adduser --gid 1000  second
Adding user `second' ...
Adding new user `second' (1001) with group `testers' ...
Creating home directory `/home/second' ...
Copying files from `/etc/skel' ...
Enter new UNIX password:
Retype new UNIX password:
passwd: password updated successfully
Changing the user information for second
Enter the new value, or press ENTER for the default
        Full Name []: Second Tester
        Room Number []: 345
        Work Phone []:
        Home Phone []:
        Other []:
Is the information correct? [Y/n] Y
root@test1:~# id second
uid=1001(second) gid=1000(testers) groups=1000(testers)
root@test1:~#

```


6) *How do I change the name (account name) of an existing user?*

As in the example below, login can be changed by the **usermod** commad with the **-l** key

```
root@test1:~# id matrix
uid=1002(matrix) gid=1000(testers) groups=1000(testers)
root@test1:~# usermod -l third matrix
root@test1:~# id third
uid=1002(third) gid=1000(testers) groups=1000(testers)
root@test1:~#
```


7) *What is skell_dir? What is its structure?*

The **/etc/skel** directory contains files and directories that are automatically copied over to a new user's hone when it is created.
In case of Ubuntu 18 there is the following structure of this folder:
```
root@test1:~# ls -la /etc/skel
total 20
drwxr-xr-x  2 root root 4096 Aug  6 22:37 .
drwxr-xr-x 91 root root 4096 Jan 21 21:48 ..
-rw-r--r--  1 root root  220 Apr  4  2018 .bash_logout
-rw-r--r--  1 root root 3771 Apr  4  2018 .bashrc
-rw-r--r--  1 root root  807 Apr  4  2018 .profile
```


8) *How to remove a user from the system (including his mailbox)?*

User and his mailbox can be removed from the system by running **userdel** command with the **-r** key:
```
root@test1:~# userdel -r third
userdel: third mail spool (/var/mail/third) not found
```


9) *What commands and keys should be used to lock and unlock a user account?*

Users account can be locked by running the **usermod -L** or **passwd -l** command.
Account can be unlocked by the **usermod -U** or **passwd -u** command.


10)*How to remove a user's password and provide him with a password-free login for subsequent password change?*

This can be dome by running the **passwd -d -e** command:
```
root@test1:~# passwd -d -e second
passwd: password expiry information changed.
root@test1:~#
```
resuls may be seen [here](screenshots/001.JPG)


11) *Display the extended format of information about the directory, tell about the information columns displayed on the terminal.*

Bellow is presented example of output of the **ls -al** command there is shown the /home/second folder:
```
drwxr-xr-x  4 second testers 4096 Jan 22 21:22 second
```
This output contain a few fields that described below

field number | example | description
--- | --- | ----
1 | d | The  character that identifies the file type (d means directory)
2 | rxx | owner permissions
3 | r-x | group permissions
4 | r-x | other users permissions
5 | 4 | hard link counts
6 | second | owner name
7 | testers | group name
8 | 4096 | size of space on the disk that is used to store the meta-information for the directory
9 | Jan 22 21:22 | Date and time when the folder was modify last time
10 | second | folder name


12) *What access rights exist and for whom (i. e., describe the main roles)? Briefly describe the acronym for access rights.*

Access rights contain three sections that describe owner of file/folder, group that owns file/folder and all other users. For each section rights represented by three symbols: **rwx** with the following meaning:
- r - read permissions
- w - write permissions
- x - execute permissions


13) *What is the sequence of defining the relationship between the file and the user?*

Firstly there should be defined if the user is the owner of file, if yes, on the file may be performed all actions that are allowed by the owner rights.
If user isn't owner there should be checked if the user is added to the group that set as groupfor this file if yes actions that aloowed for the  group may be performed.
Otherwise there can be performed actions that are allowed for other users.

14) *What commands are used to change the owner of a file (directory), as well as the mode of access to the file? Give examples, demonstrate on the terminal.*

Owner of the file can be changed bu the **chown** command:
```
root@test1:/tmp# ls -la testfile
-rw-r--r-- 1 second testers 41 Jan 22 22:44 testfile
root@test1:/tmp# chown tester testfile
root@test1:/tmp# ls -la testfile
-rw-r--r-- 1 tester testers 41 Jan 22 22:44 testfile
root@test1:/tmp#
```
access mode can be modify by the **chmod** command:
```
root@test1:/tmp# chmod 755 testfile
root@test1:/tmp# ls -la testfile
-rwxr-xr-x 1 tester testers 41 Jan 22 22:44 testfile
```


15) *What is an example of octal representation of access rights? Describe the umask command.*

Rights can be represented in octal form which is based on the binary system and can be described by the following table:
rwx form | octal form
--- | ---
rwx | 7
rw- | 6
r-x | 5
r-- | 4
-wx | 3
-w- | 2
--x | 1
--- | 0

All new files are created with a default set of permissions. The **umask** command shows or set the file mode creation mask.
```
# umask
0022
```


16) *Give definitions of sticky bits and mechanism of identifier substitution. Give an example of files and directories with these attributes.*

By using the **chmod** command can be set 4-bytes-long paramether for each file the last 3 bytes set permisions for owner, group and other users ans the firt byte can be **0** or a combination of 4 for **SUID**, 2 for **SGID** and 1 for **Sticky Bit**. 
- SUID bit can be set on an executable file, it means that the file will be executed with the same permissions as the owner of the executable file
```
root@test1:~# ls -la /usr/bin/passwd
-rwsr-xr-x 1 root root 59640 Mar 22  2019 /usr/bin/passwd
```
- SGID allows any user to execute files with the same permissions as the owne group. In case the SGID applied to some directory all subfolders and files that will be created inside will get the same group ownership as main directory
```
root@test1:~# ls -la /usr/bin/crontab
-rwxr-sr-x 1 root crontab 39352 Nov 16  2017 /usr/bin/crontab
```
- Sticky Bit is used for folders to get them and their content avoid being deleted. Folder and all inside can be deleted only by owner or root.
```
root@test1:~# ls -al /var
...
drwxrwxrwt  2 root root   4096 Jan 22 09:01 crash
...
drwxrwxrwt  4 root root   4096 Jan 22 16:56 tmp
```


17) *What file attributes should be present in the command script?*

Command script should have **f** attribute that shows that file exists and is a regular file also the should have readable **r** and executable **x** attributes at least for the one permissions group.

