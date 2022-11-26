echo "The following packages have been held back: 
    gnome-shell-utils gnome-stuff-morestuff utils-support
10 upgraded" | sed '2p;d'

echo "Reading package lists... Done
Building dependency tree
Reading state information... Done
Calculating upgrade... Done
The following packages have been held back: 
    gnome-shell-utils gnome-stuff-morestuff utils-support
10 upgraded" | grep "The following" | sed 's/^.*:\n//'