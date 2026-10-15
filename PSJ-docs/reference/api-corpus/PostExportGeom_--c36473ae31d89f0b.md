# PostExportGeom()

PostExportGeom()

説明​

Post変形による変形形状をstlファイルとしてエクスポートします。

構文​

PostExportGeom(string folder, bool bUseUnit)

入力​

1. string ​

エクスポートファイルパス。

2. bool ​

文書単位を使用します。

戻り値​

"1": 成功しました。

"0": 失敗しました。

サンプルコード​

PostExportGeom("C:/Users/USERNAME/Desktop/temp", 1)
