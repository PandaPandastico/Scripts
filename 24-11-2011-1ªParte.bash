#!/bin/bash
if [[ "$#" < 1 ]]; then
	IFS=','
	aux=(`grep "^users:" /etc/group | awk 'BEGIN {FS=":"}{print $4}'`)
	set -- ${aux[@]}
fi
users=($@)
unset IFS
for index in "${!users[@]}"	
do
	gui=`awk -v user=${users[index]} 'BEGIN {FS=":"} $1==user{print $4}' /etc/passwd`
	name=`awk -v user=${users[index]} 'BEGIN {FS=":"} $1==user{print $5}' /etc/passwd`
	primarygroup=`awk -v gid=$gui 'BEGIN {FS=":"} $3==gid{print $1}' /etc/group`
	username=${users[index]}".backup"
	adduser --ingroup $primarygroup --disabled-password --gecos $name --force-badname $username 
	addgroup backup
	adduser $username backup
	cp -r /home/${users[index]}/* /home/$username
	chown -R $username /home/$username
	usermod -L ${users[index]}
done
