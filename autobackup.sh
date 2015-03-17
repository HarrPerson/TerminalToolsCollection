#!/bin/bash
timestmp=`/bin/date +%Y-%m-%d_%H%M`
bkproot="/backups"
snapdir="snaps"
bkpname="together"

/usr/bin/rsync -a --delete --progress /media/together/ /backups/$bkpname/
/sbin/btrfs su sn -r $bkproot/$bkpname $bkproot/$snapdir/$bkpname.$timestmp
