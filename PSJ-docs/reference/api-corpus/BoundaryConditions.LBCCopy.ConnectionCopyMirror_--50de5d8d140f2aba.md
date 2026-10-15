# BoundaryConditions.LBCCopy.ConnectionCopyMirror()

BoundaryConditions.LBCCopy.ConnectionCopyMirror()

説明​

ミラーメソッドを使用して境界条件をコピーします。

構文​

BoundaryConditions.LBCCopy.ConnectionCopyMirror(...)

リボン: BoundaryConditions » LBCCopy » ConnectionCopyMirror

入力​

iMethod​

コピー方法を指定する Integer :

0: 平行移動。コピー先はX、Y、Z方向の平行移動によって検索されます。

1: 回転。コピー先は指定軸の回転運動によって検索されます。

2: ミラー。コピー先は平面およびオフセット量によって検索されます。平面を定義するには、3つの節点または2D要素を選択します。

デフォルト値は2です。

iMatchMethod​

一致方法を指定する Integer :

0: 節点方法。この一致方法は正確な節点を一致させることで一致結果を取得します。ターゲットの特徴が異なる場合に便利です。

1: 特徴量方法。この一致方法は非常に高速であり、大きなモデルに特に適しており、面と面、頂点と頂点などの特徴マッチングが必要です。

デフォルト値は0です。

poslPoints​

リストを指定する ネストしたリスト 。ミラーの中心線を作成する点のリストを指定します。

デフォルト値は[]です。

dOffset​

長さのユニットでミラーのオフセット値を指定する Double 。

デフォルト値は0.0です。

dTol​

一致の決定に使用する許容値を指定する Double 。

デフォルト値は1.0です。

crlTargets​

ターゲットのリストを指定する Cursor のリスト。

デフォルト値は[]です。

戻り値​

作成されたLBCを指定する Cursor 。

サンプルコード​

Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], 
                   strName="Cube_2", 
                   iPartColor=6409934)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], 
                   strName="Cube_3", 
                   iPartColor=13259210)

BoundaryConditions.FixedConstraint(crlTargets=[Face(76)])

MeshEdit.CreateNode.Between2Nodes(iNodeID=1465, 
                                  dX=1.5e-05, 
                                  dY=1e-05, 
                                  dZ=1e-05, 
                                  iNumberofNodes=1, 
                                  crlNodes=[Node(581, 580)])
MeshEdit.CreateNode.Between2Nodes(iNodeID=1466, 
                                  dX=1.5e-05, 
                                  dY=1e-05, 
                                  iNumberofNodes=1, 
                                  crlNodes=[Node(517, 516)])
MeshEdit.CreateNode.Between2Nodes(iNodeID=1467, 
                                  dX=1.5e-05, 
                                  dZ=1e-05, 
                                  iNumberofNodes=1, 
                                  crlNodes=[Node(565, 564)])

created_lbc = BoundaryConditions.LBCCopy.LBCCopyMirror(poslPoints=[[0.015, 0, 0.01], 
                                                                   [0.015, 0.01, 0.01], 
                                                                   [0.015, 0.01, 0]], 
                                                       dTol=0.1, 
                                                       crlTargets=[LbcConstraint(1)])

JPT.Debugger(created_lbc)
