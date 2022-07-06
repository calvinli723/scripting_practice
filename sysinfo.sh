#!/bin/bash
# sysinfo.sh - Simple script to display system information
# Author: Calvin Li
# Date: Jul 6, 2022

# Display header message
# $1 - message
function write_header(){
    local h="$@"
    echo "---------------------------------------------------------------"
    echo "     ${h}"
    echo "---------------------------------------------------------------"
}

# display kernel information
function report_kernel_info()
{
    write_header " Kernel info "
    /bin/uname -a
}

# display OS information
function report_OS_info()
{
    write_header " OS info "
    # display OS information
    cat /etc/*-release
}

# display CPU information
function report_CPU_info()
{
    write_header " CPU info "
    lscpu
}

function report_disk_usage()
{
    write_header " Disk usage "
    df -h
}

# Purpose - Network inferface and routing info
function report_net_info()
{
    echo "*** IP Addresses Information ***"
    ip -4 address show
}

# Purpose - Display used and free memory info
function report_mem_info()
{
    write_header " Free and used memory "
    free -m

    echo "*********************************"
    echo "*** Virtual memory statistics ***"
    echo "*********************************"
    vmstat
    echo "***********************************"
    echo "*** Top 5 memory eating process ***"
    echo "***********************************"
    ps auxf | sort -nr -k 4 | head -5
    pause
}

function report_users_info()
{
    write_header " Active Users "
    who -H
}

function report_updates_info()
{
    write_header " Updates info "
    apt list --upgradeable
}

report_kernel_info
echo
report_OS_info
echo
report_CPU_info
echo
report_disk_usage
echo
report_net_info
echo
report_mem_info
echo
report_users_info
echo
report_updates_info
