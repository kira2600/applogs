#!/bin/bash
# ------------------------------------------------------------------
# [Andrei Kirushchanka] Title
#          Archiving paternt logs
# ------------------------------------------------------------------

LOGS='/usr/local/var/log'
PASS='/root'
GREP_PATTERN=$1
mkdir $PASS/grep_logs

for file in $LOGS/*
   do
    base_file_name=$(basename $file)
    grep -r $GREP_PATTERN $file > $PASS/grep_logs/$base_file_name
   done


cd $PASS
tar -C $PASS -zcf grep_logs.tar.gz grep_logs
rm -rf $PASS/grep_logs
