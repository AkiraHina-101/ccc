# Connections.RigidElements.RBar.OneToOneNodesWithTolerance()

Connections.RigidElements.RBar.OneToOneNodesWithTolerance()

説明​

許容差範囲内の節点間に、1対1の（マスター:スレーブ）RBar（剛体要素）を作成します。

構文​

Connections.RigidElements.RBar.OneToOneNodesWithTolerance(...)

マクロ：RBarOneToOneNodesWithTolerance

リボン：Connections » RigidElements » RBar » OneToOneNodesWithTolerance

入力​

strName​

作成されるRBarの名前を指定する String 。

デフォルト値は "RBAR_1" です。

crlMasterTargets​

マスターターゲットを指定する Cursor リスト。

マスターターゲットは節点のみで選択できます。

デフォルト値は [] です。

crlSlaveTargets​

スレーブターゲットを指定する Cursor リスト。

スレーブターゲットは節点のみで選択できます。

デフォルト値は [] です。

iMethod​

接続方法を指定する Integer 。

デフォルト値は 21 です。

iUlDOFs​

マスターの自由度を指定する Integer 。

この機能は、マスターで選択された節点の独立した自由度のすべての成分が固定されている場合のみサポートされます。

デフォルト値は 0 です。

dTol​

許容差を指定する Double 。

デフォルト値は DFLT_DBL です。

crCoord​

座標系を指定する Cursor。

デフォルト値は None です。

bUpdateDispCS​

変位座標系の更新の有無を指定するブール型。

Trueの場合、変位座標系が更新されます。

Falseの場合、変位座標系は更新されません。

デフォルト値は True です。

crEdit​

既存のRbarを指定する Cursor。

このパラメータを使用すると、指定されたRbarが修正されます。

Noneの場合、新しいRbarが作成されます。

デフォルト値は None です。

戻り値​

作成されたRbarを指定する Cursor。

サンプルコード​

# モデルの準備
Geometry.Part.Cube(iPartColor=6409934)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], strName="Cube_2", iPartColor=7463537)

# 接続を作成
rbar_connection = Connections.RigidElements.RBar.OneToOneNodesWithTolerance(strName="RBar_1", 
                    crlMasterTargets=[Node(496, 7)], iUlDOFs=63, dTol=0.012, bUpdateDispCS=True)
JPT.Debugger(rbar_connection)
