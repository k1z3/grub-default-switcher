#!/bin/bash

cd $(dirname $0)

# Check and load config
if [ -f "./config" ]; then
    source ./config
else
    cat <<EOF > ./config
cfgpath="/home/users/grub.cfg"

ubuntu=
windows=
EOF
fi

# Check args
if [ $# -eq 0 ]; then
    cat <<EOF
Usage: 1st, Write default indexes corresponding to the boot OS in the config file."
       2nd, Run this script with the name you want to boot as an argument.

  (Ex) ./main.sh ubuntu
EOF
    exit 0
fi

# Define valiables
args=$1
target="${!args}"

# Check if args is defined in config
if ! [[ $target =~ ^[0-9]+$ ]]; then
    echo -e "[\e[31mFailed\e[0m] '$args' or no value is specified is not defined in the config file."
    exit 1
fi

# Check if file exists
if [ ! -f "$cfgpath" ]; then
    echo -e "[\e[31mFailed\e[0m] File $cfgpath does not exist."
    exit 1
fi

# Change default boot entry
sed -i -E "s/^   set default=\"[0-9]+\"$/   set default=\"$target\"/g" "$cfgpath"

# Output result
if [ $? -eq 0 ]; then
    # Success!
    echo -e "[\e[32mSuccess\e[0m] Changed default boot entry to '$args'. (Index: $target)"
    exit 0
else
    # Failed
    echo -e "[\e[31mFailed\e[0m] Failed due to lack of write permission, etc."
    exit 1
fi