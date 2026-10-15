# BodyCutBy3PointsS()

BodyCutBy3PointsS()

説明​

3点で切断された パート

構文​

BodyCutBy3PointsS(cursor crBody, double[] cutPosition, double dOffset , bool bSplit, bool makeSectionFace, bool shareFace, bool SeparateFace)

入力​

1. Cursor​

パートキーを示すカーソル（パートID）

2. Double[]​

切断対象となるポイント

3. Double​

切断平面からのオフセット値

4. Bool​

フェースを分割するかどうか（True = 1、False = 0）

5. Bool​

セクションフェースを作成するかどうか（True = 1、False = 0）

6. Bool​

フェースを共有するかどうか（True = 1、False = 0）

7. Bool​

フェースを分離するかどうか（True = 1、False = 0）

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

BodyCutBy3PointsS(3:2, [[0.01, 0.003333333333333333, 0.01], [0.02, 0.003333333333333333, 0.01], [0.02, 0.003333333333333333, 0]], 0.0022, 0, 1, 0, 1)
