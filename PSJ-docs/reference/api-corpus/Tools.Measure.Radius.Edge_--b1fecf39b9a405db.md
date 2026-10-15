# Tools.Measure.Radius.Edge()

Tools.Measure.Radius.Edge()

説明​

指定されたエッジの円弧半径を測定します。

構文​

Tools.Measure.Radius.Edge(...)

リボン: Tools » Measure » Radius » Edge

入力​

crEdge​

曲線エッジの円弧半径を測定するために指定する Cursor 。選択したエッジは、直線エッジではなく曲線エッジである必要があります。

この入力は必須です。

iPrecision​

浮動小数点の後の桁数を指定する Integer 。iPrecision を大きくすると、円弧半径の精度が向上します。

デフォルト値は6です。

戻り値​

円弧半径の値を指定する Double です。

サンプルコード​

Geometry.Part.Cylinder()

radius = Tools.Measure.Radius.Edge(crEdge=Edge(1))

JPT.Debugger(radius)
