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

while getopts ${optstring} arg; do
  case ${arg} in
    a)
      echo "option a"
      ;;
    d)
      echo "option d"
      ;;
    r)
      echo "option r"
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

if [ $(( $# - $OPTIND )) -lt 1 ]; then
    usage
fi

username=$(@:$OPTIND:1)

echo $username

passwd $username -l




