# Connections.MPC.General.NodeToEdges()

Connections.MPC.General.NodeToEdges()

説明​

節点と複数のエッジ間でMPCを作成します。

構文​

Connections.MPC.General.NodeToEdges(...)

マクロ: Mpc

リボン: Connections » MPC » General » NodeToEdges

入力​

strName​

MPCの名前を指定する String です。

デフォルト値は "MPC_1" です。

crMaster​

接続する必要のある一意のマスター節点を指定する Cursor です。

この入力は必須です。

crlSlaveEdges​

接続する必要のある奴隷エッジのリストを指定する Cursor リストです。マスター節点は奴隷エッジ上の全節点に接続します。

この入力は必須です。

listMpcConnection​

MPC接続のリストを指定する MPC_CONNECTION リストです。

デフォルト値は [] です。

iLocalCoordinate​

ローカル座標系を示す Integer です。

デフォルト値は 0 です。

bUpdateDispCS​

変位座標系を更新するかどうかを指定する Boolean です。

True の場合、変位座標系が更新されます。

False の場合、変位座標系は更新されません。

デフォルト値は True です。

crMPCConnection​

既存のMPC接続を指定する Cursor です。

このパラメータを使用すると、指定されたMPC接続が変更されます。

None のままにすると、新しいMPC接続が作成されます。

デフォルト値は None です。

戻り値​

作成されたか変更されたMPC接続を示す Cursor です。

サンプルコード​

Geometry.Part.Cube(iPartColor=7666683)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], 
                   strName="Cube_2", 
                   iPartColor=12867524)

created_mpc = Connections.MPC.General.NodeToEdges(strName="MPC_8", 
                                                  crMasterNode=Node(749),
                                                  crlSlaveEdges=[Edge(18)], 
                                                  listMpcConnection=[MPC_CONNECTION(iDof=1), 
                                                                     MPC_CONNECTION(iDof=2),
                                                                     MPC_CONNECTION(iDof=4), 
                                                                     MPC_CONNECTION(), 
                                                                     MPC_CONNECTION(), 
                                                                     MPC_CONNECTION()],
                                                  bUpdateDispCS=1)

JPT.Debugger(created_mpc)
