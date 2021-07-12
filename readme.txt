＜インストール方法＞

１．以下のフォルダをC:\にコピーする。

　　コピー先　c:\

２．コマンドプロンプトを起動し、以下のコマンドを実行しsikuliをインストールす
る。

　　>　c:\SmartOP\sikuli\jre\bin\java.exe -jar c:\SmartOP\sikuli\sikulixsetup-1.1.1.jar

３．「You are about to run・・・・」と表示されましたら「はい」をクリックす
る。

４．「1-Pack1」をチェックし「Setupnow」をクリックする。

５．以降はすべて「はい」をクリックする。

６．「OK」をクリックする。

７．コマンドプロンプト画面を閉じる。

以上でインストール完了です。


＜起動確認方法＞

１．インストール後に作成された以下のファイルを編集する。

　　　c:\SmartOP\sikuli\runsikulix.cmd

２．４行目に以下の設定を追加する。

　　　　　@echo off
　　　　　SETLOCAL ENABLEEXTENSIONS
　　　　　set SJAR=sikulix
　追加　→set JAVA_HOME=C:\SmartOP\sikuli\jre

３．起動
　　C:\SmartOP\sikuli\runsikulix.cmdを実行する。

以上


＜参考情報＞
>tree C:\SmartOP
フォルダー パスの一覧:  ボリューム Windows
ボリューム シリアル番号は A688-C2F0 です
C:\SMARTOP
└─sikuli
    ├─Downloads
    ├─jre
    │  ├─bin
    │  │  ├─client
    │  │  ├─dtplugin
    │  │  └─plugin2
    │  └─lib
    │      ├─applet
    │      ├─cmm
    │      ├─deploy
    │      ├─ext
    │      ├─fonts
    │      ├─i386
    │      ├─images
    │      │  └─cursors
    │      ├─jfr
    │      ├─management
    │      └─security
    └─lib
        ├─backports
        │  └─configparser
        ├─chardet
        │  └─cli
        ├─jinja2
        ├─markupsafe
        ├─xlrd
        └─xlwt

