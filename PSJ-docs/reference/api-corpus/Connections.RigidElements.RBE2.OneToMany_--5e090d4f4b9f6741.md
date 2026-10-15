# Connections.RigidElements.RBE2.OneToMany()

Connections.RigidElements.RBE2.OneToMany()

説明​

1対多（マスター:スレーブ）の RBE2（剛体要素）を作成します。

構文​

Connections.RigidElements.RBE2.OneToMany(...)

マクロ: RBE2OneToMany

リボン: Connections » RigidElements » RBE2 » OneToMany

入力​

iMethod​

接続方法を指定する Integer です。

デフォルト値は16です。

crlMasterTargets​

マスターターゲットを指定する Cursor のリストです。マスターターゲットはパート、フェース、エッジ、要素、または節点で選択できます。

デフォルト値は [] です。

crlSlaveTargets​

スレーブターゲットを指定する Cursor のリストです。スレーブターゲットはパート、フェース、エッジ、要素、または節点で選択できます。

デフォルト値は [] です。

iEType​

接続タイプを指定する Integer です。

デフォルト値は2（RBE2）です。

strName​

作成するRBE2の名前を指定する String です。

デフォルト値は "RBE2_1" です。

crCoordSys​

座標系を指定する Cursor です。

デフォルト値は None です。

dTolerance​

許容差を指定する Double です。

デフォルト値は0.0です。

iUlDOFs​

依存度合いの要素数を指定する Integer です。

デフォルト値は63です。

dlVirtualNodePos​

バーチャル節点の位置を指定する Double のリストです。

デフォルト値は [0, 0, 0] です。

iSurfaceDef​

表面定義の出力方法を指定する Integer です。

0: 節点セットから指定 - 節点を参照表面として指定します。

1: 要素セットから指定 - 要素を参照表面として指定します。スレーブエンティティ（節点、エッジ）に要素を構成できず、選択した場合はエラーが出力されます。

デフォルト値は0です。

crEdit​

既存のRBE2接続を指定する Cursor です。

このパラメータを使用すると、指定されたRBE2接続が変更されます。

None のままにすると、新しいRBE2が作成されます。

デフォルト値は None です。

iEnableUpdateDispCS​

変位座標系を更新するかどうかを指定する Integer です。

デフォルト値は1です。

iEnableCornerOnly​

選択したエンティティの角節点のみに接続するかどうかを指定する Integer です。

デフォルト値は0です。

iEnableCheckDuplicate​

重複をチェックするかどうかを指定する Integer です。

デフォルト値は1です。

iDuplicateMode​

重複モードを指定する Integer です。

デフォルト値は0です。

戻り値​

作成されたRBE2接続を指定する Cursor です。

サンプルコード​

# モデルの準備
Geometry.Part.Cube(iPartColor=6409934)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], strName="Cube_2", iPartColor=7463537)

# 接続を作成します
rbe2_connection = Connections.RigidElements.RBE2.OneToMany(crlMasterTargets=[Node(496)], 
        crlSlaveTargets=[Face(24)], strName="RBE2_2", iUlDOFs=7, iEnableCornerOnly=1)
JPT.Debugger(rbe2_connection)
