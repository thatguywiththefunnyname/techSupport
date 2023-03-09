#!/usr/bin/bash

declare -g PASSWD=""

echo "Welcome to the Update bot"

run_script()
{
	while true
	do
		help_command
		read -p "What would you like to do? " COMMAND
		if [[ $COMMAND == 'done' ]]
		then	
			break
		elif [[ $COMMAND == 'autofix' ]]
		then
			update_apt
		elif [[ $COMMAND == 'help' ]]
		then
			help_command
		elif [[ $COMMAND == 'update_apt' ]] 
		then
			update_software
		elif [[ $COMMAND == 'update_fltpk' ]] 
		then
			update_flatpak
		else
			echo "Sorry, I do not understand that command $COMMAND"
			echo "You can type 'help' to get the list of commands available"
		fi
	done
}

update_flatpak()
{
	flatpak update -y
	
}

help_command()
{
	echo "These are some of the commands I can do
	help			-	Show a list a commands
	autofix			-	Autofind problems and autofix them
	update_apt		-	Update the apt packages found
	update_fltpk	-	Update the flatpak packages found
	done			-	Close the Update bot"

}

check_if_can_sudo(){
	declare -g PASSWD
	CAN_SUDO=$(sudo -n uptime 2>&1 | grep "load" | wc -l)
	# sudo -v
	if [ $? -ne 0 ]
	then
		while true;do
			read -sp '[sudo] please enter password for sudo access: ' passwd
			PASSWD=$passwd
			sudo -S -v <<< $PASSWD
			if [ $? -ne 0 ]
			then
				echo "Incorrect password! Please try again."
			else
				return 0
			fi
		done
	else
		return 0
	fi
}
update_apt()
{
	declare -g PASSWD
	check_if_can_sudo
	if [ $? -eq 0 ]
	then
		echo "Checking apt repos for updates..."
		echo "$PASSWD" | sudo -S apt-get update >> stuff.txt && echo "Applying any updates we found" 
		sudo apt-get upgrade -y >> update.txt
		result=check_errors_request
		if [ $result -ne 0 ]
		then
			rm stuff.txt
			rm update.txt
		fi
	fi
}
check_errors_request(){
	read -p "Would you like to check for any errors? (y/N)" REQUEST
	if [ "$REQUEST" = "y" ]
	then
		check_errors_held_back
		return 0
	else
		return 1
}

fix_config_error_dpkg()
{
	check_if_can_sudo
	if [ $? -eq 0 ]
	then
		echo "Checking for dpkg errors..."
		sudo apt update && sudo apt upgrade >> dpkg.txt
		DPKG_TMP_VAR=$(grep "E: dpkg" dpkg.txt)
		REMOVE_PACKAGE=$(grep "--remove")
		PACKAGE_NAME_AT_FRONT=$(grep -o 'package.*')
		PACKAGE_NAME=$(grep -o '^\S*')
		if [ -n "$DPKG_TMP_VAR" ]
		then
			if [ -n "$REMOVE_PACKAGE" ]
			echo "dpkg error found:\n$REMOVE_PACKAGE"
			printf "Attempting to fix dpkg error..."
			sudo apt-get remove $PACKAGE_NAME
			sudo apt-get install $PACKAGE_NAME
			
		fi
	fi
}

dpkg_errors()
{
	read -p "Which dpkg error would you like to fix?\n1:dpkg config error
	\n2:dpkg can't locate package"
}

check_errors_held_back()
{
	HELD_BACK=$(grep "The following packages have been held back" update.txt)
	if [ ${HELD_BACK}='' ]
	then
		continue
	else
		echo "I've found packages that need reinstalling, reinstalling them..." 
		temporay_variable_for_line=$(grep -A 1 "The following packages have been held back" update.txt)
		temporary_sed_var=$(sed '2p;d' $temporary_variable_for_line) 
		sudo apt install --reinstall $temporary_sed_var 
		 
		
		
	fi
}

autoremove()
{
	FIND=$(grep autoremove update.txt)
	if [ ${FIND}='' ]
	then
		rm update.txt
		echo "Checking if anything needs removing..."
		sudo apt-get autoclean >> clean.txt && sleep 3 && sudo apt-get clean
		rm clean.txt
		echo "Update Complete :)"
	else
		echo "Just Cleaning some unnecessary files :) "
		sudo apt-get autoremove -y && sudo apt-get autoclean && rm update.txt
		echo "All done now! Have a productive day :D"
	fi
}
run_script
