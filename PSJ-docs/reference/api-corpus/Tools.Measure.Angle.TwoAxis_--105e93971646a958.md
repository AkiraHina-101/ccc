# Tools.Measure.Angle.TwoAxis()

Tools.Measure.Angle.TwoAxis()

説明​

2つの軸によって作成された角度を測定します。

構文​

Tools.Measure.Angle.TwoAxis(...)

リボン：Tools » Measure » Angle » TwoAxis

入力​

dlXyz1​

xyz1を指定する Double List 型。

デフォルト値は[0, 0, 0]です。

dlXyz2​

xyz2を指定する Double List 型。

デフォルト値は[0, 0, 0]です。

strTarget​

ターゲットを指定する String 。

デフォルト値は"Angle"です。

iPrecision​

精度を指定する Integer 。

デフォルト値は6です。

戻り値​

成功時は「1」、失敗時は「0」の文字列です。

サンプルコード​

Geometry.Part.Cube()
Tools.Coordinates.ThreeNode(crlNodes=[Node(7, 8, 5)])
Tools.Coordinates.ThreeNode(strName="CRect2", crlNodes=[Node(3, 7, 2)])

angle = Tools.Measure.Angle.TwoAxis(dlXyz1=[0.0, -1.0, 0.0], dlXyz2=[1.0, 0.0, 0.0])

JPT.Debugger(angle)
