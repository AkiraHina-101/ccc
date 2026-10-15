# Tools.Measure.Distance.TwoEdges()

Tools.Measure.Distance.TwoEdges()

説明​

2つのエッジの距離を測定します。

構文​

Tools.Measure.Distance.TwoEdges(...)

リボン: Tools » Measure » Distance » TwoEdges

入力​

crEdge1​

距離を測定する最初のエッジを指定する Cursor です。

これは必須の入力です。

crEdge2​

距離を測定する2番目のエッジを指定する Cursor です。

これは必須の入力です。

iPrecision​

浮動小数点の後の桁数を指定する Integer です。iPrecision の値が大きいほど、距離の精度が向上します。

デフォルト値は6です。

戻り値​

2つのエッジ間の距離を指定する Double です。

サンプルコード​

Geometry.Part.Cube()

distance = Tools.Measure.Distance.TwoEdges(crEdge1=Edge(20), 
                                           crEdge2=Edge(18))

JPT.Debugger(distance)
