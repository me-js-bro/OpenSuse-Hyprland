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

# set the log file
log="Install-Logs/cliphist.log"

package=(
    go
)


# package installation function for " go "..
install_go() {

    # set the log files variable
    log="$2"

  # Checking if package is already installed
  if sudo zypper se -i "$1" &>> /dev/null ; then
    printf "${done} - $1 is already installed. Skipping...\n"
    printf "[ DONE ] - $1 is already installed. Skipping...\n" 2>&1 | tee -a "$log" &>> /dev/null
  else
    # Package not installed
    printf "${action} - Installing $1 ...\n"
    sudo zypper in -f -y "$1" 2>&1 | tee -a "$log"
    # Making sure package is installed
    if sudo zypper se -i "$1" &>> /dev/null ; then
      printf "${done} - $1 was installed successfully!\n"
      printf "[ DONE ] - $1 was installed successfully!\n" 2>&1 | tee -a "$log" &>> /dev/null
      printf " \n"
    else
      # Something is missing, exiting to review log
      printf "${error} - $1 failed to install :( , please check the install.log .Maybe you need to install manually.\n"
      printf "[ ERROR ] -  $1 failed to install :( , please check the install.log. Maybe you need to install manually.\n" 2>&1 | tee -a "$log" &>> /dev/null
      exit 1
    fi
  fi
}

for pkg in "${package[@]}"; do
    install_go "$pkg" "$log"
done

# Install cliphist using go
export PATH=$PATH:/usr/local/bin
go install go.senan.xyz/cliphist@latest 2>&1 | tee -a "$log"

# copy cliphist into /usr/local/bin for some reason it is installing in ~/go/bin
sudo cp -r "$HOME/go/bin/cliphist" "/usr/local/bin/" 2>&1 | tee -a "$log"

clear