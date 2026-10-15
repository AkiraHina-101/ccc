# BoundaryConditions.LBCCopy.ConnectionCopyRotate()

BoundaryConditions.LBCCopy.ConnectionCopyRotate()

説明​

回転メソッドを使用して境界条件をコピーします。

構文​

BoundaryConditions.LBCCopy.ConnectionCopyRotate(...)

リボン: BoundaryConditions » LBCCopy » ConnectionCopyRotate

入力​

iMethod​

コピー方法を指定する Integer :

0: 平行移動。コピー先はX、Y、Z方向の平行移動によって検索されます。

1: 回転。コピー先は指定軸の回転運動によって検索されます。

2: ミラー。コピー先は平面およびオフセット量によって検索されます。平面を定義するには、3つの節点または2D要素を選択します。

デフォルト値は1です。

iMatchMethod​

一致方法を指定する Integer :

0: 節点方法。この一致方法では、対象の正確な節点を一致させて一致する結果を得ます。対象の特徴が異なる場合に有用です。

1: 特徴方法。この一致方法は非常に高速で、特に大きなモデルに対して適しており、面と面、頂点と頂点などの特徴一致が必要です。

デフォルト値は0です。

posAxis​

回転軸を指定する List 型。

デフォルト値は[0,0,0]です。

posCenter​

回転中心を指定する List 型。

デフォルト値は[0,0,0]です。

dAngle​

コピー先の回転角度を指定する Double 。

デフォルト値は0です。

dTol​

一致の決定に使用される許容値を指定する Double 。

長さの単位です。

デフォルト値は1.0です。

crCoord​

座標系を指定する Cursor。

デフォルト値は None です。

crlTargets​

ターゲットを指定する List of Cursor。

デフォルト値は[]です。

戻り値​

作成されたLBCを指定する Cursor。

サンプルコード​

Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], 
                   strName="Cube_2", 
                   iPartColor=6409934)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], 
                   strName="Cube_3", 
                   iPartColor=13259210)

BoundaryConditions.FixedConstraint(crlTargets=[Face(76)])

created_lbc = BoundaryConditions.LBCCopy.LBCCopyRotate(posAxis=[0, 0.001, 0], 
                                                       posCenter=[0.015, 0.005, 0.005], 
                                                       dAngle=180.0, 
                                                       dTol=0.1, 
                                                       crlTargets=[LbcConstraint(1)])

JPT.Debugger(created_lbc)
