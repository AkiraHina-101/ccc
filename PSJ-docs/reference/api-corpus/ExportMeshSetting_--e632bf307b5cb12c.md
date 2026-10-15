# ExportMeshSetting()

ExportMeshSetting()

説明​

ローカル設定を保存します。

構文​

ExportMeshSetting(string fname,int type)

入力​

1. String​

ローカル設定を保存するファイル名です。

2. Int​

保存モードです。この機能では値が 3 に固定されています。

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

ExportMeshSetting("D:/test.xml", 3)
