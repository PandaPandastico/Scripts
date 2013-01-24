#!/bin/bash
shadowusers=(`awk 'BEGIN{FS=":"}{print $1}' /etc/shadow`)
passwdusers=(`awk 'BEGIN{FS=":"}{print $1}' /etc/passwd`)

for user in "${shadowusers[@]}"
do
	count="0"
	count=(`awk -v u=${user[2]} -v c=$count 'BEGIN{FS=":"}$1==u{print ++c}' /etc/passwd`)
	if [[ $count == "0" ]]; then
		echo $user no esta en /etc/passwd
	elif [[ $count > "1" ]]; then
		echo $user esta duplicado en /etc/passwd
	fi

done
for user in "${passwdusers[@]}"
do
	count="0"
	count=(`awk -v u=${user[2]} -v c=$count 'BEGIN{FS=":"}$1==u{print ++c}' /etc/shadow`)
	if [[ $count == "0" ]]; then
		echo $user no esta en /etc/shadow
	elif [[ $count > "1" ]]; then
		echo $user esta duplicado en /etc/shadow
	fi
done
