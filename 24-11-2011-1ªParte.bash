#!/bin/bash
if [[ "$#" < 1 ]]; then
	echo "No ha pasado un nombre de usuario válido"
else
	GUI=`awk '{FS=":"} $1 == "$1" {print $4}' /etc/passwd`
	adduser --ingroup GUI $1.backup
	adduser $1 backup
	BACKGROUP=cat /etc/group | awk '{FS=":"}{print $1}' | grep -c backup
 	if [[ $BACKGROUP < 1 ]]; then
		addgroup backup
	fi
	adduser $1 backup
fi
