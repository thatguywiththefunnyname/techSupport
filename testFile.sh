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
'    "dpkg: error processing package [package-name] (--configure): [error-message]"
    Example: dpkg: error processing package mysql-server-5.7 (--configure): subprocess installed post-installation script returned error exit status 1

    "dpkg: warning: files list file for package [package-name] missing; assuming package has no files currently installed"
    Example: dpkg: warning: files list file for package mysql-server-core-5.7 missing; assuming package has no files currently installed

    "dpkg: error: dpkg frontend is locked by another process"
    Example: dpkg: error: dpkg frontend is locked by another process

    "E: [error-message]"
    Example: E: Unable to locate package nginx

    "dpkg: dependency problems prevent configuration of [package-name]: [dependency-message]"
    Example: dpkg: dependency problems prevent configuration of mysql-server-5.7: mysql-server-5.7 depends on mysql-server-core-5.7 (= 5.7.38-0ubuntu0.18.04.1); however: Version of mysql-server-core-5.7 on system is 5.7.38-0ubuntu0.18.04.2.'
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
