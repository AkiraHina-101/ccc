# BoundaryConditions.LBCCopy.ConnectionCopyTranslate()

BoundaryConditions.LBCCopy.ConnectionCopyTranslate()

説明​

平行移動メソッドを利用して境界条件をコピーします。

構文​

BoundaryConditions.LBCCopy.ConnectionCopyTranslate(...)

リボン: BoundaryConditions » LBCCopy » ConnectionCopyTranslate

入力​

iMethod​

コピー方法を指定する Integer :

0: 平行移動。コピー先はX、Y、Z方向の平行移動によって検索されます。

1: 回転。コピー先は指定軸の回転運動によって検索されます。

2: ミラー。コピー先は平面およびオフセット量によって検索されます。平面を定義するには、3つの節点または2D要素を選択します。

デフォルト値は0です。

iMatchMethod​

一致方法を指定する Integer :

0: 節点メソッド。この一致方法は、対象の正確な節点を一致させて一致結果を取得します。対象の特徴が異なる場合に便利です。

1: 特徴メソッド。この一致方法は、特徴の一致のために面と面、頂点と頂点のような高速な一致を行います。特に大きなモデルに対して効果的です。

デフォルト値は0です。

posVecTrans​

移動ベクトルを指定する List 型。

デフォルト値は[0,0,0]です。

dMagnitude​

移動先の移動距離の大きさを指定する Double 。

デフォルト値は1.0です。

dTrandataDoffset​

trandataオフセットを指定する Double 。

デフォルト値は0.0です。

dTol​

一致判定に使用される許容値を指定する Double 。

長さの単位。

デフォルト値は1.0です。

crCoord​

座標系を指定する Cursor 型。

デフォルト値は None です。

crlTargets​

対象のリストを指定する List of Cursor 型。

デフォルト値は[]です。

戻り値​

作成されたLBCsを指定する Cursor 型。

サンプルコード​

Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], 
                   strName="Cube_2", 
                   iPartColor=6409934)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], 
                   strName="Cube_3", 
                   iPartColor=13259210)

BoundaryConditions.FixedConstraint(crlTargets=[Face(76)])

created_lbc = BoundaryConditions.LBCCopy.LBCCopyTranslate(posVecTrans=[-0.001, 0, 0], 
                                                          dMagnitude=0.03, 
                                                          dTol=0.1, 
                                                          crlTargets=[LbcConstraint(1)])

JPT.Debugger(created_lbc)
