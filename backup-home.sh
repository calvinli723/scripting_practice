#!/bin/bash

function usage {
    echo "Usage: $(basename $0) <destination_host>" 2>&1
    exit 1
}

if [ $# -lt 1 ]; then
    usage
fi

rsync -avz /home/$USER $1::backup
