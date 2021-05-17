#!/bin/bash
#
#	backup.sh:			Script for creating backup of the user's /home. 	
#	Autor:					Yan B.S.Penalva <yanpenabr@gmail.com>
#	Site:						www.libresec.me
#	Maintenance: 		Yan Brasiliano Silva Penalva <yanpenabr@gmail.com>
#
#----------------------------------------------------------------------
#
#	Example of use:
#		$ ./backup.sh
#	
#----------------------------------------------------------------------
#	Historic:	
#
#	v1.0 2021.05.16, Yan Brasiliano:
#	- 	Initial version of the program, inserting functions and header. 
#
#	----------------------------------------------------------------------

#Checks whether the /home/user/backup directory exists, if not, create the directory. 
clear
DIR=$HOME/backup
if ! test -d $DIR 
then
	echo "Creating directory..."
	sleep 1
	mkdir -p $DIR
else
	echo "Directory already exists!"
fi

#Checks if there are any files created backup between 7 days of the current date. TIP WITHDRAWAL FROM THE COURSE! 

DAY=$(find $DIR -ctime -7 -name backup_name\*tgz)

if [ "$DAY" ] # Testing if the variable is null - Pay attention to double quotation marks, essential in this process for identification. 
then
	echo "There is already a backup of the $HOME directory in the last 7 days."
	echo -n "Continue? [Y/N]"
	read -n1 	OPT
	echo
	if [ $OPT = N -o $OPT = n -o $OPT = "" ]
	then
		echo "Backup aborted"
		exit 1
	elif [ $OPT = Y -o $OPT = y ] 
	then
		echo "Creating new backup..."
		sleep 2
	else
		echo "Option not recognized."
		exit 2
	fi
fi
SIZE=$(du -sh /home/owl | cut -c1-4)
echo "Creating new backup..."
sleep 2
echo "Wait for the backup to finish..."
sleep 2
echo "Total size $HOME --> $SIZE"
BKP="backup_home_$HOME_$(date +%Y%m%d%H%M0.gzip)"
tar czvf $DIR/$BKP --absolute-names --exclude="$DIR" "$HOME"/* > /dev/null
echo
echo "Backup created. /// Name:$BKP /// Diretory: $DIR"
echo
echo "Backup completed."