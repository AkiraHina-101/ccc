# Connections.MPC.General.FacesToFaces()

Connections.MPC.General.FacesToFaces()

説明​

選択したフェースを接続して MPC を作成します。

構文​

Connections.MPC.General.FacesToFaces(...)

マクロ: Mpc

リボン: Connections » MPC » General » FacesToFaces

入力​

strName​

MPC の名前を指定する String です。

デフォルト値は "MPC_1" です。

crlMasterFaces​

接続する必要があるマスターフェースのリストを指定する Cursor のリストです。マスターリストには 1 つ以上のフェースが含まれます。

マスターリストに複数のフェースが含まれる場合、マスターフェースとスレーブフェースの数は等しくなければなりません。MPC は選択したマスターフェースを選択したスレーブフェースと 1 つずつ対応して接続して作成されます。

これは必須の入力です。

crlSlaveFaces​

接続する必要があるスレーブフェースのリストを指定する Cursor のリストです。スレーブリストには 1 つ以上のフェースが含まれます。

スレーブリストに複数のフェースが含まれる場合、スレーブフェースとマスターフェースの数は等しくなければなりません。MPC は選択したマスターフェースと選択したスレーブフェースを 1 つずつ対応して接続して作成されます。

これは必須の入力です。

listMpcConnection​

MPC 接続のリストを指定する MPC_CONNECTION のリストです。

デフォルト値は [] です。

iLocalCoordinate​

ローカル座標系を指定する Integer です。

デフォルト値は 0 です。

bUpdateDispCS​

変位座標系の更新を指定する Boolean です。

True の場合、変位座標系が更新されます。

False の場合、変位座標系は更新されません。

デフォルト値は True です。

crMPCConnection​

既存の MPC 接続を指定する Cursor です。

このパラメータが使用される場合、指定された MPC 接続が修正されます。

None の場合は新しい MPC 接続が作成されます。

デフォルト値は None です。

戻り値​

作成または修正された MPC 接続を指定する Cursor です。

サンプルコード​

Geometry.Part.Cube(iPartColor=7666683)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], 
                   strName="Cube_2", 
                   iPartColor=12867524)

created_mpc = Connections.MPC.General.FacesToFaces(strName="MPC_10", 
                                                   crlMasterFaces=[Face(24)],
                                                   crlSlaveFaces=[Face(49)], 
                                                   listMpcConnection=[MPC_CONNECTION(iDof=1), 
                                                                      MPC_CONNECTION(iDof=2),
                                                                      MPC_CONNECTION(iDof=4), 
                                                                      MPC_CONNECTION(), 
                                                                      MPC_CONNECTION(), 
                                                                      MPC_CONNECTION()], 
                                                   bUpdateDispCS=1, 
                                                   crMPCConnection=None)

JPT.Debugger(created_mpc)
