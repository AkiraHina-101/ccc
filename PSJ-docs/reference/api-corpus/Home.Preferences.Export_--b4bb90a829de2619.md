# Home.Preferences.Export()

Home.Preferences.Export()

説明​

プリファレンス設定をエクスポートします(.json ファイル)。

構文​

Home.Preferences.Export(...)

Macro: ExportPreferenceSettings

Ribbon: Home » Preferences » Export

力​

strPath​

エクスポートファイルを指定する String です。

必須の入力です。

戻り値​

プロセスが正常に実行されたかどうかを示す Boolean 型：

True: プロセスは正常に実行されました。

False: 関数を実行できません。

サンプルコード​

Home.Preferences.Export("C:/temp/DCADPreference.json")
