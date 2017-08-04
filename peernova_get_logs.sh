#!/bin/bash
# ------------------------------------------------------------------
# [Andrei Kirushchanka] Title
#          Archiving last logs
# ------------------------------------------------------------------

CONTANIER_ID=$1
NUM_OF_LAST_LINES=$2
GREP_PATTERN=$3
PASS='/usr/local/etc/get_last_logs'


if [ $# == 0 ] ; then
    echo 'Please set name of container'
    exit 1;
fi

if [[ $2 == "grep" ]] ; then
    
    if [ -z "$3" ] ; then
        echo 'Please write pattern'
        exit 1;
    fi
    
    docker cp $PASS/grep_logs.sh $CONTANIER_ID:/root/
    docker exec -it $CONTANIER_ID bash -c "/root/grep_logs.sh $GREP_PATTERN"
    sleep 1s
    docker cp $CONTANIER_ID:/root/grep_logs.tar.gz $PASS/
    docker exec -it $CONTANIER_ID bash -c "rm /root/grep_logs*"

else

    docker cp $PASS/last_logs.sh $CONTANIER_ID:/root/
    docker exec -it $CONTANIER_ID bash -c "/root/last_logs.sh $NUM_OF_LAST_LINES"
    sleep 2s
    docker cp $CONTANIER_ID:/root/last_logs.tar.gz $PASS/
    docker exec -it $CONTANIER_ID bash -c "rm /root/last_logs*"

fi

