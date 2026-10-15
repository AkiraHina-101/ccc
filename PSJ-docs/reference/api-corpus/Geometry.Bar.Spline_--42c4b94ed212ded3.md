# Geometry.Bar.Spline()

Geometry.Bar.Spline()

説明​

選択した節点を通過するスプライン曲線バーパートを作成します。

構文​

Geometry.Bar.Spline(...)

リボン：Geometry » Bar » Spline

入力​

crlNodes​

カーソルのリストであり、曲線を通過する節点（補間点）の系列を指定します。少なくとも3つの節点を指定する必要があります。

これは必須の入力です。

crPart​

スプラインバーが所属するパートを指定するカーソルです。指定しない場合、新しいバーパートが作成されます。

デフォルト値は None です。

strName​

新しいバーパートの名前を指定する文字列です。

デフォルト値は "Bar_1" です。

戻り値​

作成したエンティティを指定するカーソルです。

もし crPart = None の場合、新しく作成されたバーパートのカーソルを返します。

もし crPart が指定される場合、新しく作成されたエッジのカーソルを返します。

サンプルコード​

Geometry.Part.Cube()

newBar = Geometry.Bar.Spline(crlNodes=[Node(440, 463, 443, 474)])
JPT.Debugger(newBar)
