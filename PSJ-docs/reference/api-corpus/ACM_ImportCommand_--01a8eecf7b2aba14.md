# ACM_ImportCommand()

ACM_ImportCommand()

説明​

ACM_ImportCommand

構文​

ACM_ImportCommand(bool bOutShelFile, string srtImportFilePathTri6, string strImportFilePathTri3)

入力​

1. Bool​

アウトシェルファイルのブールフラグ True = 1、False = 0

2. String​

bdfエクスポートを使用してエクスポートされたTri6モデルのbdfファイルパス

3. String​

bdfエクスポートを使用してエクスポートされたTri3モデルのbdfファイルパス

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

ACM_ImportCommand(1, "D:/tri6.bdf", "D:/tri3.bdf")
