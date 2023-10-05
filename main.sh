#!/bin/bash

# Check and load config
if [ -f "./config" ]; then
    source ./config
else
    cat <<EOF > ./config
cfgpath="/home/users/grub.cfg"

windows=
ubuntu=
EOF
    # TODO: warning
    exit 0
fi

# Define valiables
args=$1
target="${!args}"

# Check args
if [ $# -eq 0 ]; then
    # TODO: warning
    echo "Usage: $0 <windows|ubuntu>"
    exit 0
elif ! [[ $target =~ ^[0-9]+$ ]]; then
    # TODO: warning
    echo "no number"
    exit 1
fi


# Check if file exists
if [ ! -f "$cfgpath" ]; then
    echo "File $cfgpath does not exist."
    exit 1
fi

# Change default boot entry
sed -i -E "s/^   set default=\"[0-9]+\"$/   set default=\"$target\"/g" "$cfgpath"

# Success!
echo "Success! Changed default boot entry to '$args'. (No.$target)"