#!/usr/bin/bash

echo "Welcome to the WeThinkCode_ bot"

run_script()
{
	while true
	do
		read -p "What would you like to do? " COMMAND
		if [[ $COMMAND == 'done' ]]
		then	
			break
		elif [[ $COMMAND == 'help' ]]
		then
			help_command
		elif [[ $COMMAND == 'update' ]] 
		then
			update_software
		elif [[ $COMMAND == 'lms update' ]]
		then
			update_lms
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
	update		-	Update the computer software, apt apps and flatpak apps
	lms update	-	Update the lms to the newest version
	done		-	CLose the WeThinkCode_ bot"
}
update_software()
{
	CAN_I_SUDO=$(sudo -n uptime 2>&1 | grep "load" | wc -l)
	if [ ${CAN_I_SUDO} -gt 0 ]
	then
		echo "Checking apt repos for updates..."
		sudo apt-get update >> stuff.txt &&
		sudo apt-get upgrade -y >> update.txt
		echo "Checking for any flatpak updates..."
		flatpak update -y >> flatpak.txt
		autoremove
	else
		read -p "Please enter your password: " PASSWD
		echo "Checking apt repos for updates..."
		echo "$PASSWD" | sudo -S apt-get update >> stuff.txt && echo "Applying any updates we found" 
		sudo apt-get upgrade -y >> update.txt
		# echo "Checking for any erros while update"
		echo "Checking for any flatpak updates..."
		flatpak update -y >> flatpak.txt
		autoremove
		rm stuff.txt
	fi
}
update_lms(){
	CAN_I_SUDO=$(sudo -n uptime 2>&1 | grep "load" | wc -l)
	if [ ${CAN_I_SUDO} -gt 0 ]
	then
		echo "Please ensure that lms is in the Downloads folder"
		echo "Please also make sure theres only one version in the folder"
		chmod +x ~/Downloads/wtc-lms
		echo "Placing the LMS in the /usr/local/bin"
		sudo mv ~/Downloads/wtc-lms /usr/local/bin
		echo "removing lms from /usr/.local/bin"
		sudo rm /usr/.local/bin/wtc-lms
		wtc-lms -V
	else
		read -p "Please enter your password: " PASSWD
		chmod +x wtc-lms
		echo "$PASSWD" | sudo -S mv ~/Downloads/wtc-lms 
		wtc-lms -V
	fi
}
# check_errors()
# {
# 	HELD_BACK=$(grep "The following packages have been held back")
# 	if [ ${HELD_BACK}='']
# 	then
# 	else
		
# 	fi
# }

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