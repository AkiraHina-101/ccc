# Geometry.Edge.OffsetLine()

Geometry.Edge.OffsetLine()

説明​

指定されたエッジをオフセットして新しいエッジを作成します。

構文​

Geometry.Edge.OffsetLine(...)

マクロ: ImprintOffsetLineS

リボン: Geometry » Edge » Offset Line

入力​

crlFaces​

オフセットされるエッジを含む対象のフェースを指定する Cursor リストです。

この入力は必須です。

crlEdges​

オフセットするエッジを指定する Cursor リストです。

この入力は必須です。

bBreakFace​

可能であれば与えられたフェースを分割するかどうかを指定する Boolean です。

デフォルト値は True です。

dOffsetDistance​

オフセット距離を指定する Double です。

デフォルト値は 0.0 です。

iLayerNumber​

オフセットされるレイヤーの数を指定する Integer です。

デフォルト値は 1 です。

bMerge​

オフセットされたエッジがお互いの間の角度が150度より大きい場合に、オフセットされたエッジをマージするかどうかを指定する Boolean です。

デフォルト値は True です。

bExtend​

オフセットされたエッジを最寄りの境界エッジまで延長するかどうかを指定する Boolean です。

デフォルト値は True です。

iOffsetMethod​

オフセットエッジを作成する方法を指定する Integer です。

iOffsetMethod=0 の場合、オフセット距離とレイヤーの数を使用して複数のオフセットレイヤーを作成します。

iOffsetMethod=1 の場合、レイヤーオフセット距離を使用して単一のオフセットレイヤーを作成します。

デフォルト値は 0 です。

dOffsetDistance​

レイヤーオフセット距離を指定する Double 型のリスト です。

デフォルト値は [] です。

iImprintMethod​

マーキング方法を指定する Integer です。

iImprintMethod=0 の場合、オフセットエッジは最も長いエッジを持つ面の側にマーキングされます。

iImprintMethod=1 の場合、オフセットエッジは最も短いエッジを持つ面の側にマーキングされます。

iImprintMethod=2 の場合、オフセットエッジは両方の面の側にマーキングされます。

デフォルト値は 2 です。

戻り値​

新しく作成されたエッジを指定する Cursor リストです。

サンプルコード​

Geometry.Part.Cube(iPartColor=6484066)

offset_lines = Geometry.Edge.OffsetLine(crlFaces=[Face(22)], 
                                        crlEdges=[Edge(19)], 
                                        dOffsetDistance=0.001, 
                                        iLayerNumber=6)

JPT.Debugger(offset_lines)
