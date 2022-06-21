#!/bin/bash

function usage {
        echo "Usage: $(basename $0) [-adr] <username>" 2>&1
	echo '   -d   Deletes user account(s) instead of simply disabling'
	echo '   -r   Removes the home directorys associated with the account(s)'
	echo '   -a   Creates an archive of the home directory associated with each user account'
        exit 1
}

if [[ $UID != 0 ]]
then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

optstring=":ard"
ARCHIVE=false
USERDEL=false
DELHOME=false

while getopts ${optstring} arg; do
  case ${arg} in
    a)
      ARCHIVE=true
      ;;
    d)
      USERDEL=true
      ;;
    r)
      DELHOME=true
      ;;
    :)
      echo "$0: Must supply an argument to -$OPTARG." >&2
      exit 1
      ;;
    ?)
      echo "Invalid option: -${OPTARG}."
      exit 1
      ;;
  esac
done

shift $((OPTIND-1))
if [ $# -lt 1 ]; then
    usage
fi

username=$1

echo $username

if [ $ARCHIVE ]; then
    if [ ! -d "/archive" ]; then
        echo "Directory '/archive' not found; creating /archive"
	mkdir /archive
    fi
    cp -r /home/$username /archive
fi

if [ $USERDEL ]; then
    userdel $username
else
    passwd $username -l
fi

if [ $DELHOME ]; then
    rm -rf /home/$username
fi
