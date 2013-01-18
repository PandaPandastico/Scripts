if [[ "$#" < 0 ]]; then
	echo "No ha pasado un nombre de usuario válido"
else
	GUI=`awk '{FS=":"} $1 == "pandastico" {print $4}' /etc/passwd`
	adduser --ingroup "$GUI $1.backup"
 
	adduser 	if [[ cat /etc/group | awk '{FS=":"}{print $1}' | grep -c backup < 1 ]]; then
		addgroup backup
	fi
	adduser "$1 backup"
fi
