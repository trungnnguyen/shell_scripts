#!/bin/bash
# This script helps in transferring files from your computer to a server
# The script uses "scp" UNIX command
# The purpose is to make it easier to copy files to and from servers that
# are used regualrly. It keeps a list of servers you connected to in the past.
# User can add server addresses and use them later.

clear
# Defining the variables
bool_file_exists=0
profile_file_name='.fscp_profile'
number_of_stored_servers=0
pad=$(printf '%0.1s' "-"{1..60})

########################################################################
#
# Main function body
#
########################################################################

########################################################################
# Loading user profile and info

# Getting number of previously stored servers
count_number_of_servers () {
  a=$( wc -l < "$profile_file_name" )
  number_of_stored_servers=$((a))
}

# Reading list of servers
read_user_file () {
  server_counter=1
  echo 'List of servers in your profile'
  printf 'ID \t Name \t\t\t\t Address\n'
  printf '%.1s' "-"{1..100}
  echo
  while IFS=';' read -r f1 f2
  do
    printf '%d \t %-30s %s\n' "$server_counter" "$f1" "$f2"
    server_counter=$((server_counter+1))
  done <"$profile_file_name"
}

# Loading servers data from file
load_user_profile () {
  if [ -e "$profile_file_name" ]
  then
    echo 'Loading list of previously used serveres'
    bool_file_exists=1
    count_number_of_servers
    read_user_file
  else
    touch $profile_file_name
    echo 'A new fscp_profile file was created.'
  fi
}

########################################################################
# Handling the main menu

# Showing the starting page info
greatings () {
  echo
  echo 'FSCP -- Fast SCP'
  echo 'Version 1.0'
  echo 'By: Mojtaba Komeili'
  echo
}

# Options that are given to user on the main menu
main_menu () {
  echo
  echo '(c) connect to server'
  echo '(a) add a new server'
  echo '(r) remove server'
  echo '(q) quit'
}

# A listener to get user response on the main menu
main_menu_respond () {
  read -n 1 -p 'Insert your selection: ' user_input
  echo
  if [[ $user_input == 'c' || $user_input == 'C' ]]; then
    echo "You are about to connect"
  elif [[ $user_input == 'a' || $user_input == 'A' ]]; then
    echo "Adding a new server"
  elif [[ $user_input == 'r' || $user_input == 'R' ]]; then
    echo "Removing a server"
  elif [[ $user_input == 'q' || $user_input == 'Q' ]]; then
    exit 0
  else
    echo "Invalid, try again."
    main_menu_respond
  fi
}

########################################################################
# Connecting and copying files


########################################################################
# Add and remvoe servers

########################################################################
#
# Main function body
#
user_input = " "
greatings
load_user_profile
main_menu
main_menu_respond














# End of the script file
