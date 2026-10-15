# Tools.Coordinates.Rotate()

Tools.Coordinates.Rotate()

説明​

指定された値で回転して座標系を作成します。また、既存の座標系を変更するためにも使用できます。

構文​

Tools.Coordinates.Rotate(...)

マクロ: CreateCoordinateRotate

リボン: Tools » Coordinates » Rotate

入力​

strName​

座標の名前を指定する String 。

デフォルト値は "CRect1" です。

iCoordType​

座標系のタイプを指定する Integer で、以下のいずれかです：

iCoordType=0 の場合：直交座標系 - カルテシアン座標系（Oxyz）

iCoordType=1 の場合：円柱座標系 - (r, φ, z) 座標系を表し、(r, φ, z) はそれぞれ（動径距離、方位角、軸座標または高さ z）です

iCoordType=2 の場合：球座標系 - (r, θ, φ) 座標系を表し、(r, θ, φ) はそれぞれ（動径距離、方位角、極角）です

デフォルト値は 0 です。

vecRotate​

回転ベクトルを指定する Vector 型。このベクトルの各成分は座標を軸 x、y、z 周りに回転させる度数を指定します。この引数の単位は度（°）です。

デフォルト値は [0.0,0.0,0.0] です。

bCreateNew​

新しい座標を作成するかどうかを指定する Boolean 型。この引数は crEdit と一緒に使用され、crEdit が定義されている場合、引数 bCreateNew は選択した座標系を基に新しい座標を作成するか、選択した座標系を変更するかを許可するために使用されます。

True の場合：新しい座標が作成されます。

False の場合：crEdit で指定された座標が変更されます。

デフォルト値は True です。

crRefCoord​

回転する座標を指定する Cursor 型。vecRotate で指定された角度はこの参照座標から計算されます。

デフォルト値は None（グローバル座標）です。

posCenterRot​

回転中心の位置を指定する Position 型。

デフォルト値は None です。

crEdit​

変更する既存の座標系を指定する Cursor 型。bCreateNew が False の場合、この指定された座標系が変更されます。また、bCreateNew が True の場合、新しい座標が作成されます。

デフォルト値は None です。

戻り値​

作成された座標を指定する Cursor 型。

サンプルコード​

Geometry.Part.Cube()
Tools.Coordinates.ThreeNode(crlNodes=[Node(7, 
                                           63, 
                                           87)])

created_coord = Tools.Coordinates.Rotate(vecRotate=[59.9886811502157, 0.0, 0.0], 
                                         bCreateNew=False,
                                         crRefCoord=Coord(1),
                                         posCenterRot=None, 
                                         crEdit=Coord(1))

JPT.Debugger(created_coord)
