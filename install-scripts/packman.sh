#!/bin/bash

# color defination
red="\e[1;31m"
green="\e[1;32m"
yellow="\e[1;33m"
blue="\e[1;34m"
megenta="\e[1;1;35m"
cyan="\e[1;36m"
end="\e[1;0m"

# initial texts
attention="${yellow}[ ATTENTION ]${end}"
action="${green}[ ACTION ]${end}"
note="${megenta}[ NOTE ]${end}"
done="${cyan}[ DONE ]${end}"
error="${red}[ ERROR ]${end}"

# Set the name of the log file
log="Install-Logs/packman.log"

# packman repository
packman_repo="https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/"


# Adding Packman repository and switching over to Packman
printf "${attention} - Adding Packman repository (Globally).... \n"

sudo zypper -n --quiet ar --refresh -p 90 "$packman_repo" packman 2>&1 | tee -a "$log"
sudo zypper --gpg-auto-import-keys refresh 2>&1 | tee -a "$log"
sudo zypper -n dup --from packman --allow-vendor-change 2>&1 | tee -a "$log"

clear
