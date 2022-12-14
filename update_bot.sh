#!/usr/bin/bash

declare -g PASSWD=""

echo "Welcome to the Update bot"

run_script()
{
	while true
	do
		read -p "What would you like to do? " COMMAND
		if [[ $COMMAND == 'done' ]]
		then	
			break
		elif [[ $COMMAND == 'autofix' ]]
		then
			update_software
		elif [[ $COMMAND == 'help' ]]
		then
			help_command
		elif [[ $COMMAND == 'update' ]] 
		then
			update_software
		else
			echo "Sorry, I do not understand that command $COMMAND"
			echo "You can type 'help' to get the list of commands available"
		fi
	done
}
help_command()
{
	echo "These are some of the commands I can do
	help		-	Show a list a commands
	autofix		-	Autofind problems and autofix them
	update		-	Update the computer software, apt apps and flatpak apps
	lms update	-	Update the lms to the newest version
	done		-	CLose the WeThinkCode_ bot"

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
update_software()
{
	declare -g PASSWD
	check_if_can_sudo
	if [ $? -eq 0 ]
	then
		echo "Checking apt repos for updates..."
		echo "$PASSWD" | sudo -S apt-get update >> stuff.txt && echo "Applying any updates we found" 
		sudo apt-get upgrade -y >> update.txt
		echo "Checking for any erros while update"
		check_errors_held_back
		echo "Checking for any flatpak updates..."
		flatpak update -y >> flatpak.txt
		autoremove
		rm stuff.txt
	fi
}


check_errors_held_back()
{
	HELD_BACK=$(grep "The following packages have been held back update.txt")
	if [ ${HELD_BACK}='']
	then
		continue
	else
		echo "I've found packages that need reinstalling, reinstalling them..." 
		temporay_variable_for_line=$(grep -A 1 "The following packages have been held back" update.txt)
		temporary_sed_var=$(sed '2p;d' $temporary_variable_for_line) 
		sudo apt install --reinstall $temporary_sed_var 
		 #need to read from text file, its only one line, or use variable
		
		
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
