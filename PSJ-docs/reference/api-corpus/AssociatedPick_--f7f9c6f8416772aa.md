# AssociatedPick()

AssociatedPick()

説明​

関連ピックの実行

構文​

AssociatedPick(Cursor[] tacursor, String str2, String str3)

入力​

1. Cursor[]​

対象となるカーソル

2. String​

対象エンティティ名（BarBody、Part、Face、Edge、Elem、SolidElem、Node、CornerNode、MidNodes、MidNodesNoBoundary、Connection、Mass、Contact）

3. String​

str2=Connection のみ使用。（UNKNOWN、MPC、RBE2、RBE3、SPRING、MASS、BOLT、CONM、PROD、RBAR、BARBEAM、BUSH、MOMENT、GAP、WELD、DAMPER）

戻り値​

"1": 関数の実行が可能です

"0": 関数の実行ができません

サンプルコード​

AssociatedPick([6:26], "Node", "UNKNOWN")
