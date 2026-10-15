# BodyCutBySurfaceS()

BodyCutBySurfaceS()

説明​

3点で パートをカットします

構文​

BodyCutBySurfaceS(cursor[] crBody, cursor cutFace, bool splitOnly, bool makeSectionFace, bool shareFace, bool SeparateFace)

入力​

1. Cursor[]​

対象パートのカーソル（[3:PartID]）

2. Cursor​

カットする対象のフェース

3. Bool​

フェースを分割するかどうか：True = 1、False = 0

4. Bool​

セクションフェースを作成するかどうか：True = 1、False = 0

5. Bool​

フェースを共有するかどうか：True = 1、False = 0

6. Bool​

フェースを分離するかどうか：True = 1、False = 0

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

BodyCutBySurfaceS([3:2], 3:9, 0, 1, 0, 0)
