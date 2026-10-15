# Tools.Measure.Volume()

Tools.Measure.Volume()

説明​

指定されたパートの体積を計測します。

構文​

Tools.Measure.Volume(...)

リボン: Tools » Measure » Volume

入力​

crlParts​

体積を計測するパートを指定する Cursor のリストです。

これは必須の入力です。

iPrecision​

浮動小数点の後の桁数を指定する Integer です。iPrecision が大きいほど、体積の精度が高くなります。

デフォルト値は6です。

戻り値​

体積値を指定する Double です。

サンプルコード​

Geometry.Part.Cylinder()

volume = Tools.Measure.Volume(crlParts=[Part(1)])

JPT.Debugger(volume)
