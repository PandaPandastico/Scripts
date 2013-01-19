#!/bin/bash
users=(awk '{FS=":"}{499 > $3}{print $1":"$5":"$3}' /etc/passwd)

