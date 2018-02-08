#!/bin/bash
clear
PS3='Please enter your choice: '
options=("Process-Management" "User-Management" "Storage-Management" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Process-Management")
            echo "you chose choice 1"
            ;;
        "User-Management")
            echo "you chose choice 2"
            ;;
        "Storage-Management")
            echo "you chose choice 3"
            ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done
