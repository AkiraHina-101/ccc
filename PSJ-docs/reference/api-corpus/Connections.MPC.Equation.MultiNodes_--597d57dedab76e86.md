# Connections.MPC.Equation.MultiNodes()

Connections.MPC.Equation.MultiNodes()

説明​

スレーブ節点と複数のマスター節点間のMPCコネクションを作成します。

構文​

Connections.MPC.Equation.MultiNodes(...)

マクロ: Mpc

リボン: Connections » MPC » Equation » MultiNodes

入力​

strName​

MPCの名前を指定する String です。

デフォルト値は "MPC_1" です。

crlMasterNodes​

接続する必要のあるマスター節点のリストを指定する Cursor のリストです。マスター節点は、節点の選択リスト内で2番目以降に選択された節点です。

これは必須の入力です。

crSlaveNode​

接続する必要のあるスレーブ節点を指定する Cursor です。スレーブ節点は、節点の選択リスト内で最初に選択された節点です。このスレーブ節点は、すべてのマスター節点と接続されます。

これは必須の入力です。

listMpcConnection​

MPCコネクションのリストを指定する MPC_CONNECTION のリストです。

デフォルト値は [] です。

dValue​

MPCの値を指定する Double です。

デフォルト値は 0.0 です。

iLocalCoordinate​

ローカル座標系を指定する Integer です。

デフォルト値は 0 です。

bUpdateDispCS​

位置座標の更新を指定する Boolean です。

True の場合、位置座標が更新されます。

False の場合、位置座標は更新されません。

デフォルト値は True です。

crMPCConnection​

既存のMPCコネクションを指定する Cursor です。

このパラメータを使用すると、指定したMPCコネクションが修正されます。

None の場合、新しいMPCコネクションが作成されます。

デフォルト値は None です。

戻り値​

作成または修正されたMPCコネクションを指定する Cursor です。

サンプルコード​

Geometry.Part.Cube(iPartColor = 7666683)
Geometry.Part.Cube(dlOrigin = [0.02, 0.0, 0.0], 
                   strName = "Cube_2", 
                   iPartColor = 12867524)

created_mpc = Connections.MPC.Equation.MultipleNodes(crlMasterNodes=[Node(340,
                                                                          344, 
                                                                          353)],
                                                     crSlaveNode=Node(757), 
                                                     listMpcConnection=[MPC_CONNECTION(dCoef=1.0, 
                                                                                       iDof=1),
                                                                        MPC_CONNECTION(dCoef=1.0, 
                                                                                       iDof=1), 
                                                                        MPC_CONNECTION(dCoef=1.0, 
                                                                                       iDof=1),
                                                                        MPC_CONNECTION(dCoef=1.0, 
                                                                                       iDof=1)], 
                                                     bUpdateDispCS=1)

JPT.Debugger(created_mpc)
