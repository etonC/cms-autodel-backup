#!/bin/bash
array[0]='cms'
array[1]='db'
RELEASE="/data/backup/"

backup="/tmp/frontend-cms-backup/"
cd $backup
if [ $? -eq 0 ];
then
 rm -rf *
else
    echo "No found /tmp/frontend-cms-backup/ directory will be created automatically!"	
    mkdir /tmp/frontend-cms-backup/
fi


for path in ${array[@]};
do
    releasepath=${RELEASE}${path}
    cd $releasepath
    if [ $? -eq 0 ];
    then
	file=`ls -ltr`;
	num=`ls -l | grep '^-' | wc -l`;
        echo "Check Path:"$releasepath
	echo "Total file:"$num" (The latest 14 files will be kept)"
        echo "Contains file:"
        echo "$(ls -lhtr)"
        #num=`ls -l | grep '^-' | wc -l`;
	#echo "No files will be deleted!"
	echo ""
        if [ $num -gt 14 ];
        then
            num=`expr $num - 14`
            clean=`ls -tr | head -$num | xargs`
            echo "The following old files will be moved to /tmp/frontend-cms-backup/ temporarily, and will be cleared when db flip is run again next time."
            echo ${clean}
            echo ""
            ls -tr | head -$num | xargs -i -n1 mv  {} $backup
	else
	    echo "No files will be deleted!"
            echo ""
        fi
    fi
done
