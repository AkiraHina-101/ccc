# Connections.MPC.General.NodeToFaces()

Connections.MPC.General.NodeToFaces()

説明​

節点と複数のフェースの間に MPC を作成します。

構文​

Connections.MPC.General.NodeToFaces(...)

マクロ: Mpc

リボン: Connections » MPC » General » NodeToFaces

入力​

strName​

MPC 名を指定する String です。

デフォルト値は "MPC_1" です。

crMasterNode​

接続が必要な一意のマスター節点を指定する Cursor です。

これは必須の入力です。

crlSlaveFaces​

接続が必要な奴隷フェースのリストを指定する List of Cursor です。マスター節点は奴隷フェースのエッジ上の全ての節点に接続されます。

これは必須の入力です。

listMpcConnection​

MPC 接続のリストを指定する List of MPC_CONNECTION です。

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

既存の MPC 接続を指定する Cursor です。

このパラメータを使用すると、指定された MPC 接続が変更されます。

None の場合、新しい MPC 接続が作成されます。

デフォルト値は None です。

戻り値​

作成された MPC 接続を指定する Cursor です。

サンプルコード​

Geometry.Part.Cube(iPartColor=7666683)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], 
                   strName="Cube_2", 
                   iPartColor=12867524)

created_mpc = Connections.MPC.General.NodeToFaces(strName="MPC_9", 
                                                  crMasterNode=Node(758),
                                                  crlSlaveFaces=[Face(24)], 
                                                  listMpcConnection=[MPC_CONNECTION(iDof=1), 
                                                                     MPC_CONNECTION(iDof=2),
                                                                     MPC_CONNECTION(iDof=4), 
                                                                     MPC_CONNECTION(), 
                                                                     MPC_CONNECTION(), 
                                                                     MPC_CONNECTION()],
                                                  bUpdateDispCS=1)

JPT.Debugger(created_mpc)
