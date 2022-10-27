#!/usr/bin/bash

CAN_I_SUDO=$(sudo -n uptime 2>&1 | grep "load" | wc -l)
if [ ${CAN_I_SUDO} -gt 0 ]
then
	echo "Checking apt repos for updates..."
	sudo apt update >> stuff.txt &&
	sudo apt upgrade -y >> update.txt
	echo "Checking for any flatpak updates..."
	flatpak update -y >> flatpak.txt
else
	read -p "Please enter your password: " PASSWD
	echo "Checking apt repos for updates..."
	echo "$PASSWD" | sudo -S apt update >> stuff.txt && echo "Applying any updates we found" 
	sudo apt upgrade -y >> update.txt
	echo "Checking for any flatpak updates..."
	flatpak update -y >> flatpak.txt
	rm stuff.txt
fi

FIND=$(grep autoremove update.txt)
if [ ${FIND}='' ]
then
	rm update.txt
	echo "Checking if anything needs removing..."
	sudo apt autoclean >> clean.txt && sleep 3 && sudo apt clean
	rm clean.txt
	echo "Update Complete :)"
else
	echo "Just Cleaning some unnecessary files :) "
	sudo apt autoremove -y;sudo apt autoclean;rm update.txt
	echo "All done now! HAve a productive day :D"
fi

