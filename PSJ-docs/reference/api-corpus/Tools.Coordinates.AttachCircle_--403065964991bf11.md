# Tools.Coordinates.AttachCircle()

Tools.Coordinates.AttachCircle()

説明​

円状エッジの中心に座標系を作成します。また、既存の座標系を修正するためにも使用できます。

構文​

Tools.Coordinates.AttachCircle(...)

リボン：Tools » Coordinates » Attach Circle Edge

入力​

strName​

座標の名前を指定する String です。

デフォルト値は "CRect1" です。

iCoordType​

座標系のタイプを指定する Integer です。以下のいずれかです：

iCoordType=0 の場合： 直交座標系 - (Oxyz) とも呼ばれる直交座標系

iCoordType=1 の場合： 円柱座標系 - (r, φ, z) 座標系で、(r, φ, z) はそれぞれ (半径方向距離, アジマス角, 軸座標または高さ z)

iCoordType=2 の場合： 球面座標系 - (r, θ, φ) 座標系で、(r, θ, φ) はそれぞれ (半径距離, アジマス角, 極角)

デフォルト値は 0 です。

crEdge​

座標の位置を計算/決定するためのエッジを指定する Cursor です。座標の位置はここで作成されます。

これは必須の入力です。

bCreateNew​

新しい座標を作成するかどうかを指定する Boolean です。この引数は、crEdit とともに使用され、crEdit が定義されている場合は、選択した座標系を基に新しい座標を作成するか、選択した座標系を修正するかを許可します。

True の場合： 新しい座標が作成されます。

False の場合： crEdit で指定された座標が修正されます。

デフォルト値は True です。

crEdit​

修正する既存の座標系を指定する Cursor です。bCreateNew が False の場合、指定された座標が修正され、bCreateNew が True の場合、新しい座標が作成されます。

デフォルト値は None です。

戻り値​

作成された座標を指定する Cursor です。

サンプル コード​

Geometry.Part.Cylinder()
Tools.Coordinates.ThreeNode(veclPoints=[[0.01, 0.01, 0.01], 
                                        [0.002, 0.002, 0.002], 
                                        [0.01, 0.001, 0.01]])

created_coord = Tools.Coordinates.AttachCircle(strName="CRect2", 
                                               crEdge=Edge(2), 
                                               crEdit=Coord(1))

JPT.Debugger(created_coord)
