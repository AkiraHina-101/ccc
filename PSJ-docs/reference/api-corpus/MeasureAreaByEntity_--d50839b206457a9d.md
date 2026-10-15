# MeasureAreaByEntity()

MeasureAreaByEntity()

説明​

エリアを測定します。

構文​

MeasureAreaByEntity(cursor[] entitycursor,String Target,Integer N)

入力​

1. Cursor[]​

エンティティカーソル（[*,**],*=EntityID,**=ID in Entity）。

2. Integer N​

小数点以下の桁数を指定します（0<=N<=30）。

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

MeasureAreaByEntity([3:1],3)

または

MeasureAreaByEntity([6:24,6:23],6)

または

MeasureAreaByEntity([11:379],0)
