0.PowerShell有効確認(管理者として実行)
 >Get-Executionpolicy
 RemoteSigned

 RemoteSignedではなかった場合、下記コマンドを実施
>Set-Executionpolicy RemoteSigned

1.WinRM設定スクリプト実行(管理者として実行)
 >ansible.ps1 -SkipNetworkProfileCheck
　※エラーの表示が無くプロンプトが返ってくればOK

2.設定の正常終了確認
・WINRMサービスの有効確認
>Get-Service "WinRM"
　ステータスがRunningになっていること

Status   Name               DisplayName
------   ----               -----------
Running  WinRM              Windows Remote Management (WS-Manag...


・WinRMリスナーポートの確認
>winrm enumerate winrm/config/Listener
　5985、5986のリスナーポートが表示されること
Listener
    Address = *
    Transport = HTTP
    Port = 5985
    Hostname
    Enabled = true
    URLPrefix = wsman
    CertificateThumbprint
    ListeningOn = 10.74.25.89, 127.0.0.1, 129.73.11.69, 130.50.39.49, ::1, 2002:8149:b45::8149:b45, 2002:8232:2731::8232 :2731, fe80::5efe:10.74.25.89%18, fe80::200:5efe:129.73.11.69%13, fe80::200:
5efe:130.50.39.49%15, fe80::a50e:9e8c:3314:9
914%31

Listener
    Address = *
    Transport = HTTPS
    Port = 5986
    Hostname
    Enabled = true
    URLPrefix = wsman
    CertificateThumbprint = 2e5056a5dfc64329c9f96c277f05ad2b18717f35
    ListeningOn = 10.74.25.89, 127.0.0.1, 129.73.11.69, 130.50.39.49, ::1, 2002:8149:b45::8149:b45, 2002:8232:2731::8232 :2731, fe80::5efe:10.74.25.89%18, fe80::200:5efe:129.73.11.69%13, fe80::200:
5efe:130.50.39.49%15, fe80::a50e:9e8c:3314:9
914%31

・WinRMコンフィグ確認
>Get-ChildItem WSMan:\localhost\Service\Auth
　Basic、Kerberosがtrueになっていること

   WSManConfig: Microsoft.WSMan.Management\WSMan::localhost\Service\Auth

Type            Name                           SourceOfValue   Value
----            ----                           -------------   -----
System.String   Basic                                          true
System.String   Kerberos                                       true
System.String   Negotiate                                      true
System.String   Certificate                                    false
System.String   CredSSP                                        false
System.String   CbtHardeningLevel                              Relaxed



≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡
　株式会社 日立システムズパワーサービス
　マネージドサービス事業部　データセンタ運営本部
　システム先進技術部　運用システム先進グループ
　尾方 哲紀 / OGATA TETSUNORI
　TEL: 080-6852-8976
　Email: ogata-tetsunori@hitachi-systems-ps.co.jp
≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡


-----Original Message-----
From: Tetsunori Ogata <ogata-tetsunori@hitachi-systems-ps.co.jp>
Sent: Monday, July 12, 2021 3:16 PM
To: 尾方哲紀 / OGATA，TETSUNORI <tetsunori.ogata.fj@hitachi-systems.com>
Subject: tttt

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

