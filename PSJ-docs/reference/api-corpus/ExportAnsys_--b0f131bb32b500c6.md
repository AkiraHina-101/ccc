# ExportAnsys()

ExportAnsys()

説明​

Ansysファイルをエクスポートします。

構文​

ExportAnsys(String m_strName,Cursor m_crAbaJob)

入力​

1. String​

エクスポートファイル名

2. Cursor​

Ansysジョブカーソル

戻り値​

"1": 関数が実行できます

"0": 関数が実行できません

サンプルコード​

ExportAnsys("D:/Ansys.dat", 146:1)
