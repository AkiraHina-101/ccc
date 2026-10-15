# Tools.Measure.Distance.Edge()

Tools.Measure.Distance.Edge()

説明​

エッジの長さを測定します。

構文​

Tools.Measure.Distance.Edge(...)

リボン: Tools » Measure » Distance » Edge

入力​

crEdge​

距離を測定するエッジを指定する Cursor です。

この入力は必須です。

iPrecision​

浮動小数点以下の桁数を指定する Integer です。iPrecision が大きいほど、距離の精度が向上します。

デフォルト値は6です。

戻り値​

指定されたエッジの長さを示す Double です。

サンプルコード​

Geometry.Part.Cube()

length = Tools.Measure.Distance.Edge(crEdge=Edge(15))

JPT.Debugger(length)
