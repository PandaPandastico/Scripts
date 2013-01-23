parameters=($@)
sizefile=1
users=()
for index in ${!parameters[@]}
do	
	if [[ "${parameters[$index]}" =~ ^[a-z][-a-z0-9]+$ ]]; then
		users[$index]=`awk -v user=${parameters[$index]} 'BEGIN{FS=":"}$1==user{print $1}' /etc/passwd`
	elif [[ "${parameters[$index]}" =~ ^[0-9]+$ ]]; then
		users[$index]=`awk -v user=${parameters[$index]} 'BEGIN{FS=":"}$3==user{print $1}' /etc/passwd`
	elif [[ "${parameters[$index]}" == "-k" ]]; then
		sizefile=1024
	elif [[ "${parameters[$index]}" == "-m" ]]; then
		sizefile=1048576
	fi
done

for index in ${!users[@]}	
do
	userhome=`awk -v user=${users[index]} 'BEGIN{FS=":"}$1==user{print $6}' /etc/passwd`

	jpgsize=`find $userhome -iname '*.jpg' -print0 | xargs -0 du -c -b | tail -n 1 | awk 'BEGIN{FS=" "}{print $1}'`
	testing=(`find $userhome -iname '*.jpg'`)
	if [[ ${#testing[@]} < 1 ]]; then
		jpgsize=0
	fi
	echo $jpgsize

	jpegsize=`find $userhome -iname '*.jpeg' -print0 | xargs -0 du -c -b | tail -n 1 | awk 'BEGIN{FS=" "}{print $1}'`
	testing=(`find $userhome -iname '*.jpeg'`)
	if [[ ${#testing[@]} < 1 ]]; then
		jpegsize=0
	fi
	echo $jpegsize

	bmpsize=`find $userhome -iname '*.bmp' -print0 | xargs -0 du -c -b | tail -n 1 | awk 'BEGIN{FS=" "}{print $1}'`
	testing=(`find $userhome -iname '*.bmp'`)
	if [[ ${#testing[@]} < 1 ]]; then
		bmpsize=0
	fi
	echo $bmpsize

	pngsize=`find $userhome -iname '*.png' -print0 | xargs -0 du -c -b | tail -n 1 | awk 'BEGIN{FS=" "}{print $1}'`
	testing=(`find $userhome -iname '*.png'`)
	if [[ ${#testing[@]} < 1 ]]; then
		pngsize=0
	fi

	echo $pngsize
	gifsize=`find $userhome -iname '*.gif' -print0 | xargs -0 du -c -b | tail -n 1 | awk 'BEGIN{FS=" "}{print $1}'`
	testing=(`find $userhome -iname '*.git'`)
	if [[ ${#testing[@]} < 1 ]]; then
		gifsize=0
	fi
	echo $gifsize
	
	total=`expr $jpgsize + $jpegsize + $bmpsize + $gifsize + $pngsize`
	total=`awk -v t=$total -v s=$sizefile 'BEGIN {print t / s}'`
	echo ${users[index]} $total
done
