#! /bin/sh
###############################################################################
#                                                                             #
#   Name          :  ygfiledl.sh �i���O�t�@�C���폜�����k�����j               #
#                                                                             #
#   Description   :  /togounyo/syslog�z���̃��O�t�@�C�����폜�E���k����       #
#                                                                             #
#   Input         :  �폜�E���k�Ώۃp�X                                       #
#                    �ۑ����ԁi�����j                                         #
#                                                                             #
#   Output        :  0 �E�E�E����I��                                         #
#                    1 �E�E�E�����G���[                                       #
#                                                                             #
#   Date          :  2002/11/14                                               #
#                                                                             #
#   Update        :  2003/12/01                                               #
#                                                                             #
###############################################################################

### ���ϐ��ݒ� ###
PATH=$PATH:/usr/bin
YGZPATH=/togounyo/ygz
YGLOGPATH=/togounyo/syslog
HOZON_TXT=7
HOZON_Z=30
export YGZPATH YGLOGPATH PATH

### ���O�t�@�C�����k�������s ###
${YGZPATH}/bin/ygfcompu ${YGLOGPATH}/ninshou 2>/dev/null
${YGZPATH}/bin/ygfcompu ${YGLOGPATH}/operate 2>/dev/null
${YGZPATH}/bin/ygfcompu ${YGLOGPATH}/access  2>/dev/null

### ���O�t�@�C���폜�������s(�ۑ����ԁ��V��) ###
${YGZPATH}/bin/ygfiledl ${YGLOGPATH}/trace ${HOZON_TXT} 2>/dev/null
${YGZPATH}/bin/ygfiledl ${YGLOGPATH}/account ${HOZON_TXT} 2>/dev/null

### ���O�t�@�C���폜�������s(�ۑ����ԁ�30��) ###
${YGZPATH}/bin/ygfiledl ${YGLOGPATH}/ninshou ${HOZON_Z} 2>/dev/null
${YGZPATH}/bin/ygfiledl ${YGLOGPATH}/operate ${HOZON_Z} 2>/dev/null
${YGZPATH}/bin/ygfiledl ${YGLOGPATH}/access ${HOZON_Z} 2>/dev/null

exit 0