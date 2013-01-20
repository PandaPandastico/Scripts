#!/bin/bash
if [[ "$#" < 1 ]]; then
	aux=(`grep "^users:" /etc/group | awk 'BEGIN {FS=":"}{print $4}'`)
	set --$aux
	IFS=','
fi
users=($@)
unset IFS

for index in "${!user[@]}"	
do
	GUI=`awk "BEGIN {FS=":"} $1 == ${users[$index]}{print \$4}" /etc/passwd`
	adduser --ingroup GUI $1.backup
	BACKGROUP=cat /etc/group | awk '{FS=":"}{print $1}' | grep -c backup
	if [[ $BACKGROUP < 1 ]]; then
		addgroup backup
	fi
	adduser $1 backup
done
fi
