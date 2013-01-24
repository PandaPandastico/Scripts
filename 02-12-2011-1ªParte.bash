#!/bin/bash
directories=(`ls $1 -l | egrep '^d' | awk 'BEGIN {FS=" "}{print $9}'`)
echo ${directories[@]}
files=(`ls $1 -lt | egrep -v '^d' | tail -n+9 | awk 'BEGIN {FS=" "}{print $9}'`)
echo ${files[@]}
for file in "${files[@]}"
do
	rm -f $1/$file
done

for index in "${!directories[@]}"
do
	./"02-12-2011-1ªParte.bash" $1/${directories[index]}
done
#/etc/crontab must has this schedule lines without comments
# 00 03 01 * 0 (ls /var/log | cpio –oB > /mnt/backups/varlog.full.$(date +"%Y%m"))&&(rm -rf /var/log/*)
# 15 05 1-7 * 6 (find /var/log -mtime -7 –type f | cpio –oB > /mnt/backup/varlog.diff.01)&&(./ruta/script /var/log)
# 15 05 8-14 * 6 (find /var/log -mtime -7 –type f | cpio –oB > /mnt/backup/varlog.diff.02)&&(./ruta/script /var/log)
# 15 05 15-21 * 6 (find /var/log -mtime -7 –type f | cpio –oB > /mnt/backup/varlog.diff.03)&&(./ruta/script /var/log)
# 15 05 22-28 * 6 (find /var/log -mtime -7 –type f | cpio –oB > /mnt/backup/varlog.diff.04)&&(./ruta/script /var/log)
# 15 05 29-31 * 6 (find /var/log -mtime -7 –type f | cpio –oB > /mnt/backup/varlog.diff.05)&&(./ruta/script /var/log)
