# Tools.Measure.Radius.ThreeNodes()

Tools.Measure.Radius.ThreeNodes()

説明​

3つの節点を使用して円弧の半径を測定します。

構文​

Tools.Measure.Radius.ThreeNodes(...)

リボン: Tools » Measure » Radius » ThreeNodes

入力​

crNode13​

円弧の半径が測定される節点を指定する Cursor です。

これは必須の入力です。

crNode23​

円弧の半径が測定される2番目の節点を指定する Cursor です。

これは必須の入力です。

crNode33​

円弧の半径が測定される3番目の節点を指定する Cursor です。

これは必須の入力です。

iPrecision​

浮動小数点の後の桁数を指定する Integer です。iPrecision が大きいほど、円弧の半径をより正確に測定できます。

デフォルト値は6です。

戻り値​

円弧の半径値を指定する Double です。

サンプルコード​

Geometry.Part.Cylinder()

radius = Tools.Measure.Radius.ThreeNodes(crNode13=Node(18), 
                                         crNode23=Node(14), 
                                         crNode33=Node(8))

JPT.Debugger(radius)
