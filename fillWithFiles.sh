#!/bin/bash
optdir=$1
cycles=$2
size=$3
type=$4
source="/dev/zero"
otpname="fill-dd-"
otpext=bin
i=0

if [ -z "$4" ]
  then
	echo "You need four Arguments. Folder, cylcles, size and type(zero/urnd)."
	echo "Example: $0 /tmp 50 5 urnd"
	echo "Fills /tmp with 50 files each 5MB and urandom data."
	exit 1
fi

if [  ! -d $optdir ] ; then
	echo "Folder $optdir does not exist."
	exit 1
fi

if [ $type == "urnd" ]
then
	source="/dev/urandom"
elif [ $type == "zero" ]
then
	source="/dev/zero"
else
	echo "Wrong type. Use urnd/zero"
	exit 1
fi

counter=0
while [  $counter -lt $cycles ]; do
	let counter=counter+1 
	if [[ -e $optdir/$otpname$i.$type.$otpext ]] ; then
		i=0
		while [[ -e $optdir/$otpname$i.$type.$otpext ]] ; do
			let i++
		done
	fi
	fullfilename=$optdir/$otpname$i.$type.$otpext
	clear
	echo "Write $counter/$cycles to $fullfilename"
	dd if=$source of=$fullfilename bs=1M count=$size
done
exit 0
