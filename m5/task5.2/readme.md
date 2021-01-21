***Task 5.2.***


1) *Analyze the structure of the /etc/passwd and /etc/group file, what fields are present in it, what users exist on the system? Specify several pseudo-users, how to define them?

The **/etc/passwd** file contains information about the users registered in system.
Each string in this file consists of 7 fields separated by the **:** symbol 

Below is example of the string and description of each parameter.
```
tester:x:1000:1000:first Tester, laborathory 543:/home/tester:/bin/bash
```
field number | example | description
--- | --- | ----
1 | tester | username (logname)
2 | x |  information used to validate a user's password; it may be "x" or "\*" or "\*NP*" or a cryptographic hash of the password
3 | 1000 | user identifier number
4 | 1000 | group identifier number
5 | first Tester, laborathory 543 |Gecos field, commentary that describes the person or account
6 | /home/tester | Path to the user's home directory.
7 | /bin/bash | program that is started every time the user logs into the system

The **/etc/group** file contains information about the groups registered in system.
Each string in this file consists of 4 fields separated by the **:** symbol 

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
- superuser "root" has all possible permissions on the system UID of yhis user should be 0
- pseudo-users: special users that are ownerships of processes, theit UIDS are in 1-999 range, **sshd**, **mail**, **proxy**, are pseudo-users 
- real users: regular users, their UIDs start from 1000


2) *What are the uid ranges? What is UID? How to define it?

UID is the number that uniquelly identifies user in the system
There are three UID ranges:
- 0: UID for root
- 1-999: UIDs for pseudo users
- 1000-2^32(in most current OS): UIDs for regular users

The easiest way to define UID of some user is using the **id** command:
```
# id proxy
uid=13(proxy) gid=13(proxy) groups=13(proxy)
```


3) *What is GID? How to define it?


4) *How to determine belonging of user to the specific group?


5) *What are the commands for adding a user to the system? What are the basic parameters required to create a user?


6) *How do I change the name (account name) of an existing user?


7) *What is skell_dir? What is its structure?


8) *How to remove a user from the system (including his mailbox)?


9) *What commands and keys should be used to lock and unlock a user account?


10)*How to remove a user's password and provide him with a password-free login for subsequent password change?


11) *Display the extended format of information about the directory, tell about the information columns displayed on the terminal.


12) *What access rights exist and for whom (i. e., describe the main roles)? Briefly describe the acronym for access rights.


13) *What is the sequence of defining the relationship between the file and the user?


14) *What commands are used to change the owner of a file (directory), as well as the mode of access to the file? Give examples, demonstrate on the terminal.


15) *What is an example of octal representation of access rights? Describe the umask command.


16) *Give definitions of sticky bits and mechanism of identifier substitution. Give an example of files and directories with these attributes.


17) *What file attributes should be present in the command script?
