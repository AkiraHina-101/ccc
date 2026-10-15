# SolidElemInterface

SolidElemInterface

説明​

インターフェース要素としてピラミッド要素を作成します。

構文​

SolidElemInterface(cursor[] taFaces, bool Flip, cursor[] taElements)

入力​

1. Cursor[]​

フェースカーソル（[6:Face ID]）

2. Bool​

ノーマルを反転 false：0、true：1

3. Cursor[]​

要素カーソル（[11:Elements ID]）

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

SolidElemInterface([6:22], 0, [11:324])
