# Geometry.Part.Sphere()

Geometry.Part.Sphere()

概要​

特定の場所に球体を作成します。
その相対位置は指定されたローカル座標系に計算されます。

構文​

Geometry.Part.Sphere(...)

マクロ: CreateSphere

リボン: Geometry » Part » Sphere

入力​

dlOrigin​

球の中心（原点）のX、Y、Z座標を表す Double 型のリストです。

デフォルト値は [0,0,0] です。

dRadius​

球の半径をメートル単位で指定する Double です。

デフォルト値は 0.005 です。

iLatitudeDivisions​

経度方向に生成される節点の数を指定する Integer です。

デフォルト値は 20 です。

iLongitudeDivisions​

緯度方向に生成される節点の数を指定する Integer です。

デフォルト値は 20 です。

strName​

作成するパートの名前を指定する String です。

デフォルト値は "Sphere_1" です。

iPartColor​

作成するパートの色を指定する Integer です。

デフォルト値は 7105764 です。

crLocalCoordinate​

ローカル座標系を指定する Cursor です。

デフォルト値は None です。

戻り値​

作成プロセスの状態によって戻り値が異なります:

Cursor: 球が正常に作成されました。

None: 球を作成できません。

サンプルコード​

sphere = Geometry.Part.Sphere(dlOrigin=[0.005, 0.0, 0.0], iPartColor=13259210)
JPT.Debugger(sphere)
