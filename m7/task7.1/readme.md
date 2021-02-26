**Linux administration with bash. Home task**


[Script1](script1.sh) displays the IP addresses and symbolic names of all hosts in the specific subnet or displays a list of open system TCP ports of specific host
```
#!/bin/bash

function nmapcheck(){
  nmap -v > /dev/null 2>&1
  if [[ "$?" -gt 0 ]]
  then
    if [ -e /etc/debian_version ]
    then
      sudo apt-get update -y > /dev/null 2>&1
      sudo apt-get install nmap -y > /dev/null 2>&1
      if [[ "$?" -gt 0 ]]
      then
        printf "\ntPlease install nmap on this machine\n"
        exit 1
      fi
    elif [ -e /etc/redhat-release ]
    then
      sudo yum -y install nmap > /dev/null 2>&1
       if [[ "$?" -gt 0 ]]
       then
         printf "\ntPlease install nmap on this machine\n"
         exit 1
       fi
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
According to [results](screenshots/001.JPG) ***script1.sh is working as expected***.


[Script2.sh](script2.sh) analises apache access log and provides with the information about most active client and requested page, list of activity of all clients, non-existed requested pages, hour of the most activity and list of the bots:
```
#!/bin/bash

function wrong(){
  printf "\nPlease run the script with link to existed apache log file as first parameter:\n"
  printf "\n./script2.sh <path to the log file>\n\n"
  exit 1
}

function activeip(){
  printf "\nThe most active IP address was:\n"
  cat $1 |  awk '{print $1}' | sort | uniq -c | sort -n | tail -1 |awk '{print $2}'
}

function popularpage(){
  printf "\nThe most popular webpage was:\n"
  cat $1 | awk '{print $7}' | sort | uniq -c | sort -n | tail -1 | awk '{print $2}'
}

function ipactivity(){
  printf "\nList of active IP addresses and count of requests from them:\n"
  cat $1 |  awk '{print $1}' | sort | uniq -c | sort -nr
}

function nonexist(){
  printf "\nList of non-existed requested pages:\n"
  cat $1 | awk '{print $7,$9}' | grep 404 | sort | uniq -c |  awk '{print $2}'
}

function activetime(){
  b=$(cat $1 | awk '{print $4}' | cut -d: -f2 | sort | uniq -c | sort -n | tail -1 | awk '{print $2}')
  if [ "$b" == 23 ]
  then
    e=0
  else
    e=$((b+1))
  fi
  printf "\nTime of the most load was\n"
  printf "between $b:00 and $e:00\n"
}

function searchbots(){
  printf "\nList of searchbots:\n"
  cat $1 | awk '{ for ( n=1; n<=NF; n++ ) if ( ($n ~ "[Bb]ot/" || $n ~ "[Bb]ot$" ) && $n !~ "http" ) print $1,$n }' | sort | uniq
}


if  [ "$#" == "0" ]
then
  wrong
else
  if [ -e  "$1" ]
  then
    activeip $1
    popularpage $1
    ipactivity $1
    nonexist $1
    activetime $1
    searchbots $1
  else
    wrong
  fi
fi
```

According to [results](results.txt) that were got by running the ```./script2.sh example_log.log > results.txt``` ***script2.sh is working as expected***.



[Script3.sh](script3.sh) makes copy of data from the source foled to destination folder and save information about all changes in /var/log/backupscr.log file:
'''
#!/bin/bash

backupfile=/var/log/backupscr.log

function wrongp(){
  printf "\nPlease run the script with the following parameters:\n"
  printf "\n<source folder>        - data from this folder should be copied\n"
  printf "\n<destination folder>   - data from the source folder should be stored here\n\n"
}


if  [ "$#" != "2"  ]
then
  wrongp
  exit 1
else
  if [ ! -e $1 ]
  then
    printf "\nSource folder doesn't exist\n"
    wrongp
    exit 1
  elif [ ! -e $2 ]
  then
    printf "\nDestination folder doesn't exist, please create the foolder manually\n "
    wrongp
    exit 1
  elif [[ "$2" == *"$1"* ]]
  then
    printf "\nSousce and Destination folders can't be equal and destination can't be inside source tree\n"
    wrongp
    exit 1
  fi
fi

if [ ! -e "backup.log" ]
then
  touch backup.log
fi

echo "$(date) backup script is being run"  >> "$backupfile"

basepath=$(pwd)
cd $1
srcdir=$(pwd)
cd $basepath
cd $2
destdir=$(pwd)
cd $srcdir

for el in $(find ./*); do
  el="${el:2}"
  if [ -d $el ]
  then
    if [ ! -e "$destdir/$el" ]
    then
      mkdir "$destdir/$el"
      echo "$(date) folder $el has been added to backup" >> "$backupfile"
    fi
  else
    if [ ! -e "$destdir/$el" ]
    then
      cp "$el" "$destdir/$el"
      touch -r "$el" "$destdir/$el"
      echo "$(date) file $el has been added to backup" >> "$backupfile"
    elif [[ $(date -r $el) != $(date -r $destdir/$el) ]]
    then
      cp "$el" "$destdir/$el"
      touch -r "$el" "$destdir/$el"
      echo "$(date) file $el has been chanaged" >> "$backupfile"
    fi
  fi
done

cd $destdir
for el in $(find ./*); do
  el="${el:2}"
  if [ ! -e "$srcdir/$el" ]
  then
    rm -rf "$el"
    echo "$(date) $el has been removed" >> "$backupfile"
  fi
done

echo "$(date) backup script has been completed"  >> "$backupfile"
'''
For this script there was added the following task in server's crontab:
```
* * * * * /root/scripts/script3.sh /root/scripts /backup/scripts > /dev/null 2>&1
```
this task runs every minute and synchronize data in the original /root/scripts folder and backup /backup/scripts folder, all logs are being saved into /var/log/backupscr.log file

According to [screenshot1](screenshots/002.JPG) and [screenshot2](screenshots/003.JPG)that were got by manually running the ```./script3.sh /root/scripts /backup/scripts``` command ***script3.sh is working as expected***.
