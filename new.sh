Import os

mailbody_dir = ‘メールボディがあるディレクトリ’
mailbody_ptn = ‘mailbody.txt_’

#----- ディレクリ内ファイルやディレクトを全てリスト化
dir_lst = os.listdir(mailbody_dir)

##----- 検索文字で抽出されたファイルやディレクトリ名をリスト化
mlbody_lst = [line for line in dir_list if mailbody_ptn in line]

for mlbody in mlbody_lst:
             メール送信処理
