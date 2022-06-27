#!/bin/bash

function usage {
    echo "Usage: $(basename $0) <sshd_log>" 2>&1
    exit 1
}

if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

if [ $# -lt 1 ]; then
    usage
fi

# search log file for entries from "sshd" with "Failed password", get IP field, sort with counts
cat $1 | grep "Failed password" | awk '{print $11}' | uniq -c | sort -nr > _ip_counts
# get IP counts greater than 10
awk '{ if($1 > 10) print $1" "$2}' _ip_counts > _suspect_ips
rm _ip_counts

# produce CSV output of Count,IP,Location
while read line; do
    curr_count=$(echo $line | awk '{print $1}')
    curr_ip=$(echo $line | awk '{print $2}')
    curr_country=$(geoiplookup $curr_ip)
    echo $curr_count,$curr_ip,$curr_country
done < _suspect_ips
rm _suspect_ips
