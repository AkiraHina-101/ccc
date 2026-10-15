# ImprintExtendLine()

ImprintExtendLine()

説明​

インプリントの延長ラインを作成します

構文​

ImprintExtendLine(cursor[] vcrEdge, int iMethod, int iPosition, int iNoFittingPoints, int iDiv, bool bBreakFace)

入力​

1. Cursor[]​

ラインを延長する対象のエッジ カーソル([5:Edge ID])

2. Int​

メソッドタイプ

0: 直線

1: 同じ曲率

3. Int​

延長する位置のタイプ

0: 最も近いエッジ

1: 境界エッジ

4. Int​

フィッティングポイントの数

5. Int​

分割数

6. Bool​

フェースを分割するかどうか True = 1, False = 0

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

ImprintExtendLine([5:27], 0, 0, 3, 2, 1)
