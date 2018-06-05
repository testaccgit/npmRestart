#!/bin/bash
#----------------------------------------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------------------------------------
# [Script Name]: npmRestart.sh
# [Script Location]: /home/borisb/npmRestart
# [Author]: Boris Boskovic
# [Date]: 25.1.2018
#----------------------------------------------------------------------------------------------------------------------
# >>|Description: Restart nodeJS from screen
#
# >>|Run Information: This script is run crontab.
#
# >>|Standard Output: Any output is sent to a file called /home/borisb/npmRestart/log/npmRestart.log
#
#----------------------------------------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------------------------------------

IP=`ip route get 1 | awk '{print $NF;exit}'`
TT=$(date +'%d-%m-%Y|%H:%M:%S')


# screen npm start
echo "-----$TT------" >> neo4j-npm-$IP.log
echo "NPM_PORT_|_PID - `netstat -tupln | grep node | grep -v grep | awk '{print $4,"|",$7}'`" >> neo4j-npm-$IP.log
echo "NPM_PID - `netstat -tupln | grep 3000 | grep -v grep | awk '{print $4}'`" >> neo4j-npm-$IP.log
echo "SCREEN_PID - `ps -ef | grep SCREEN | grep -v grep | awk '{print $2}'`" >> neo4j-npm-$IP.log
ps -ef | grep SCREEN | grep -v grep | awk '{print $2}' | xargs kill
lsof -n -i:3000 | grep LISTEN | awk '{ print $2 }' | xargs kill -9


su - npm << EOF
cd dana
screen -d -m && npm start >> log
EOF

su - root
whoami
exit 0
