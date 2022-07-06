#!/bin/bash

function usage {
    echo "Usage: $(basename $0) <src_folder> <user> <dest_host:/dest_folder>" 2>&1
    exit 1
}

if [ $# -lt 3 ]; then
    usage
fi

scp -r $1 $2@$3
