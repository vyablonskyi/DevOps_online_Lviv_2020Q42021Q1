#!/bin/bash

backupfile=/var/log/backupscr.log
# justcomment

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
