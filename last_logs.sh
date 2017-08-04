#!/bin/bash
# ------------------------------------------------------------------
# [Andrei Kirushchanka] Title
#          Archiving last logs
# ------------------------------------------------------------------

#DATE=`date +%Y-%m-%d_%H_%M_%S`
LOGS='/usr/local/var/log'
PASS='/root'
NUM_OF_LAST_LINES=$1
mkdir $PASS/last_logs

if [ $# == 0 ] ; then
   NUM_OF_LAST_LINES=200
fi


for file in $LOGS/*
   do
    base_file_name=$(basename $file)
    tail -n $NUM_OF_LAST_LINES $file > $PASS/last_logs/$base_file_name
   done


cd $PASS
tar -C $PASS -zcf last_logs.tar.gz last_logs
rm -rf $PASS/last_logs
