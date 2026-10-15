# TransferDocumentData()

TransferDocumentData()

説明​

ドキュメントの項目を別のドキュメントに転送します。

構文​

TransferDocumentData(string strSourceDocTitle, string strDestDocTitle, cursor[] Parts, string[] strlNewPartName, cursor crDestAssemblyInstance, bool bEnableCutOperation)

入力​

1. String​

元のドキュメントの名前。

2. String​

送信先ドキュメントの名前。

3. cursor[]​

変換されたパートを指定する Cursor のリスト。

4. String[]​

送信先ドキュメント内で変換されたパートの新しい名前のリスト。

5. Cursor​

送信先ドキュメントの名前。

6. Bool​

切り取りまたはコピーを指定します。

0: 切り取り。

1: コピー。

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

TransferDocumentData("Jupiter1", "Jupiter2", [3:1], ["Cube_1"], 0:0, 1)
