#!/usr/bin/bash

git clone https://github.com/thatguywiththefunnyname/techSupport.git

chmod +x techSupport/update.sh

read -p "Enter your password:" PASSWD

echo "$PASSWD" | sudo -S mv techSupport/WeThinkCode_Bot.sh /usr/local/bin

WeThinkCode_Bot.sh

rm -rf techSupport
