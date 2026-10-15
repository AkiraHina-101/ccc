# Tools.Measure.Area.Face()

Tools.Measure.Area.Face()

説明​

フェースの面積または複数のフェースの総面積を測定します。

構文​

Tools.Measure.Area.Face(...)

リボン: Tools » Measure » Area » Face

入力​

crlFaces​

面積を測定するフェースのリストを指定する Cursor リスト。

この入力は必須です。

iPrecision​

浮動小数点の桁数を指定する Integer 。

iPrecision が大きいほど、面積の精度が向上します。

デフォルト値は 6 です。

戻り値​

フェースの面積値または複数のフェースの総面積値を指定する Double。

サンプルコード​

Geometry.Part.Cube()

area = Tools.Measure.Area.Face(crlFaces=[Face(26)])

JPT.Debugger(area)
