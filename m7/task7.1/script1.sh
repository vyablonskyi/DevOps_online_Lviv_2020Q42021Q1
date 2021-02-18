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
