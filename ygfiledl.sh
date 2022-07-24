#! /bin/sh
###############################################################################
#                                                                             #
#   Name          :  ygfiledl.sh （ログファイル削除＆圧縮処理）               #
#                                                                             #
#   Description   :  /togounyo/syslog配下のログファイルを削除・圧縮する       #
#                                                                             #
#   Input         :  削除・圧縮対象パス                                       #
#                    保存期間（日数）                                         #
#                                                                             #
#   Output        :  0 ・・・正常終了                                         #
#                    1 ・・・引数エラー                                       #
#                                                                             #
#   Date          :  2002/11/14                                               #
#                                                                             #
#   Update        :  2003/12/01                                               #
#                                                                             #
###############################################################################

### 環境変数設定 ###
PATH=$PATH:/usr/bin
YGZPATH=/togounyo/ygz
YGLOGPATH=/togounyo/syslog
HOZON_TXT=7
HOZON_Z=30
export YGZPATH YGLOGPATH PATH

### ログファイル圧縮処理実行 ###
${YGZPATH}/bin/ygfcompu ${YGLOGPATH}/ninshou 2>/dev/null
${YGZPATH}/bin/ygfcompu ${YGLOGPATH}/operate 2>/dev/null
${YGZPATH}/bin/ygfcompu ${YGLOGPATH}/access  2>/dev/null

### ログファイル削除処理実行(保存期間＝７日) ###
${YGZPATH}/bin/ygfiledl ${YGLOGPATH}/trace ${HOZON_TXT} 2>/dev/null
${YGZPATH}/bin/ygfiledl ${YGLOGPATH}/account ${HOZON_TXT} 2>/dev/null

### ログファイル削除処理実行(保存期間＝30日) ###
${YGZPATH}/bin/ygfiledl ${YGLOGPATH}/ninshou ${HOZON_Z} 2>/dev/null
${YGZPATH}/bin/ygfiledl ${YGLOGPATH}/operate ${HOZON_Z} 2>/dev/null
${YGZPATH}/bin/ygfiledl ${YGLOGPATH}/access ${HOZON_Z} 2>/dev/null

exit 0