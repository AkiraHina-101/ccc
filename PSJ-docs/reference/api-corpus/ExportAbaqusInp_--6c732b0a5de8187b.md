# ExportAbaqusInp()

ExportAbaqusInp()

説明​

Abaqus Inpをエクスポートします。

構文​

ExportAbaqusInp(cursor m_crAbaJob,cursor[] m_taSelectBody,string strPath)

入力​

1. Cursor​

Abaqus ジョブ カーソル

2. Cursor[]​

出力する選択 パート カーソル

3. String​

INP ファイル用の出力ディレクトリ

戻り値​

"1": 機能を実行できます

"0": 機能を実行できません

サンプルコード​

ExportAbaqusInp(143:2, [], "D:/Abaqus.inp")
