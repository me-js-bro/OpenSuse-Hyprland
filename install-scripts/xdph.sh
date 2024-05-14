#!/bin/bash

####### Hyprland Installation Script for OpenSuse #######
#                                                       #
#       ███╗   ███╗ █████╗ ██╗  ██╗██╗███╗   ██╗        #
#       ████╗ ████║██╔══██╗██║  ██║██║████╗  ██║        #
#       ██╔████╔██║███████║███████║██║██╔██╗ ██║        #
#       ██║╚██╔╝██║██╔══██║██╔══██║██║██║╚██╗██║        #
#       ██║ ╚═╝ ██║██║  ██║██║  ██║██║██║ ╚████║        #
#       ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝        #
#                                                       #
#########################################################

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
log="Install-Logs/xdph.log"

# install script dir
ScrDir=`dirname "$(realpath "$0")"`
source $ScrDir/1-global.sh

xdg=(
xdg-desktop-portal-hyprland
xdg-desktop-portal-gtk
)


# XDG-DESKTOP-PORTALS
for xdgs in "${xdg[@]}"; do
  install_package_no_recommands "$xdgs" 2>&1 | tee -a "$log"
  if [ $? -ne 0 ]; then
    printf "${error} - $xdph install had failed, please check the install.log"
    exit 1
  fi
done

printf "${note} Checking for other XDG-Desktop-Portal-Implementations....\n"
sleep 1
printf "\n"
printf "${note} XDG-desktop-portal-KDE & GNOME (if installed) should be manually disabled or removed!\n"
while true; do
    read -rp "${note} Would you like to try to remove other XDG-Desktop-Portal-Implementations? [ y/n ] " XDPH1
    echo
    sleep 1

    case $XDPH1 in
      [Yy])
        # Clean out other portals
        printf "${note} Clearing any other xdg-desktop-portal implementations...\n"
        # Check if packages are installed and uninstall if present
        if sudo zypper se -i xdg-desktop-portal-wlr &>> /dev/null; then
        printf "Removing xdg-desktop-portal-wlr..."
        sudo zypper rm -y xdg-desktop-portal-wlr 2>&1 | tee -a "$log"
        fi

        if sudo zypper se -i xdg-desktop-portal-lxqt &>> /dev/null; then
        printf "Removing xdg-desktop-portal-lxqt..."
        sudo zypper rm -y xdg-desktop-portal-lxqt 2>&1 | tee -a "$log"
        fi

        break
        ;;
      [Nn])
        printf "no other XDG-implementations will be removed." 2>&1 | tee -a "$log"
        break
        ;;
        
      *)
        printf "Invalid input. Please enter 'y' for yes or 'n' for no."
        ;;
    esac
done

clear