# ExportAdx()

ExportAdx()

説明​

ADXファイルをエクスポートします。

構文​

ExportAdx(カーソル crJobAdx, 文字列 strPath, 整数 NumType, 整数 Width, 整数 Precision)

入力​

1. Cursor​

エクスポートされたジョブのカーソル

2. String​

ADXファイルのパス

3. Int​

タイプの数

4. Int​

幅

5. Int​

精度

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

ExportAdx(130:1, "D:/ADVC.adx", 2, 10, 5)
