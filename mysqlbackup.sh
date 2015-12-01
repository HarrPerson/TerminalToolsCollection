#!/bin/bash

### Global Constants
TIMESTAMP=`date +%Y-%m-%d_%H%M`
BACKUPDIR="/backups"
BACKUPFILE="$BACKUPDIR/mysql-$TIMESTAMP"

MYSQL="$(which mysql)"
MYSQLDUMP="$(which mysqldump)"
ZIPBIN="$(which 7z)"

MUSER="root"
MPASS="password"
MHOST="localhost"

echo "BACKUP DB TO $BACKUPFILE"


DBS="$($MYSQL -u$MUSER -h$MHOST -p$MPASS -Bse 'show databases')"
for db in $DBS
do
	FILENAME=$BACKUPFILE-$db.sql
	echo "---------------------------------------------------"
	echo "SQLDUMP to $FILENAME"
	$MYSQLDUMP --ignore-table=mysql.event --skip-lock-tables --user=$MUSER --password=$MPASS --host=$MHOST $db > $FILENAME
	echo "ZIP FILE"
	$ZIPBIN a $FILENAME.7z $FILENAME
	rm -f $FILENAME
	echo "---------------------------------------------------"
done
echo "FINISHED"

