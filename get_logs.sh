#!/bin/bash
# ------------------------------------------------------------------
#          Archiving logs
# ------------------------------------------------------------------

CONTANIER_ID=$1
NUM_OF_LAST_LINES=$2
GREP_PATTERN=$3
LOCATION=$(dirname "$0")
PWD=$(pwd)
LOGS_PATH='/usr/local/var/log'


if [ $# == 0 ] ; then
    echo 'Please set container ID'
    exit 1;
fi


if [ -z "$2" ] ; then
    NUM_OF_LAST_LINES=200
fi


if [[ $2 == "grep" ]] ; then
    
    if [ -z "$3" ] ; then
        echo 'Please write pattern'
        exit 1;
    fi

    sample_string="base_file_name=\$(basename \$file)
    grep -r \"$GREP_PATTERN\" \$file > \$TMP_PATH/grep_logs/\$base_file_name"
    name='grep_logs'
    
else

    sample_string="base_file_name=\$(basename \$file)
    tail -n $NUM_OF_LAST_LINES \$file > \$TMP_PATH/last_logs/\$base_file_name"
    name='last_logs'

fi


echo "#!/bin/bash

TMP_PATH='/root'
mkdir \$TMP_PATH/$name

for file in $LOGS_PATH/*
   do
   $sample_string
   done

cd \$TMP_PATH
tar -C \$TMP_PATH -zcf $name.tar.gz $name
rm -rf \$TMP_PATH/$name" > $LOCATION/$name.sh

chmod 775 $LOCATION/$name.sh

docker cp $LOCATION/$name.sh $CONTANIER_ID:/root/ && \
docker exec -it $CONTANIER_ID bash -c "/root/$name.sh" && \
docker cp $CONTANIER_ID:/root/$name.tar.gz $PWD/ && \
docker exec -it $CONTANIER_ID bash -c "rm /root/$name*"

rm $LOCATION/$name.sh
