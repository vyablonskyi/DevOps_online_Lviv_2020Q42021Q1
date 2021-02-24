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
