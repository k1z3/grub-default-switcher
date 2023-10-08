# Set Windows the default boot (Script for Ubuntu).
cd $(dirname $0)
/home/koizumi/grub-change-default/main.sh windows

if [ $? -eq 0 ]; then
    sleep 5;
else
    read -p "Please enter any key..."
fi
