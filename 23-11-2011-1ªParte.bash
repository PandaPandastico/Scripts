#!/bin/bash
if [[ "$#" < 1 ]]; then
	aux=(`awk 'BEGIN {FS=":"}$3>499{print $1}' /etc/passwd`)
	set -- ${aux[@]}
fi
users=($@)
for index in "${!users[@]}"	
do
	groups=`awk -v user=${users[index]} 'BEGIN {FS=":"}$4==user{print $1}' /etc/group`
	uid=`awk -v user=${users[index]} 'BEGIN {FS=":"}$1==user{print $3}' /etc/passwd`
	gui=`awk -v user=${users[index]} 'BEGIN {FS=":"}$1==user{print $4}' /etc/passwd`
	primarygroup=`awk -v gid=$gui 'BEGIN {FS=":"}$3==gid{print $1}' /etc/group`
	echo ${users[index]} "("$uid"):" $primarygroup $groups
done
