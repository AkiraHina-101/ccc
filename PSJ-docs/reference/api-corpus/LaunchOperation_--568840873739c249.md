# LaunchOperation()

LaunchOperation()

説明​

指定されたコマンドのダイアログを起動します

構文​

LaunchOperation(string strCommandID, int iPattern)

入力​

1. String​

コマンドID（コマンドの名前）

2. int​

コマンドに複数の表示パターンがある場合はパターンを示します。

戻り値​

"1": 関数を実行できます

"FAILED": 関数を実行できません

サンプルコード​

LaunchOperation("GEOMETRY_CREATE_ENTITY_PARTS_CUBE", 0)
