#!/bin/bash

###### Hyprland Installation Script for Arch Linux ######
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

# set the log file
log="Install-Logs/write_bangla.log"

# install script dir
ScrDir=`dirname "$(realpath "$0")"`
source $ScrDir/1-global.sh

# necessary tools
packages=(
    clang
    cmake
    gcc
    ibus
    ibus-devel
    libQt5Core-devel
    libQt5Widgets-devel
    libQt5Network-devel
    libzstd-devel
    libzstd1
    make
    ninja
    patterns-devel-base-devel_basis
    rust
)

printf "${action} - Now installing necessary packages\n" 
sleep 1
clear

for pkgs in "${packages[@]}"; do
    install_package "$pkgs" "$log"


printf "${action} - Now building ${yellow}Openbangla Keyboard ${end}...\n"

if git clone --recursive https://github.com/OpenBangla/OpenBangla-Keyboard.git; then
    cd OpenBangla-Keyboard
    mkdir build && cd build
    cmake .. -DENABLE_IBUS=ON-DENABLE_FCITX=ON
    make
    sudo make install

    if [ -f '/usr/share/openbangla-keyboard' ]; then
        printf "${done} - OpenBangla Keyboard was installed successfully..\n"
        printf "[ DONE ] - OpenBangla Keyboard was installed successfully..\n" 2>&1 | tee -a "$log" &>> /dev/null
    fi
    sleep 1
    clear
else
    printf "${error} - Could not build OpenBangla Keyboard. Maybe you need to build it by yourself.\n"
    printf "[ ERROR ] - Could not build OpenBangla Keyboard. Maybe you need to build it by yourself.\n" 2>&1 | tee -a "$log" &>> /dev/null
fi

sleep 1

printf "${action} - Now installing some bangla fonts. \n"

if git clone https://github.com/me-js-bro/Bangla-Fonts.git; then

    mkdir -p ~/.local/share/fonts
    cd Bangla-Fonts
    cp -r Bangla-Fonts ~/.local/share/fonts
    sudo fc-cache -fv
fi

clear
