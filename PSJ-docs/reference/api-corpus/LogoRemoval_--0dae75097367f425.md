# LogoRemoval()

LogoRemoval()

説明​

エッジからフェースを作成します。

構文​

LogoRemoval(cursor[] startFaces, cursor[] stopFaces, int layers, bool mergeFace)

入力​

1. Cursor[]​

開始フェースのカーソルリスト（[6:Face ID]）

2. Cursor[]​

終了フェースのカーソルリスト（[6:Face ID]）

3. Int​

開始フェースに隣接したフェースのレイヤー数

4. Bool​

マージフェースするかどうか：True = 1、False = 0

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

LogoRemoval([6:84, 6:77, 6:95, 6:64], [6:2], 5, 0)
