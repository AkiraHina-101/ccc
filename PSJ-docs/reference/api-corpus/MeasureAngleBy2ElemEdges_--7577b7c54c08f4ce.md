# MeasureAngleBy2ElemEdges()

MeasureAngleBy2ElemEdges()

説明​

2つの要素エッジによって作成された角度を測定します。

構文​

MeasureAngleBy2ElemEdges(cursorpair elemedge1, cursorpair elemedge2, String Target, Integer N)

入力​

1. Cursorpair​

elemedge cursorpair(10:-10:**;,**=node id)

2. Cursorpair​

elemedge cursorpair(10:-10:**;,**=node id)

3. String​

Target（角度またはXYまたはYZまたはZXまたはALL）

4. Integer N​

小数点以下の桁数を指定します（0<=N<=30）

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

MeasureAngleBy2ElemEdges(10:330-10:331, 10:331-10:323, "Angle", 6)

または

MeasureAngleBy2ElemEdges(10:330-10:331, 10:331-10:323, "ALL", 6)
