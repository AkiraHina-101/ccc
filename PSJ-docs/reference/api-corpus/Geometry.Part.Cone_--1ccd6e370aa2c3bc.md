# Geometry.Part.Cone()

Geometry.Part.Cone()

説明​

特定の位置に円錐体を作成します。
その相対位置は指定されたローカル座標系に計算されます。

構文​

Geometry.Part.Cone(...)

マクロ：CreateCone

リボン：Geometry » Part » Cone

入力​

dlOrigin​

X、Y、およびZ座標を指定する Double のリストです。

デフォルト値は[0.0,0.0,0.0]です。

dBottomRadius​

ボトムフェースの半径をメートルで指定する Double です。

デフォルト値は0.01です。

dHeight​

円錐の高さをメートルで指定する Double です。

デフォルト値は0.02です。

iCircularNodes​

アーク上に生成される節点の数を指定する Integer です。

デフォルト値は20です。

iAxialNodes​

シリンダの軸方向に生成される節点の数を指定する Integer です。

デフォルト値は20です。

strName​

作成する円錐の名前を指定する String です。

デフォルト値は "Cone_1" です。

iPartColor​

新しく作成されたパートの色を指定する Integer です。

デフォルト値は7105764です。

crLocalCoordinate​

ローカル座標系を指定する Cursor です。

デフォルト値は None です。

戻り値​

作成プロセスのステータスに応じて戻り値が異なります：

Cursor：円錐が正常に作成されました。

None：円錐を作成できません。

サンプルコード​

cone = Geometry.Part.Cone(dlOrigin=[0.005, 0.005, 0.005], iPartColor=7829501)
JPT.Debugger(cone)
