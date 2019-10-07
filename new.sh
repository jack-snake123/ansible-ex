#!/bin/sh

#jp1自動アクションコマンド
#/jp1/jp1api.sh "${EVID}" "${EVHOST}" "${EVMSG}" "${EVDATE}" "${EVTIME}"

#JP1メッセージ"エスケープ処理
mes=`echo "$3" | sed -e 's/\"/\\\"/g'`

#APIコマンド生成
echo "curl -X POST http://xxx.xxx.xxx.xxx:8080/job/JP1JOB/job/JP1TEST01/build --user jenkins:0a9d4c4529624478e1bd166cb669a3e1 --form json='{\"parameter\": [{
\"name\":\"JP1EVENTID\", \"value\":\""$1"\"}, {\"name\":\"JP1EVENTHOST\", \"value\":\"""$2""\"}, {\"name\":\"JP1EVENTMESSAGE\", \"value\":\"""$mes""\"}, {\"n
ame\":\"JP1EVENTDATE\", \"value\":\"""$4""\"}, {\"name\":\"JP1EVENTTIME\", \"value\":\"""$5""\"}]}'" > /jp1/curl.txt

#APIコマンド実行
source /jp1/curl.txt
