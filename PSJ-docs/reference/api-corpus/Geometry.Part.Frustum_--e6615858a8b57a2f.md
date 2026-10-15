# Geometry.Part.Frustum()

Geometry.Part.Frustum()

説明​

特定の位置に台形体を作成します。
その相対位置は指定されたローカル座標系に計算されます。

構文​

Geometry.Part.Frustum(...)

マクロ: CreateCylinderFrustum

リボン: Geometry » Part » Frustum

入力​

dlOrigin​

X、Y、およびZ座標（台形体の中心）を表す Double 型のリストです。

デフォルト値は [0,0,0] です。

dTopRadius​

台形体の半径をメートル単位で指定する Double です。

デフォルト値は 0.005 です。

dBottomRadius​

台形体の下端の半径（メートル単位）を指定する Double です。

デフォルト値は 0.01 です。

dHeight​

台形体の高さを指定する Double です。

デフォルト値は 0.02 です。

iCircularNodes​

両端の円周上に生成される節点の数を指定する Integer です。

デフォルト値は 20 です。

iAxialNodes​

シリンダーの軸方向に生成される節点の数を指定する Integer です。

デフォルト値は 20 です。

strName​

新しく作成されたパートの名前を指定する String です。

デフォルト値は "Frustum_1" です。

iPartColor​

新しく作成されたパートの色を指定する Integer です。

デフォルト値は 7105764 です。

crLocalCoordinate​

ローカル座標系を指定する Cursor です。

デフォルト値は None です。

戻り値​

作成されたパートを指定する Cursor です。

サンプルコード​

created_frustum = Geometry.Part.Frustum(dTopRadius=0.003, iPartColor=14903267)
JPT.Debugger(created_frustum)
