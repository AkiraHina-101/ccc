# Home.Preferences.Import()

Home.Preferences.Import()

説明​

プリファレンス設定をインポートします(.json ファイル)。

構文​

Home.Preferences.Import(...)

Macro: ImportPreferenceSettings

Ribbon: Home » Preferences » Import

力​

strPath​

インポートファイルを指定する String です。

必須の入力です。

戻り値​

プロセスが正常に実行されたかどうかを示す Boolean 型：

True: プロセスは正常に実行されました。

False: 関数を実行できません。

サンプルコード​

Home.Preferences.Import("C:/temp/DCADPreference.json")
