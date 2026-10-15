# BoundaryConditions.BodyLoads.CentrifugalForce.TwoPositions()

BoundaryConditions.BodyLoads.CentrifugalForce.TwoPositions()

説明​

解析モデルに遠心力荷重を作成します。

構文​

BoundaryConditions.BodyLoads.CentrifugalForce.TwoPositions(...)

リボン：BoundaryConditions » BodyLoads » CentrifugalForce » TwoPositions

入力​

crlTargets​

遠心力を作成する対象アイテムのリストを指定する Cursor リストです。

デフォルト値は[]です。

strName​

作成する遠心力荷重条件の名前を指定する String です。

デフォルト値は "CentrifugalForce1" です。

dBasePointX​

回転軸基準点のX座標を指定する Double です。

デフォルト値は 0.0 です。

dBasePointY​

回転軸基準点のY座標を指定する Double です。

デフォルト値は 0.0 です。

dBasePointZ​

回転軸基準点のZ座標を指定する Double です。

デフォルト値は 0.0 です。

dTipPointX​

回転軸先端のX座標を指定する Double です。

デフォルト値は 0.0 です。

dTipPointY​

回転軸先端のY座標を指定する Double です。

デフォルト値は 0.0 です。

dTipPointZ​

回転軸先端のZ座標を指定する Double です。

デフォルト値は 0.0 です。

dVelocity​

角速度値を指定する Double です。

デフォルト値は 0.0 です。

dAcceleration​

角加速度値を指定する Double です。

デフォルト値は 0.0 です。

iVelocityUnit​

角速度値の入力単位を指定する Integer です。

デフォルト値は 0 です。

iAccelerationUnit​

角加速度値の入力単位を指定する Integer です。

デフォルト値は 0 です。

crEdit​

既存の遠心力荷重を指定する Cursor です。このパラメータを使用すると、指定した遠心力荷重が変更されます。None のままにすると、新しい遠心力荷重が作成されます。

デフォルト値は None です。

戻り値​

作成された LBC を指定する Cursor です。

サンプルコード​

Geometry.Part.Cube()

created_lbc = BoundaryConditions.BodyLoads.CentrifugalForce.TwoPositions(crlTargets=[Part(1),
                                                                                     Node(5, 3)],
                                                                         dBasePointZ=0.01,
                                                                         dTipPointX=0.01,
                                                                         dTipPointY=0.01,
                                                                         dVelocity=10.0,
                                                                         dAcceleration=10.0)

JPT.Debugger(created_lbc)
