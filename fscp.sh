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
  server_counter=0
  while IFS=';' read -r f1 f2 f3
  do
    server_list_names[server_counter]="$f1"
    server_list_addrs[server_counter]="$f2"
    server_list_usrnm[server_counter]="$f3"
    server_counter=$((server_counter+1))
  done <"$profile_file_name"
}

# Loading servers data from file
load_user_profile () {
  if [ -e "$profile_file_name" ]
  then
    echo 'Loading list of previously used serveres ...'
    bool_file_exists=1
    count_number_of_servers
    read_user_file
  else
    touch $profile_file_name
    echo 'No serveres profile found in your profile.'
    echo 'A new fscp_profile file was created.'
    echo
  fi
}

print_servers_list () {
  # if no server is saved in the list
  if [[ $number_of_stored_servers < 1 ]]; then
    echo 'You have no servers saved in your profile.'
    return
  fi

  # if the server list exists
  echo 'List of servers in your profile'
  printf '# \t Name \t\t\t\t Address \t\t\t\t User name\n'
  printf '%.1s' "-"{1..100}
  echo

  for (( i = 0; i < number_of_stored_servers ; i++ )); do
    printf '%d \t %-20s %-50s %s \n' "$((i+1))" "${server_list_names[i]}" "${server_list_addrs[i]}" "${server_list_usrnm[i]}"
  done
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
  if [[ $number_of_stored_servers > 0 ]]; then
    echo '(c) connect to server'
    echo '(r) remove server'
  fi
  echo '(a) add a new server'
  echo '(q) quit'
}

# A listener to get user response on the main menu
main_menu_respond () {
  read -p 'Insert your selection: ' user_input

  if [[ $user_input == 'c' || $user_input == 'C' ]]; then
    connect_select_server
  elif [[ $user_input == 'a' || $user_input == 'A' ]]; then
    echo 'Adding a new server'
  elif [[ $user_input == 'r' || $user_input == 'R' ]]; then
    echo 'Removing a server'
  elif [[ $user_input == 'q' || $user_input == 'Q' ]]; then
    exit 0
  else
    echo 'Invalid, try again.'
    main_menu_respond
  fi
}

########################################################################
# Connecting and copying files
# Four variables are used here "connection_ID", "connection_type"
# "connection_copy_from", and "connection_copy_to"

connect_select_server () {
  read -p 'Insert the server ID# (above list), or (R)eturn: ' user_input
  if [[ $user_input == 'r' || $user_input == 'R' ]]; then
    main_menu
    main_menu_respond
  elif [[ $user_input < $((number_of_stored_servers+1))  && $user_input > 0  ]]; then
    connection_ID=$user_input
    connect_select_connection
  else
    echo 'Invalid, try again.'
    connect_select_server
  fi
}

connect_select_connection () {
  read -p 'Select connction type. (S)sh or s(C)p, or (R)eturn: ' user_input
  if [[ $user_input == 'r' || $user_input == 'R' ]]; then
    main_menu
    main_menu_respond
  elif [[ $user_input == 's' || $user_input == 'S'  ]]; then
    connect_ssh
  elif [[ $user_input == 'c' || $user_input == 'C'  ]]; then
    connect_scp_from
  else
    echo 'Invalid, try again.'
    connect_select_server
  fi
}

connect_scp_from () {
  echo "From"
}

connect_scp_to () {
  echo "To"
}

connect_ssh () {
  printf 'Establishing secure shell connection ... '
  i=$((connection_ID-1))
  CONNECTION_ARGUMENT=$(printf '%s@%s' "${server_list_usrnm[i]}" "${server_list_addrs[i]}")
  printf 'Connecting to %s \n' "$CONNECTION_ARGUMENT"
  ssh $CONNECTION_ARGUMENT
}

########################################################################
# Add and remvoe servers

########################################################################
#
# Main function body
#
greatings
load_user_profile
print_servers_list
main_menu
main_menu_respond














# End of the script file
