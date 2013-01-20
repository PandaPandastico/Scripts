#!/bin/bash
if [[ "$#" < 1 ]]; then
	aux=(grep "^users:" /etc/group | awk '{FS=":"}{print $4}'
	

while [[ "$#" > "0" ]]
do
	GUI=`awk '{FS=":"} $ == "$1" {print $4}' /etc/passwd`
	adduser --ingroup GUI $1.backup
	BACKGROUP=cat /etc/group | awk '{FS=":"}{print $1}' | grep -c backup
	if [[ $BACKGROUP < 1 ]]; then
		addgroup backup
	fi
	adduser $1 backup
done
fi
