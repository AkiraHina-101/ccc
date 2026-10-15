# Connections.MPC.General.TwoEdges()

Connections.MPC.General.TwoEdges()

説明​

2つのエッジ間にMPCを作成します。

構文​

Connections.MPC.General.TwoEdges(...)

マクロ: Mpc

リボン: Connections » MPC » General » TwoEdges

入力​

strName​

MPCの名前を指定する String です。

デフォルト値は "MPC_1" です。

crMasterEdge​

接続する必要のあるマスターエッジのリストを指定する Cursor リストです。

これは必須の入力です。

crSlaveEdge​

接続する必要のあるスレーブエッジのリストを指定する Cursor リストです。

これは必須の入力です。

listMpcConnection​

MPC接続のリストを指定する MPC_CONNECTION のリストです。

デフォルト値は [] です。

iLocalCoordinate​

ローカル座標系を指定する Integer です。

デフォルト値は 0 です。

bUpdateDispCS​

変位座標系を更新するかどうかを指定する Boolean です。

True の場合、変位座標系が更新されます。

False の場合、変位座標系は更新されません。

デフォルト値は True です。

crMPCConnection​

既存のMPC接続を指定する Cursor です。

このパラメータが使用されると、指定されたMPC接続が変更されます。

None のままにすると、新しいMPC接続が作成されます。

デフォルト値は None です。

戻り値​

作成されたか修正されたMPC接続を指定する Cursor です。

サンプルコード​

Geometry.Part.Cube(iPartColor=7666683)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], 
                   strName="Cube_2", 
                   iPartColor=12867524)

created_mpc = Connections.MPC.General.TwoEdges(strName="MPC_11", 
                                               crMasterEdge=Edge(46),
                                               crSlaveEdge=Edge(10), 
                                               listMpcConnection=[MPC_CONNECTION(iDof=1), 
                                                                  MPC_CONNECTION(iDof=2),
                                                                  MPC_CONNECTION(iDof=4), 
                                                                  MPC_CONNECTION(iDof=8), 
                                                                  MPC_CONNECTION(),
                                                                  MPC_CONNECTION(iDof=32)], 
                                               bUpdateDispCS=1)

JPT.Debugger(created_mpc)
