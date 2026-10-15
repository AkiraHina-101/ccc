# Connections.RigidElements.RBE2.ToCenter()

Connections.RigidElements.RBE2.ToCenter()

説明​

1対多（マスター：スレーブ）間でRBE2（剛体要素）を作成します。

構文​

Connections.RigidElements.RBE2.ToCenter(...)

マクロ: RBE2ToCenter

リボン: Connections » RigidElements » RBE2 » ToCenter

入力​

iMethod​

接続方法を指定する Integer です。

デフォルト値は 18 です。

crlMasterTargets​

マスターターゲットを指定する Cursor リストです。

デフォルト値は[]です。

crlSlaveTargets​

スレーブターゲットを指定する Cursor リストです。スレーブターゲットはパート、フェース、エッジ、要素、または節点を選択できます。

デフォルト値は[]です。

iEType​

接続タイプを指定する Integer です。

デフォルト値は 2 です。

strName​

作成するRBE2の名前を指定する String です。

デフォルト値は "RBE2_1" です。

crCoordSys​

座標系を指定する Cursor です。

デフォルト値は None です。

dTolerance​

トレランスを指定する Double です。

デフォルト値は 0.0 です。

iUlDOFs​

依存する自由度の要素を指定する Integer です。

デフォルト値は 63 です。

dlVirtualNodePos​

マスター節点の位置を指定する Double List です。

デフォルト値は [0, 0, 0] です。

iSurfaceDef​

表面の定義方法を指定する Integer です。

0: 節点セットによる - 節点を参照表面として指定します。

1: 要素セットによる - 要素を参照表面として指定します。スレーブエンティティ（節点、エッジ）に要素を構成できない場合は、選択するとエラーが出力されます。

デフォルト値は 0 です。

crEdit​

既存のRBE2接続を指定する Cursor です

このパラメータを使用すると、指定されたRBE2接続が修正されます。

Noneにした場合は新しいRBE2が作成されます。

デフォルト値は None です。

iEnableUpdateDispCS​

変位座標系を更新するかどうかを指定する Integer です。

デフォルト値は 1 です。

iEnableCornerOnly​

選択したエンティティの角の節点にのみ接続するかどうかを指定する Integer です。

デフォルト値は 0 です。

iEnableCheckDuplicate​

重複をチェックするかどうかを指定する Integer です。

デフォルト値は 1 です。

iDuplicateMode​

重複モードを指定する Integer です。

デフォルト値は 0 です。

戻り値​

作成されたRBE2を指定する Cursor です。

サンプルコード​

# モデルを準備
Geometry.Part.Cube(iPartColor=6409934)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], strName="Cube_2", iPartColor=7463537)

# 接続を作成
rbe2_connection = Connections.RigidElements.RBE2.ToCenter(crlSlaveTargets=[Node(496, 493, 489, 492, 7, 6, 2, 3)], 
                                         iUlDOFs=45, dlVirtualNodePos=[0.015, 0.005, 0.005], iEnableCornerOnly=1)
JPT.Debugger(rbe2_connection)
