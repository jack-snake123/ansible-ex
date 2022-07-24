#!/bin/bash

######################################<+>#######################################
#  File              : yylogr.sh
#  Project           : SmartOperation�V�X�e��
#  Description       : ���O���[�e�[�V��������
#  Language          : bash
#  Date              : 2020.09.10
#  Author            : �����V�X�e���Y�p���[�T�[�r�X
#  Update            :
######################################<+>#######################################

#-----------------------------------------------------------------------------
# �萔��`
#-----------------------------------------------------------------------------
    ###  �A�N�Z�X���O(/var/log/secure)
      #  �����Ώۃ��O�f�B���N�g��
      ACCESS_DIR=/var/log/
      #  �����Ώۃ��O�t�@�C����
      ACCESS_LOG=secure
      #  ���O�o�͐�f�B���N�g��
      ACCESS_OUT=/togounyo/syslog/access/YY/

    ###  �A�N�Z�X���O(/var/log/jenkins)
      #  �����Ώۃ��O�f�B���N�g��
      ACCESS_DIR_2=/var/log/jenkins/
      #  �����Ώۃ��O�t�@�C����
      ACCESS_LOG_2=access_log
      #  ���O�o�͐�f�B���N�g��
      ACCESS_OUT=/togounyo/syslog/access/YY/

    ###  �A�N�Z�X���O(/var/log/gitlab/nginx)
      #  �����Ώۃ��O�f�B���N�g��
      ACCESS_DIR_3=/var/log/gitlab/nginx/
      #  �����Ώۃ��O�t�@�C����
      ACCESS_LOG_3=gitlab_access
      #  ���O�o�͐�f�B���N�g��
      ACCESS_OUT=/togounyo/syslog/access/YY/

    ###  ���[�����O(/var/log/maillog)
      #  �����Ώۃ��O�f�B���N�g��
      MAIL_DIR=/var/log/
      #  �����Ώۃ��O�t�@�C����
      MAIL_LOG=maillog
      #  ���O�o�͐�f�B���N�g��
      MAIL_OUT=/togounyo/syslog/operate/YY/

    ###  ���샍�O(/var/log/jenkins_job.log)
      #  �����Ώۃ��O�f�B���N�g��
      OPERATE_DIR=/var/log/
      #  �����Ώۃ��O�t�@�C����
      OPERATE_LOG=jenkins_job
      #  ���O�o�͐�f�B���N�g��
      OPERATE_OUT=/togounyo/syslog/operate/YY/

    ###  ���샍�O(/var/log/jenkins/jenkins.log)
      #  �����Ώۃ��O�f�B���N�g��
      OPERATE_DIR_2=/var/log/jenkins/
      #  �����Ώۃ��O�t�@�C����
      OPERATE_LOG_2=jenkins
      #  ���O�o�͐�f�B���N�g��
      OPERATE_OUT=/togounyo/syslog/operate/YY/

    ###  ���t�E����
    #  �O�����t
    YMD1dAGO=`date -d "1 day ago" +"%Y%m%d"`

#-----------------------------------------------------------------------------
# main
#-----------------------------------------------------------------------------
    ### �A�N�Z�X���O(/var/log/secure)
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

    ### �A�N�Z�X���O(/var/log/jenkins)
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

    ### �A�N�Z�X���O(/var/log/gitlab/nginx)
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

    ### ���[�����O(/var/log/maillog)
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

    ### ���샍�O(/var/log/jenkins/jenkins_job.log)
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

    ### ���샍�O(/var/log/jenkins/jenkins.log)
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