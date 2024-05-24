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

log="Install-Logs/dotfiles.log"

mkdir -p ~/.config

    printf "${note} - Copying config files...\n"
    for DIR in btop cava dunst hypr kitty neofetch rofi swaylock waybar wlogout; do
        DIRPATH=~/.config/$DIR
        if [ -d "$DIRPATH" ]; then
            printf "${attention} - Config for $DIR located, backing up.\n"
            printf "[ ATTENTION ] - Config for $DIR located, backing up.\n"  2>&1 | tee -a "$log" &>> /dev/null
            mv $DIRPATH $DIRPATH-back
            printf "${done} - Backed up $DIR to $DIRPATH-back.\n"
            printf "[ DONR ] - Backed up $DIR to $DIRPATH-back.\n"  2>&1 | tee -a "$log" &>> /dev/null
        fi
    done

    sleep 1

    clear

    printf "${action} - Cloning and copying dotfiles...\n"

    hypr_dir="$HOME/.config/hypr"
    if [ -d $hypr_dir ]; then
    mv ~/.config/hypr ~/.config/hypr-backup
    fi

    git clone --depth=1 https://github.com/me-js-bro/Hyprland-Dots-01.git ~/.config/hypr  2>&1 | tee -a "$log" && sleep 1

    if [ -d "$hypr_dir/scripts" ]; then

        mv "$hypr_dir/opensuse-neofetch"  "$hypr_dir/neofetch"

        sleep 1

        ln -sf ~/.config/hypr/btop ~/.config/btop
        ln -sf ~/.config/hypr/kitty ~/.config/kitty
        ln -sf ~/.config/hypr/neofetch ~/.config/neofetch
        ln -sf ~/.config/hypr/rofi ~/.config/rofi
        ln -sf ~/.config/hypr/swaylock ~/.config/swaylock
        ln -sf ~/.config/hypr/waybar ~/.config/waybar
        ln -sf ~/.config/hypr/wlogout ~/.config/wlogout
        sleep 1

        printf "${done} - Copying config files finished...\n"
        printf "[ ERROR ] - Copying config files finished\n"  2>&1 | tee -a "$log" &>> /dev/null
    else 
        printf "${error} -  Sorry, Maybe could not clone dotfiles from the github\n"
        printf "[ ERROR ] -  Sorry, Maybe could not clone dotfiles from the github\n"  2>&1 | tee -a "$log" &>> /dev/null
    fi

sleep 1

# Adding all the scripts

SCRIPT_DIR=~/.config/hypr/scripts/
if [ -d $SCRIPT_DIR ]; then
    # make all the scripts executable...
    chmod +x "$SCRIPT_DIR"/*

    printf "${done} - All the necessary scripts have been executable.\n"
    printf "[ DONE ] - All the necessary scripts have been executable.\n"  2>&1 | tee -a "$log" &>> /dev/null
    sleep 1

else
    printf "${error} - Could not find necessary scripts\n"
    printf "[ ERROR ] - Could not find necessary scripts.\n"  2>&1 | tee -a "$log" &>> /dev/null
fi

# remove .git
  sudo rm -rf ~/.config/hypr/.git

gsettings set org.gnome.desktop.interface gtk-theme "theme"
gsettings set org.gnome.desktop.interface icon-theme "Tela-circle-dracula"
gsettings set  org.gnome.desktop.interface cursor-theme 'Nordzy-cursors'

clear
