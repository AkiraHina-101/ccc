# Connections.RigidElements.RBar.OneToOne()

Connections.RigidElements.RBar.OneToOne()

説明​

1対1（マスター：スレーブ）のRBar（剛体要素）を作成します。

構文​

Connections.RigidElements.RBar.OneToOne(...)

マクロ：RBarOneToOne

リボン：Connections » RigidElements » RBar » OneToOne

入力​

strName​

作成するRBarの名前を指定する String です。

デフォルト値は"RBAR_1" です。

crlMasterTargets​

マスターターゲットを指定する Cursor のリストです。マスターターゲットはパート、フェース、エッジ、要素、または節点で選択できます。

デフォルト値は [] です。

crlSlaveTargets​

スレーブターゲットを指定する Cursor のリストです。スレーブターゲットはパート、フェース、エッジ、要素、または節点で選択できます。

デフォルト値は [] です。

iMethod​

接続方法を指定する Integer です。

デフォルト値は17 です。

iUlDOFs​

マスターの自由度を指定する Integer です。この機能は、マスターで選択された節点のすべての独立自由度の成分が固定されている場合のみサポートします。

デフォルト値は0 です。

dTol​

許容差を指定する Double です。

デフォルト値はDFLT_DBL です。

crCoord​

座標系を指定する Cursor です。

デフォルト値は None です。

bUpdateDispCS​

変位座標系を更新するかどうかを指定する Boolean です。

True の場合、変位座標系が更新されます。

False の場合、変位座標系は更新されません。

デフォルト値は True です。

crEdit​

既存のRbarを指定する Cursor です

このパラメーターを使用すると、指定されたRbarが修正されます。

None の場合は、新しいRbarが作成されます。

デフォルト値は None です。

戻り値​

作成されたRbarを指定する Cursor です。

サンプルコード​

# モデルを準備
Geometry.Part.Cube(iPartColor=6409934)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], strName="Cube_2", iPartColor=7463537)

# 接続を作成
rbar_connection = Connections.RigidElements.RBar.OneToOne(strName="RBar_1", crlMasterTargets=[Node(496)], 
                                    crlSlaveTargets=[Node(7)], iUlDOFs=63, dTol=0.0, bUpdateDispCS=True)
JPT.Debugger(rbar_connection)
