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


# package installation function..
install_package() {

    # set the log files variable
    log="$2"

  # Checking if package is already installed
  if sudo zypper se -i "$1" &>> /dev/null ; then
    printf "${done} - $1 is already installed. Skipping...\n"
    printf "[ DONE ] - $1 is already installed. Skipping...\n" 2>&1 | tee -a "$log" &>> /dev/null
  else
    # Package not installed
    printf "${action} - Installing $1 ...\n"
    sudo zypper in -y "$1" 2>&1 | tee -a "$log"
    # Making sure package is installed
    if sudo zypper se -i "$1" &>> /dev/null ; then
      printf "${done} - $1 was installed successfully!\n"
      printf "[ DONE ] - $1 was installed successfully!\n" 2>&1 | tee -a "$log" &>> /dev/null
      printf " \n"
    else
      # Something is missing, exiting to review log
      printf "${error} - $1 failed to install :( , please check the install.log .Maybe you need to install manually.\n"
      printf "[ ERROR ] -  $1 failed to install :( , please check the install.log. Maybe you need to install manually.\n" 2>&1 | tee -a "$log" &>> /dev/null
      # exit 1
    fi
  fi
}

# package installation function for devel_basis..
install_package_base() {

    # set the log files variable
    log="$2"

  # Checking if package is already installed
  if sudo zypper se -i "$1" &>> /dev/null ; then
    printf "${done} - $1 is already installed. Skipping...\n"
    printf "[ DONE ] - $1 is already installed. Skipping...\n" 2>&1 | tee -a "$log" &>> /dev/null
  else
    # Package not installed
    printf "${action} - Installing $1 ...\n"
    sudo zypper in -y -t pattern "$1" 2>&1 | tee -a "$log"
    # Making sure package is installed
    if sudo zypper se -i "$1" &>> /dev/null ; then
      printf "${done} - $1 was installed successfully!\n"
      printf "[ DONE ] - $1 was installed successfully!\n" 2>&1 | tee -a "$log" &>> /dev/null
      printf " \n"
    else
      # Something is missing, exiting to review log
      printf "${error} - $1 failed to install :( , please check the install.log .Maybe you need to install manually.\n"
      printf "[ ERROR ] -  $1 failed to install :( , please check the install.log. Maybe you need to install manually.\n" 2>&1 | tee -a "$log" &>> /dev/null
      # exit 1
    fi
  fi
}

# package installation function no recommends..
install_package_no_recommands() {

    # set the log files variable
    log="$2"

  # Checking if package is already installed
  if sudo zypper se -i "$1" &>> /dev/null ; then
    printf "${done} - $1 is already installed. Skipping...\n"
    printf "[ DONE ] - $1 is already installed. Skipping...\n" 2>&1 | tee -a "$log" &>> /dev/null
  else
    # Package not installed
    printf "${action} - Installing $1 ...\n"
    sudo zypper in -y --no-recommends "$1" 2>&1 | tee -a "$log"
    # Making sure package is installed
    if sudo zypper se -i "$1" &>> /dev/null ; then
      printf "${done} - $1 was installed successfully!\n"
      printf "[ DONE ] - $1 was installed successfully!\n" 2>&1 | tee -a "$log" &>> /dev/null
      printf " \n"
    else
      # Something is missing, exiting to review log
      printf "${error} - $1 failed to install :( , please check the install.log .Maybe you need to install manually.\n"
      printf "[ ERROR ] -  $1 failed to install :( , please check the install.log. Maybe you need to install manually.\n" 2>&1 | tee -a "$log" &>> /dev/null
      # exit 1
    fi
  fi
}

# package installation function ( opi )..
install_package_opi() {

    # set the log files variable
    log="$2"

  # Checking if package is already installed
  if sudo zypper se -i "$1" &>> /dev/null ; then
    printf "${done} - $1 is already installed. Skipping...\n"
    printf "[ DONE ] - $1 is already installed. Skipping...\n" 2>&1 | tee -a "$log" &>> /dev/null
  else
    # Package not installed
    printf "${action} - Installing $1 ...\n"
    sudo opi "$1" -n 2>&1 | tee -a "$log"
    # Making sure package is installed
    if sudo zypper se -i "$1" &>> /dev/null ; then
      printf "${done} - $1 was installed successfully!\n"
      printf "[ DONE ] - $1 was installed successfully!\n" 2>&1 | tee -a "$log" &>> /dev/null
      printf " \n"
    else
      # Something is missing, exiting to review log
      printf "${error} - $1 failed to install :( , please check the install.log .Maybe you need to install manually.\n"
      printf "[ ERROR ] -  $1 failed to install :( , please check the install.log. Maybe you need to install manually.\n" 2>&1 | tee -a "$log" &>> /dev/null
      # exit 1
    fi
  fi
}