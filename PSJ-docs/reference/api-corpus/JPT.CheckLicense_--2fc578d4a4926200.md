# JPT.CheckLicense()

JPT.CheckLicense()

説明​

入力されたライセンスがアクティブ化されているかどうかを確認します。

構文​

JPT.CheckLicense("Feature")

入力​

Feature​

Jupiterライセンスの名前を指定した String です。

Jupiterライセンスの名前は Home » Preference » License で見つけることができます。

これは必須の入力です。

戻り値​

ライセンスの状態を示す Boolean 型です：

True: ライセンス機能がアクティブ化されています。

False: ライセンス機能が非アクティブ化されています。

サンプルコード​

# JPT_BASE機能ライセンスの状態を取得して画面に表示します
lic = JPT.CheckLicense("JPT_BASE")
print(lic)
