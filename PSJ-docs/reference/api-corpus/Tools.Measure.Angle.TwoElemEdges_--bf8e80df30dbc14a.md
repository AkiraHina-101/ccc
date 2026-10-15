# Tools.Measure.Angle.TwoElemEdges()

Tools.Measure.Angle.TwoElemEdges()

説明​

構文​

Tools.Measure.Angle.TwoElemEdges(...)

リボン: Tools » Measure » Angle » TwoElemEdges

入力​

crpElemEdge1​

要素エッジ1 - 2つの節点を指定する Cursor Pair です。

これは必須の入力です。

crpElemEdge2​

要素エッジ2 - 2つの節点を指定する Cursor Pair です。

これは必須の入力です。

strTarget​

対象を指定する String です。

デフォルト値は "Angle" です。

iPrecision​

精度を指定する Integer です。

デフォルト値は 6 です。

戻り値​

iPrecision で設定された精度で測定された値が、 String 形式で返されます。

サンプルコード​

Geometry.Part.Cube()

angle = Tools.Measure.Angle.TwoElemEdges(
            crpElemEdge1=CursorPair(Node(95), Node(487)), 
            crpElemEdge2=CursorPair(Node(453), Node(462)))

JPT.Debugger(angle)
