# MeasureDistanceBy2Edges()

MeasureDistanceBy2Edges()

説明​

2つのエッジ間の距離を測定します

構文​

MeasureDistanceBy2Edges(cursor edge,cursor node,Integer N)

入力​

1. Cursor​

エッジのカーソル（5:,=エッジID）

2. Cursor​

エッジのカーソル（5:,=エッジID）

3. Int N​

小数点以下の桁数を指定します（0<=N<=30）

戻り値​

"1": 関数が実行可能です

"0": 関数が実行できません

サンプルコード​

MeasureDistanceBy2Edges(5:18,5:11,6)
