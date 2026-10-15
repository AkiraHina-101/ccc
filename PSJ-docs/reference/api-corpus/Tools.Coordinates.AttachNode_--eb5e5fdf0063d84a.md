# Tools.Coordinates.AttachNode()

Tools.Coordinates.AttachNode()

説明​

特定の節点に座標系を作成します。また、既存の座標系を修正するためにも使用できます。

構文​

Tools.Coordinates.AttachNode(...)

リボン: Tools » Coordinates » Attach Node

入力​

strName​

座標の名前を指定する String です。

デフォルト値は "CRect1" です。

iCoordType​

座標系の種類を指定する Integer です。次のうちのいずれかです：

iCoordType=0 の場合：長方形座標 - 通常デカルト座標系（Oxyz）

iCoordType=1 の場合：円柱座標 - （r, φ, z）座標系で、（r, φ, z）はそれぞれ（半径距離、方位角、軸座標または高さ z）です

iCoordType=2 の場合：球座標 - （r, θ, φ）座標系で、（r, θ, φ）はそれぞれ（半径距離、方位角、極角）です

デフォルト値は 0 です。

crNode​

座標が作成される節点を指定する Cursor です。

これは必須の入力です。

bCreateNew​

新しい座標を作成するかどうかを指定する Boolean です。この引数は crEdit に続けて使用され、crEdit が定義されているとき、引数 bCreateNew は選択した座標系に基づいて新しいものを作成するか、選択された座標系を単に修正するかを許可します。

True の場合：新しい座標が作成されます。

False の場合：crEdit で指定された座標が修正されます。

デフォルト値は True です。

crEdit​

修正する既存の座標系を指定する Cursor です。bCreateNew が False の場合、指定された座標は crNode で指定された節点に移動されます。bCreateNew が True の場合、新しい座標が作成されます。

デフォルト値は None です。

戻り値​

作成された座標を指定する Cursor です。

サンプルコード​

Geometry.Part.Cylinder()
Tools.Coordinates.ThreeNode(veclPoints=[[0.01, 0.01, 0.01], 
                                        [0.002, 0.002, 0.002], 
                                        [0.01, 0.001, 0.01]])

created_coord = Tools.Coordinates.AttachNode(strName="CRect3", 
                                             crNode=Node(141), 
                                             crEdit=Coord(1))

JPT.Debugger(created_coord)
