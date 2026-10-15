# CmdDataPaneDeleteItems()

CmdDataPaneDeleteItems()

説明​

ウォッチデータウィンドウの指定されたタブのすべてのデータを削除します。

構文​

CmdDataPaneDeleteItems(int Tab, int[] items)

入力​

1. int​

タブID。

2. int []​

削除する行のIDリスト。

戻り値​

なし。

サンプルコード​

CmdDataPaneDeleteItems(1, [1,2,3,4])
