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

########################################################################
#
# Main function body
#

# Showing the starting page info
main_menu () {
  echo
  echo 'FSCP -- Fast SCP'
  echo 'Version 1.0'
  echo 'By: Mojtaba Komeili'
  echo
  echo 'Select your actions:'
  echo '(s) connect to server (ssh)'
  echo '(c) copy file to server (scp)'
  echo '(l) list current serveres'
  echo '(a) add a new server'
}

# Getting number of previously stored servers
count_number_of_servers () {
  a=$( wc -l < "$profile_file_name" )
  number_of_stored_servers=$((a))
}

# Reading list of servers
read_user_file () {
  server_counter=1
  while IFS=';' read -r f1 f2
  do
    printf 'Server #%d: %s \t\t Address: %s\n' "$server_counter" "$f1" "$f2"
    server_counter=$((server_counter+1))
  done <"$profile_file_name"
}

# Loading servers data from file
load_user_profile () {
  if [ -e "$profile_file_name" ]
  then
    bool_file_exists=1
    count_number_of_servers
    read_user_file
    echo 'FSCP loaded the list of previously used serveres'
  else
    touch $profile_file_name
    echo 'A new fscp_profile file was created.'
  fi
}

# prompt user for selection
prompt_user_for_selection() {
  read -p 'Please insert your selection: ' user_input
  return $user_input
}

########################################################################
#
# Main function body
#
main_menu













# End of the script file
