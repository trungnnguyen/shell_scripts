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
greatings () {
  echo
  echo 'FSCP -- Fast SCP'
  echo 'Version 1.0'
  echo 'By: Mojtaba Komeili'
  echo
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
    echo 'FSCP loaded the list of previously used serveres'
    read_user_file
  else
    touch $profile_file_name
    echo 'A new fscp_profile file was created.'
  fi
}

########################################################################
#
# Main function body
#
greatings
load_user_profile












# End of the script file
