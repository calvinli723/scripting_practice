#!/bin/bash

if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

echo -n "Username: "
read user
echo -n "Password: "
read password

useradd $user -p $password
#if [[ $? != 0]]; then
if [[ $? != 0 ]]; then
    echo "Failed to add user $user"
    exit 1
fi

echo "User: $user"
echo "Password: $password"
echo "Host: $HOSTNAME"

