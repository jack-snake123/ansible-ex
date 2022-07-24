#!/bin/bash

######################################<+>#######################################
#  File              : yylogr.sh
#  Project           : SmartOperationシステム
#  Description       : ログローテーション処理
#  Language          : bash
#  Date              : 2020.09.10
#  Author            : 日立システムズパワーサービス
#  Update            :
######################################<+>#######################################

#-----------------------------------------------------------------------------
# 定数定義
#-----------------------------------------------------------------------------
    ###  アクセスログ(/var/log/secure)
      #  処理対象ログディレクトリ
      ACCESS_DIR=/var/log/
      #  処理対象ログファイル名
      ACCESS_LOG=secure
      #  ログ出力先ディレクトリ
      ACCESS_OUT=/togounyo/syslog/access/YY/

    ###  アクセスログ(/var/log/jenkins)
      #  処理対象ログディレクトリ
      ACCESS_DIR_2=/var/log/jenkins/
      #  処理対象ログファイル名
      ACCESS_LOG_2=access_log
      #  ログ出力先ディレクトリ
      ACCESS_OUT=/togounyo/syslog/access/YY/

    ###  アクセスログ(/var/log/gitlab/nginx)
      #  処理対象ログディレクトリ
      ACCESS_DIR_3=/var/log/gitlab/nginx/
      #  処理対象ログファイル名
      ACCESS_LOG_3=gitlab_access
      #  ログ出力先ディレクトリ
      ACCESS_OUT=/togounyo/syslog/access/YY/

    ###  メールログ(/var/log/maillog)
      #  処理対象ログディレクトリ
      MAIL_DIR=/var/log/
      #  処理対象ログファイル名
      MAIL_LOG=maillog
      #  ログ出力先ディレクトリ
      MAIL_OUT=/togounyo/syslog/operate/YY/

    ###  操作ログ(/var/log/jenkins_job.log)
      #  処理対象ログディレクトリ
      OPERATE_DIR=/var/log/
      #  処理対象ログファイル名
      OPERATE_LOG=jenkins_job
      #  ログ出力先ディレクトリ
      OPERATE_OUT=/togounyo/syslog/operate/YY/

    ###  操作ログ(/var/log/jenkins/jenkins.log)
      #  処理対象ログディレクトリ
      OPERATE_DIR_2=/var/log/jenkins/
      #  処理対象ログファイル名
      OPERATE_LOG_2=jenkins
      #  ログ出力先ディレクトリ
      OPERATE_OUT=/togounyo/syslog/operate/YY/

    ###  日付・時間
    #  前日日付
    YMD1dAGO=`date -d "1 day ago" +"%Y%m%d"`

#-----------------------------------------------------------------------------
# main
#-----------------------------------------------------------------------------
    ### アクセスログ(/var/log/secure)
    if [ -f ${ACCESS_OUT}${ACCESS_LOG}-${YMD1dAGO}.log.Z ];then
        zcat ${ACCESS_OUT}${ACCESS_LOG}-${YMD1dAGO}.log.Z >> ./tmp_access.txt 2>/dev/null
        rm -f ${ACCESS_OUT}${ACCESS_LOG}-${YMD1dAGO}.log.Z
        cat ./tmp_access.txt >> ${ACCESS_OUT}${ACCESS_LOG}-${YMD1dAGO}.log 2>/dev/null
        cat ${ACCESS_DIR}${ACCESS_LOG} >> ${ACCESS_OUT}${ACCESS_LOG}-${YMD1dAGO}.log 2>/dev/null
        rm -f tmp_access.txt > /dev/null 2>&1
    else
        cat ${ACCESS_DIR}${ACCESS_LOG} > ${ACCESS_OUT}${ACCESS_LOG}-${YMD1dAGO}.log 2>/dev/null
        GetSTS=$?
        if [ ${GetSTS} -ne 0 ];then
           touch ${ACCESS_OUT}${ACCESS_LOG}-${YMD1dAGO}.log
        fi
    fi

    ### アクセスログ(/var/log/jenkins)
    if [ -f ${ACCESS_OUT}${ACCESS_LOG_2}-${YMD1dAGO}.log.Z ];then
        zcat ${ACCESS_OUT}${ACCESS_LOG_2}-${YMD1dAGO}.log.Z >> ./tmp_access_2.txt 2>/dev/null
        rm -f ${ACCESS_OUT}${ACCESS_LOG_2}-${YMD1dAGO}.log.Z
        cat ./tmp_access_2.txt >> ${ACCESS_OUT}${ACCESS_LOG_2}-${YMD1dAGO}.log 2>/dev/null
        cat ${ACCESS_DIR_2}${ACCESS_LOG_2} >> ${ACCESS_OUT}${ACCESS_LOG_2}-${YMD1dAGO}.log 2>/dev/null
        rm -f tmp_access_2.txt > /dev/null 2>&1
    else
        cat ${ACCESS_DIR_2}${ACCESS_LOG_2} > ${ACCESS_OUT}${ACCESS_LOG_2}-${YMD1dAGO}.log 2>/dev/null
        GetSTS=$?
        if [ ${GetSTS} -ne 0 ];then
           touch ${ACCESS_OUT}${ACCESS_LOG_2}-${YMD1dAGO}.log
        fi
    fi

    ### アクセスログ(/var/log/gitlab/nginx)
    if [ -f ${ACCESS_OUT}${ACCESS_LOG_3}-${YMD1dAGO}.log.Z ];then
        zcat ${ACCESS_OUT}${ACCESS_LOG_3}-${YMD1dAGO}.log.Z >> ./tmp_access_3.txt 2>/dev/null
        rm -f ${ACCESS_OUT}${ACCESS_LOG_3}-${YMD1dAGO}.log.Z
        cat ./tmp_access_3.txt >> ${ACCESS_OUT}${ACCESS_LOG_3}-${YMD1dAGO}.log 2>/dev/null
        cat ${ACCESS_DIR_3}${ACCESS_LOG_3}.log >> ${ACCESS_OUT}${ACCESS_LOG_3}-${YMD1dAGO}.log 2>/dev/null
        rm -f tmp_access_3.txt > /dev/null 2>&1
    else
        cat ${ACCESS_DIR_3}${ACCESS_LOG_3}.log > ${ACCESS_OUT}${ACCESS_LOG_3}-${YMD1dAGO}.log 2>/dev/null
        GetSTS=$?
        if [ ${GetSTS} -ne 0 ];then
           touch ${ACCESS_OUT}${ACCESS_LOG_3}-${YMD1dAGO}.log
        fi
    fi

    ### メールログ(/var/log/maillog)
    if [ -f ${MAIL_OUT}${MAIL_LOG}-${YMD1dAGO}.log.Z ];then
        zcat ${MAIL_OUT}${MAIL_LOG}-${YMD1dAGO}.log.Z >> ./tmp_mail.txt 2>/dev/null
        rm -f ${MAIL_OUT}${MAIL_LOG}-${YMD1dAGO}.log.Z
        cat ./tmp_mail.txt >> ${MAIL_OUT}${MAIL_LOG}-${YMD1dAGO}.log 2>/dev/null
        cat ${MAIL_DIR}${MAIL_LOG} >> ${MAIL_OUT}${MAIL_LOG}-${YMD1dAGO}.log 2>/dev/null
        rm -f tmp_mail.txt > /dev/null 2>&1
    else
        cat ${MAIL_DIR}${MAIL_LOG} > ${MAIL_OUT}${MAIL_LOG}-${YMD1dAGO}.log 2>/dev/null
        GetSTS=$?
        if [ ${GetSTS} -ne 0 ];then
           touch ${MAIL_OUT}${MAIL_LOG}-${YMD1dAGO}.log
        fi
    fi

    ### 操作ログ(/var/log/jenkins/jenkins_job.log)
    if [ -f ${OPERATE_OUT}${OPERATE_LOG}-${YMD1dAGO}.log.Z ];then
        zcat ${OPERATE_OUT}${OPERATE_LOG}-${YMD1dAGO}.log.Z >> ./tmp_operate.txt 2>/dev/null
        rm -f ${OPERATE_OUT}${OPERATE_LOG}-${YMD1dAGO}.log.Z
        cat ./tmp_operate.txt >> ${OPERATE_OUT}${OPERATE_LOG}-${YMD1dAGO}.log 2>/dev/null
        cat ${OPERATE_DIR}${OPERATE_LOG}.log >> ${OPERATE_OUT}${OPERATE_LOG}-${YMD1dAGO}.log 2>/dev/null
        rm -f tmp_operate.txt > /dev/null 2>&1
    else
        cat ${OPERATE_DIR}${OPERATE_LOG}.log > ${OPERATE_OUT}${OPERATE_LOG}-${YMD1dAGO}.log 2>/dev/null
        GetSTS=$?
        if [ ${GetSTS} -ne 0 ];then
           touch ${OPERATE_OUT}${OPERATE_LOG}-${YMD1dAGO}.log
        fi
    fi

    ### 操作ログ(/var/log/jenkins/jenkins.log)
    if [ -f ${OPERATE_OUT}${OPERATE_LOG_2}-${YMD1dAGO}.log.Z ];then
        zcat ${OPERATE_OUT}${OPERATE_LOG_2}-${YMD1dAGO}.log.Z >> ./tmp_operate_2.txt 2>/dev/null
        rm -f ${OPERATE_OUT}${OPERATE_LOG_2}-${YMD1dAGO}.log.Z
        cat ./tmp_operate_2.txt >> ${OPERATE_OUT}${OPERATE_LOG_2}-${YMD1dAGO}.log 2>/dev/null
        cat ${OPERATE_DIR_2}${OPERATE_LOG_2}.log >> ${OPERATE_OUT}${OPERATE_LOG_2}-${YMD1dAGO}.log 2>/dev/null
        rm -f tmp_operate_2.txt > /dev/null 2>&1
    else
        cat ${OPERATE_DIR_2}${OPERATE_LOG_2}.log > ${OPERATE_OUT}${OPERATE_LOG_2}-${YMD1dAGO}.log 2>/dev/null
        GetSTS=$?
        if [ ${GetSTS} -ne 0 ];then
           touch ${OPERATE_OUT}${OPERATE_LOG_2}-${YMD1dAGO}.log
        fi
    fi

exit 0