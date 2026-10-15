# SetPartAppearance()

SetPartAppearance()

説明​

パートの外観を設定します。

構文​

SetPartAppearance(Cursor[] tacursor, String Type, Bool Show)

入力​

1. Cursor[]​

ターゲットエンティティのカーソルリスト

2. String​

外観対象を指定する String です。

"Surface"

"Mesh"

"Edge"

"Node"

3. Bool​

-表示または非表示を指定する Boolean です。
-デフォルト値は True (表示) です。

戻り値​

"1": 関数は実行可能です

"0": 関数は実行できません

サンプルコード​

SetPartAppearance([3:1], "Mesh", 1)
