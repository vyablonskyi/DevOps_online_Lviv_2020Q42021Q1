**Linux administration with bash. Home task**


[Script1](script1.sh) displays the IP addresses and symbolic names of all hosts in the specific subnet or displays a list of open system TCP ports of specific host
```
#!/bin/bash

function nmapcheck(){
  nmap -v > /dev/null 2>&1
  if [[ "$?" -gt 0 ]];
    then
      if [ -e /etc/debian_version ]
        then
          sudo apt-get -y install nmap> /dev/null 2>&1
        elif [ -e /etc/redhat-release ]
          then
            yum -y install nmap > /dev/null 2>&1
      fi
  fi
}

function wrong(){
  printf "\nPlease run the script with one of the following parameters:\n"
  printf "\n--all <subnet>    - displays the IP addresses and symbolic names of all hosts in the specific subnet where subnet should be in the IP_address/mask format"
  printf "\n--target <host>   - displays a list of open system TCP ports of specific host where <host> may be IP address or FQDN \n"
}

function showhosts(){
  printf "\nList of all accessible machines in the $1 subnet\n"
  nmap -sP $1 | grep report | awk '{print $6,$5}'
}

function showports(){
  printf "\nList of open TCP ports on the $1 machine:\n"
  nmap -sT $1 | grep open | awk -F / '{print $1}'
}

if  [ "$#" == "0" ]
  then
    wrong
  else
    nmapcheck
    case $1 in
       --all) showhosts $2
       ;;
       --target) showports $2
       ;;
       *) wrong
       ;;
     esac
fi
```

B. Using Apache log example create a script to answer the following questions:
1. From which ip were the most requests?
2. What is the most requested page?
3. How many requests were there from each ip?
4. What non-existent pages were clients referred to?
5. What time did site get the most requests?
6. What search bots have accessed the site? (UA + IP)


C. Create a data backup script that takes the following data as parameters:
1. Path to the syncing directory.
2. The path to the directory where the copies of the files will be stored.
In case of adding new or deleting old files, the script must add a corresponding entry to the log file indicating the time, type of operation and file name. [The command to run the script must be added to crontab with a run frequency of one minute]
