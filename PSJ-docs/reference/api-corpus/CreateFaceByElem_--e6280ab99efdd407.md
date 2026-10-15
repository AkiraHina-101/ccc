# CreateFaceByElem()

CreateFaceByElem()

説明​

要素によってフェースを作成します。

構文​

CreateFaceByElem(cursor[] elem, bool shareFace)

入力​

1. Cursor[]​

ターゲット要素のカーソル（[11:要素ID]）

2. Bool​

フェースを共有するかどうか True = 1、False = 0

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

CreateFaceByElem([11:441, 11:442, 11:444, 11:443], 0)
