# Geometry.Part.Cube()

Geometry.Part.Cube()

説明​

特定の場所に直方体のパートを作成します。この相対位置は、指定されたローカル座標系に計算されます。

構文​

Geometry.Part.Cube(...)

マクロ: CreateCube

リボン: Geometry ➡ Part ➡ Cube

入力​

dlOrigin​

起点のX、Y、Z座標を表す Double 型のリストです。

デフォルト値は [0.0, 0.0, 0.0] です。

dlLength​

X軸、Y軸、Z軸方向のメートル単位での直方体の長さを指定する Double 型のリストです。

デフォルト値は [0.01, 0.01, 0.01] です。

ilAxialNodes​

X軸、Y軸、Z軸それぞれに沿った節点の数を指定する Integer のリストです。

デフォルト値は [10, 10, 10] です。

strName​

新しく作成された部分の名前を指定する String です。

デフォルト値は "Cube_1" です。

iPartColor​

新しく作成された部分の色を指定する Integer です。

デフォルト値は 7105764 です。

crLocalCoordinate​

ローカル座標系を指定する Cursor です。

デフォルト値は None です。

戻り値​

成功した場合は直方体の Cursor、失敗した場合は None です。

サンプルコード​

created_cube = Geometry.Part.Cube(dlOrigin=[0.005, 0.005, 0.005], 
                                  strName="Cube_1", 
                                  iPartColor=13259210)
JPT.Debugger(created_cube)
