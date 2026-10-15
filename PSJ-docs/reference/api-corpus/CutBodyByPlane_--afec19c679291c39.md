# CutBodyByPlane()

CutBodyByPlane()

説明​

平面によるパートの切断

構文​

CutBodyByPlane(cursor crBody, double[3] cutPosition, int iType, double dOffset,
    bool bSplit, bool bSectionFace, bool bshareFace, cursor crLocalCoor, bool SeparateFace)

入力​

1. Cursor​

パートのキーカーソル（パートID）

2. Double[3]​

切断対象の1点

3. Int​

種類のオプション

4. Double​

切断平面からのオフセット値

5. Bool​

面を分割するかどうか 真 = 1, 偽 = 0

6. Bool​

セクション面を作成するかどうか 真 = 1, 偽 = 0

7. Bool​

面を共有するかどうか 真 = 1, 偽 = 0

8. Cursor​

ローカル座標を使用するかどうか 真 = 27:*, 偽 = 0:0

9. Bool​

面を分離するかどうか 真 = 1, 偽 = 0

戻り値コード​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

CutBodyByPlane(3:3, [0.02, 0.01555555555555556, 0.007777777777777778], 0, 0, 0, 1, 0, 0:0, 1)
