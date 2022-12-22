# echo "The following packages have been held back: 
#     gnome-shell-utils gnome-stuff-morestuff utils-support
# 10 upgraded" | sed '2p;d'


echo "Reading package lists... Done
Building dependency tree
Reading state information... Done
Calculating upgrade... Done
The following packages have been held back: 
    gnome-shell-utils gnome-stuff-morestuff utils-support
10 upgraded" | grep -A 1 "The following" 

# echo "Reading package lists... Done
# Building dependency tree
# Reading state information... Done
# Calculating upgrade... Done
# The following packages have been held back: 
#     gnome-shell-utils gnome-stuff-morestuff utils-support
# 10 upgraded" | grep "The following" | sed 's/^.*:\n//'

# check_if_can_sudo(){
# 	declare -g PASSWD
# 	# CAN_SUDO=$(sudo -n uptime 2>&1 | grep "load" | wc -l)
# 	sudo -v
# 	if [ $? -ne 0 ]
# 	then
# 		while true;do
# 			read -sp '[sudo] please enter password for sudo access: ' passwd
# 			PASSWD=$passwd
# 			sudo -S -v <<< $PASSWD
# 			if [ $? -ne 0 ]
# 			then
# 				echo "Incorrect password! Please try again."
# 			else
# 				return 0
# 			fi
# 		done
# 	else
# 		return 0
# 	fi
# }
