# Connections.MPC.General.TwoFaces()

Connections.MPC.General.TwoFaces()

説明​

2 つのフェース間で MPC を作成します。

構文​

Connections.MPC.General.TwoFaces(...)

マクロ: Mpc

リボン: Connections » MPC » General » TwoFaces

入力​

strName​

MPC の名前を指定する String です。

デフォルト値は "MPC_1" です。

crMasterFace​

マスターフェースを指定する Cursor です。カップル crMasterFace, crSlaveFace および crMPCConnection 引数は相互に排他的です。これらのうちの 1 つを指定する必要があります。

デフォルト値は None です。

crSlaveFace​

スレーブフェースを指定する Cursor です。カップル crMasterFace, crSlaveFace および crMPCConnection 引数は相互に排他的です。これらのうちの 1 つを指定する必要があります。

デフォルト値は None です。

listMpcConnection​

MPC 接続データ型のペアを指定する List of MPC_CONNECTION です。

デフォルト値は [] です。

iLocalCoordinate​

ローカル座標系を指定する Integer です。

デフォルト値は 0 です。

bUpdateDispCS​

選択されたフェースに属する節点の変位座標系を指定したローカル座標系に更新するかどうかを指定する Boolean です。

True の場合、変位座標系が更新されます。

False の場合、変位座標系は更新されません。

デフォルト値は True です。

crMPCConnection​

編集用の既存の MPC を指定する Cursor です。カップル crMasterFace, crSlaveFace および crMPCConnection 引数は相互に排他的です。これらのうちの 1 つを指定する必要があります。

このパラメータを使用すると、指定された既存の MPC アイテムが修正されます。

None の場合、新しい MPC アイテムが作成されます。

デフォルト値は None です。

戻り値​

作成または変更された MPC 接続 (2 フェース) を指定する Cursor です。

サンプルコード​

Geometry.Part.Cube(iPartColor=7666683)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], 
                   strName="Cube_2", 
                   iPartColor=12867524)

created_mpc = Connections.MPC.General.TwoFaces(strName="MPC_12", 
                                               crMasterFace=Face(49),
                                               crSlaveFace=Face(24), 
                                               listMpcConnection=[MPC_CONNECTION(iDof=1), 
                                                                  MPC_CONNECTION(iDof=2),
                                                                  MPC_CONNECTION(iDof=4), 
                                                                  MPC_CONNECTION(), 
                                                                  MPC_CONNECTION(),
                                                                  MPC_CONNECTION()], 
                                               bUpdateDispCS=1)

JPT.Debugger(created_mpc)
