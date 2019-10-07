#!/bin/sh

#/jp1/jp1api.sh "${EVID}" "${EVHOST}" "${EVMSG}" "${EVDATE}" "${EVTIME}"

mes=`echo "$3" | sed -e 's/\"/\\\"/g'`

echo "curl -X POST http://xxx.xxx.xxx.xxx:8080/job/JP1JOB/job/JP1TEST01/build --user jenkins:0a9d4c4529624478e1bd166cb669a3e1 --form json='{\"parameter\": [{\"name\":\"JP1EVENTID\", \"value\":\""$1"\"}, {\"name\":\"JP1EVENTHOST\", \"value\":\"""$2""\"}, {\"name\":\"JP1EVENTMESSAGE\", \"value\":\"""$mes""\"}, {\"name\":\"JP1EVENTDATE\", \"value\":\"""$4""\"}, {\"name\":\"JP1EVENTTIME\", \"value\":\"""$5""\"}]}'" > /jp1/curl.txt

source /jp1/curl.txt
