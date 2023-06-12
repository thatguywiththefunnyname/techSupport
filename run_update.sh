#!/usr/bin/bash

git clone https://github.com/thatguywiththefunnyname/techSupport.git

chmod +x techSupport/update.sh

read -p "Enter your password:" PASSWD

echo "$PASSWD" | sudo -S mv techSupport/update_bot.sh /usr/local/bin

update_bot.sh

rm -rf techSupport
