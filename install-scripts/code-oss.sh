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

# Set the name of the log file
log="Install-Logs/vs_code.log"

if sudo zypper se -i code &>> /dev/null ; then
    printf "${done} - Visual Studio Code is already installed, proceeding to next step\n"
    printf "[ DONE ] - Visual Studio Code is already installed, proceeding to next step\n"  2>&1 | tee -a "$log" &>> /dev/null
else
    printf "${attention} - Processing to install Visual Studio Code... \n"
    printf "[ ATTENTION ] - Processing to install Visual Studio Code\n" 2>&1 | tee -a "$log" &>> /dev/null
    sleep 1

    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo zypper addrepo https://packages.microsoft.com/yumrepos/vscode vscode
    sudo zypper refresh
    sudo zypper in code

    if sudo zypper se -i code &>> /dev/null ; then
        printf "${done} - Visual Studio Code was installed successfully..\n"
        printf "[ DONE ] - Visual Studio Code was installed successfully\n" 2>&1 | tee -a "$log" &>> /dev/null

        vs_code_dir=~/.config/Code
        vs_code_plugins_dir=~/.vscode
            if [ -d "$vs_code_dir" ]; then
                printf "${action} - Backing up .config/Code directory...\n"
                mv $vs_code_dir $vs_code_dir.backup
                printf "[ DONE ] - backed up $vs_code_dir\n"  2>&1 | tee -a "$log" &>> /dev/null
            fi

            if [ -d "$vs_code_plugins_dir" ]; then
                printf "${action} - Backing up directory...\n"
                mv $vs_code_plugins_dir $vs_code_plugins_dir.backup
                printf "[ DONE ] - backed up $vs_code_plugins_dir\n"  2>&1 | tee -a "$log" &>> /dev/null
            fi
            
        printf "${action} - Copying Code directory..."
        cp -r extras/Code ~/.config/
        cp -r extras/.vscode ~/
        sleep 1

        printf "${done} - Vs Code themes and some plugins have been copied\n"
        printf "[ DONE ] - Vs Code themes and some plugins have been copied\n"  2>&1 | tee -a "$log" &>> /dev/null
    else
        printf "${error} - Could not installed Visual Studio Code. Please check the $log file Maybe you need to install it manually.\n" 
        printf "[ ERROR ] - Could not installed Visual Studio Code. Please check the $log file Maybe you need to install it manually.\n" 2>&1 | tee -a "$log" &>> /dev/null
    fi
fi

clear