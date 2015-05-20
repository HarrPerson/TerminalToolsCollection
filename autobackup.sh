#!/bin/bash
timestmp=`/bin/date +%Y-%m-%d_%H%M`
bkprootdir="."
snapdir="snap"
bkpname="bkpexample"
srcdir="/srcexample"

/usr/bin/rsync -a --delete --progress --exclude-from $srcdir/rsyncexcludes.txt --log-file ./logs/log_$timestmp.txt $srcdir $bkprootdir/$bkpname/
if [ "$?" -eq "0" ]; then
	/sbin/btrfs subvolume snapshot -r $bkprootdir/$bkpname $bkprootdir/$snapdir/$bkpname.$timestmp
	if [ "$?" -eq "0" ]; then
		echo -e "\n\nBackup successfully finished.\n"
		exit 0
	else
		echo -e "\n  -> Error while running btrfs\n\n"
		exit 2
	fi
else
	echo -e "\n  -> Error while running rsync\n\n"
	exit 1
fi
exit 3
