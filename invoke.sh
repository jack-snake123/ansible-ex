#=================================================================================#
#
#	   架電実行スクリプト
#
#=================================================================================#
#!/bin/bash

source `dirname $0`/init.sh 
api="api/apps/pigeon/chain/invoke"
url="${kc_url}/api/apps/pigeon/chain/invoke"

#-----------------------------------------
# - 内部定数。通常は編集しない
#-----------------------------------------
#架電命令実行後待ち時間
waitsec=0.1

#架電実行フラグ(1:ON 0:OFF)
#OFFの時は実際にはAPI発行を行わない
invoke=1

#-----------------------------------------
# - 引数確認
#-----------------------------------------
if [ $# -ne 1 ] ; then
	OutError "引数の数が不正です。中間ファイルのBUILD_NUMBERを指定してください。"
	exit 1
fi

build_number=$1
OutInfo "処理を開始します。(BUILD_NUMBER:${build_number})"

#-----------------------------------------
# - 中間ファイルの存在確認
#-----------------------------------------
#中間ファイルのBUILD_NUMBERを置換したのち存在確認
datafile=`echo ${datafile} | sed -e "s/@BUILD_NUMBER@/${build_number}/g"`

if [ ! -f ${datafile} ]; then
	OutError "中間ファイル '${datafile}' が見つかりません。"
	exit 1
fi
OutInfo "中間ファイル '${datafile}' を発見しました。"

#-----------------------------------------
# - プッシュボタンの挙動取得
#-----------------------------------------
pushaction=`GetPushAction ${pushactionlist}`
if [ $? -ne 0 ]; then
	OutError "${pushaction}"
	exit 1
fi
eval "${pushaction}"
OutInfo "プッシュボタン定義を取得しました。"
OutDebug "pushaction: `declare -p pushaction | sed -e \"s/.*'(\(.*\))'.*/\1/g\"`"

#-----------------------------------------
# - 平日/休日/祝祭日/時間の判別
#-----------------------------------------
msg=`GetContactZone \`date +"%T"\` ${worktime} ${holidaylist}`
contactzone=$?
contactary=("営業時間内" "時間外")
if [ ${contactzone} -eq 255 ]; then
	contactzone=1
	OutWarning "${msg}"
else
	OutDebug "${msg}"
fi
OutInfo "時間判定を行いました。(${contactary[${contactzone}]})"

#-----------------------------------------
# - 中間ファイル読み込み処理
#-----------------------------------------
OutInfo "中間ファイル '${datafile}' の読み込みを開始します。"
lineno=0
while read line 
do
	((lineno++))
	#-----------------------------------------
	# - スキップ対象となる行
	#-----------------------------------------
	#コメント行
	echo "${line}" | egrep "^#" > /dev/null 2>/dev/null && continue
	#空行
	if [ "`echo ${line} | sed -e \"s/ //g\" | sed -e \"s/\t//g\"`" == "" ] ; then
		continue
	fi 

	#-----------------------------------------
	# - 読み込んだ行からパラメータ抽出+@
	#-----------------------------------------
	contactcode=`echo ${line} | awk {'print $1'}`
	eventcode=`echo ${line} | awk {'print $2'}`
	callflag=`echo ${line} | awk {'print $3'}`
	eventdate=`echo ${line} | awk {'print $4'}`
	eventtime=`echo ${line} | awk {'print $5'}`
	eventhost=`echo ${line} | awk {'print $6'}`
	eventsystem=`echo ${line} | awk {'print $7'}`
	eventmsg=`echo ${line} | cut -d ' ' -f 8-`

	linesummary="(BN:${build_number}-${lineno}行目) "
	alertsummary="${contactcode} / ${eventcode} / ${callflag} / ${eventdate} / ${eventhost} / ${eventsystem} / ${eventmsg:0:30}..."

	#-----------------------------------------
	# - 架電フラグ判定
	#-----------------------------------------
	if [ "${callflag}" != "1" ] ; then 
		OutDebug "${linesummary}報告対象外アラート(${alertsummary})"
		continue
	fi
	OutInfo "${linesummary}報告対象のアラートを発見しました。(${alertsummary})"

	#-----------------------------------------
	# - コールフローID取得
	#-----------------------------------------
	callflowid=`GetCallFlowId ${callflowlist} ${contactcode} ${contactzone}`
	if [ $? -ne 0 ] ; then 
		OutWarning "${linesummary}${callflowid}"
		continue
	fi
	OutInfo "${linesummary}連絡先コード ${eventcode} の${contactary[${contactzone}]}連絡先を取得しました。"
	OutDebug "${linesummary}callflowid: ${callflowid}"

	#-----------------------------------------
	# - アラートパターン取得
	#-----------------------------------------
	pattern=`GetAlertPattern ${alertpatternlist} ${eventcode}`
	if [ $? -ne 0 ] ; then 
		OutWarning "${linesummary}${pattern}"
		continue
	fi
	eval ${pattern}
	OutInfo "${linesummary}イベント種別 ${eventcode} の定義情報を取得しました。"
	OutDebug "${linesummary}pattern: `declare -p pattern | sed -e \"s/.*'(\(.*\))'.*/\1/g\"`"

	#-----------------------------------------
	# - パラメータ抽出＋α
	#-----------------------------------------
	#パラメータの抽出。アラートパターンに定義されたスクリプトの実行
	params=`${pattern['script']} "${eventmsg}" 2>&1`
	if [ $? -ne 0 ] ; then 
		OutWarning "${linesummary}パラメータ抽出スクリプトの実行に失敗しました。(${params})"
		continue
	fi
	eval ${params}

	#抽出したパラメータにhost と datetime が無い場合にはそれぞれ追加
	if [ "${params['datetime']}" == "" ]; then params['datetime']="${eventdate} ${eventtime}" ; fi
	if [ "${params['host']}" == "" ]; then params['host']="${eventhost}" ; fi
	if [ "${params['system']}" == "" ]; then params['system']="${eventsystem}" ; fi

	#イベントコードを追加
	params['eventcode']="${eventcode}"

	OutInfo "${linesummary}パラメータの抽出/整形を行いました。"
	OutDebug "${linesummary}params: `declare -p params | sed -e \"s/.*'(\(.*\))'.*/\1/g\"`"

	#-----------------------------------------
	# - イベント/ホストのアラートアクション取得
	#   及びガイダンスのreaction部分生成
	#-----------------------------------------
	#eventcode、及びparams[host]の対応アクション番号を取得
	action=`GetAlertAction ${alertactionlist} ${eventcode} ${params['host']}`
	if [ $? -ne 0 ] ; then
		OutWarning "${action}"
		continue
	fi
	eval ${action}
	OutDebug "${linesummary}action: `declare -p action | sed -e \"s/.*'(\(.*\))'.*/\1/g\"`"

	#取得した対応アクション番号を元に読み上げ後半部分、reactionのjson、対応アラートアクションを生成
	postguidance=""
	reactionjson="{"
	declare -A alertaction
	for b in ${action[@]}
	do
		if [ "${pushaction[${b}]}" == "" ]; then
			continue
		fi 
		postguidance="${postguidance}${pushaction[${b}]}は${b}を、"
		alertaction[${b}]=${pushaction[${b}]}
		reactionjson="${reactionjson}\"${b}\":{\"behavior\":\"terminate\",\"messageTemplate\":\"${pushaction[${b}]}を選択しました。\"},"
	done

	#postguidanceが空（有効なアクション番号が無い)場合は次行へ
	if [ "${postguidance}" == "" ] ; then
		OutWarning "${linesummary}イベント種別 ${eventcode} ホスト ${params['host']} の有効な対応アクションがありません。"
		continue
	fi

	#postguidqnceとreactionjsonに9番(継続)の情報を作成する
	postguidance="${postguidance}次の担当者へ連絡を行う場合は9を選択してください。"
	reactionjson="${reactionjson}\"9\":{\"behavior\":\"continue\",\"messageTemplate\":\"次の担当者に連絡を行います。\"}}"

	OutInfo "${linesummary}イベント種別 ${eventcode} ホスト ${params['host']} の対応アクションを取得しました。"
	OutDebug "${linesummary}alertaction: `declare -p alertaction | sed -e \"s/.*'(\(.*\))'.*/\1/g\"`"

	#-----------------------------------------
	# - Pigeonリクエスト用JSONの生成
	#-----------------------------------------
	#pattern[guidance]とpostguidanceを合成してガイダンスに
	guidance="${pattern[guidance]}${postguidance}"

	#parameters用json。paramsを整形
	paramsjson="{"
	i=0
	for key in ${!params[@]}
	do
		if [ ${i} -ne 0 ] ; then 
			paramsjson="${paramsjson},"
		fi
		paramsjson="${paramsjson}\"${key}\":\"${params[${key}]}\""
		((i++))
	done
	paramsjson="${paramsjson}}"

	#guidance用json、guidanceとreactionjsonの組み合わせ
	guidancejson="{\"messageTemplate\":\"${guidance}\",\"reactions\":${reactionjson}}"
	
	#JSON
	requestjson="{\"params\":{\"callflowId\":\"${callflowid}\",\"guidance\":${guidancejson},\"parameters\":${paramsjson}}}"

	OutInfo "${linesummary}Pigeonへのリクエストパラメータを生成しました。"
	OutDebug "${requestjson}"

	#-----------------------------------------
	# - Curl実行。POSTの場合は直前にjsonファイル生成
	#-----------------------------------------
	OutInfo "${linesummary}Pigeonへの架電命令を発行します。"
	if [ ${invoke} -eq 0 ] ; then
		#invokeが0の時は結果jsonをシミュレート生成
		OutInfo "${linesummary}設定値 invoke が OFF のため実際のAPI発行は行いません。"
		result="{\"status\":\"成功\",\"resultId\":\"test-${eventcode}-${lineno}\"}"
		ret=0
	else
		#uniqidを取得したのちjsonファイルの生成
		uniqid=`GetUniqID`
		jsonfile="${workdir}/${uniqid}.json"
		echo "${requestjson}" > ${jsonfile}
		OutDebug "jsonファイル '${jsonfile}' 作成"
		
		#架電命令実行。ansiblemodeにより処理変更
		if [ ${ansiblemode} -eq 0 ]; then
			#localからのcurlの場合
			OutDebug "local Curl実行"
			result=`Curl "${url}" "${kc_apitoken}" "POST" "${jsonfile}"`
			ret=$?
		else
			#ansible連携の場合
			OutInfo "${linesummary}Ansible との連係を行います。"
			resultfile=${workdir}/${uniqid}.ret
			ExecAnsibleCurl "${url}" "${kc_apitoken}" "POST" "${resultfile}" "${jsonfile}"
			ret=$?
			if [ ${ret} -ne 0 ] ;then
				OutWarning "${linesummary}Ansible との連携に失敗しました。(`cat ${resultfile}`)"
				result=`cat ${resultfile}`
			else
				OutInfo "${linesummary}Ansible との連係が成功しました。"
				result=`ParseAnsibleResult ${resultfile}`
				ret=$?
			fi
			rm -f ${resultfile}
		fi	
		
		#作成したjsonファイルの削除
		rm -f ${jsonfile}
		OutDebug "jsonファイル '${jsonfile}' 削除"
	fi

	#retが0 (curl成功)なものの、Pigeonからのレスポンス内 statusが「rejected」の場合
	#エラー内容を整形の上エラー扱いとする
	if [ ${ret} -eq 0 ] ; then
		status=`echo ${result} | jq -r '.status'`
		if [ "${status}" == "rejected" ] ; then
			ret=1
			errtitle=`echo ${result} | jq -r '.errorDescriptor.title'`
			errdetail=`echo ${result} | jq -r '.errorDescriptor.detail'`
			result="${errtitle} - ${errdetail}"
		fi
	fi


	#架電失敗時はメール送信
	if [ ${ret} -ne 0 ] ; then
		OutWarning "${linesummary}Pigeonへの架電命令に失敗しました。(${result})"
		#メール用パラメータ生成
		declare -A paramlist
		paramlist['contactcode']="${contactcode}"
		paramlist['eventcode']="${eventcode}"
		paramlist['eventdate']="${eventdate}"
		paramlist['eventtime']="${eventtime}"
		paramlist['eventhost']="${eventhost}"
		paramlist['eventsystem']="${eventsystem}"
		paramlist['eventmsg']="${eventmsg}"
		paramlist['callflowid']="${callflowid}"
		paramlist['requestjson']="${requestjson}"
		paramlist['dataline']="${line}"
		paramlist['reason']="${result}"

		#メール件名生成
		subject="[架電発行失敗] 架電実行スクリプトエラー通知"

		#メール送信
		mailresult=`SendTemplateMail "${mailfrom}" "${mailto}" "${subject}" "${mailtemplate_error}" "${workdr}" "paramlist"`
		if [ $? -eq 0 ] ; then
			OutInfo "${linesummary}架電命令の失敗を ${mailto} に送信しました。(${mailtemplate_error})"
		else
			OutWarning "${linesummary}${mailresult}"
		fi
		paramlist=""
		continue
	fi
	
	#Curl成功時
	status=`echo ${result} | jq -r '.status'`
	resultid=`echo ${result} | jq -r '.resultId'`
	touch ${requestdir}/${resultid}
	declare -p alertaction > ${requestdir}/${resultid}
	echo "${requestjson}" >> ${requestdir}/${resultid}
	
	OutInfo "${linesummary}Pigeonへの架電命令に成功しました。(${resultid})"
	sleep ${waitsec}

done < ${datafile}
OutInfo "中間ファイル '${datafile}' の読み込みを終了します。"
OutInfo "処理を終了します。"
exit 0
