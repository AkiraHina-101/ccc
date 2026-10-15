# Connections.MPC.Equation.TwoFaces()

Connections.MPC.Equation.TwoFaces()

説明​

2つのフェースの複数の点間にMPCを作成します。

構文​

Connections.MPC.Equation.TwoFaces(...)

マクロ: Mpc

リボン: Connections » MPC » Equation » TwoFace

入力​

strName​

MPC名を指定する String です。

デフォルト値は「MPC_1」です。

crMasterFace​

マスターとなるフェースを指定する Cursor です。crMasterFace、crSlaveFace、_crMPCConnection_の3つの引数は排他的です。いずれか1つを指定する必要があります。

デフォルト値は None です。

crSlaveFace​

スレーブになるフェースを指定する Cursor です。crMasterFace、crSlaveFace、_crMPCConnection_の3つの引数は排他的です。いずれか1つを指定する必要があります。

デフォルト値は None です。

listMpcConnection​

MPC接続データ型のペアを指定する List of MPC_CONNECTION です。

デフォルト値は [] です。

dValue​

MPC定数値を指定する Double です。

デフォルト値は 0.0 です。

iLocalCoordinate​

ローカル座標系を指定する Integer です。

デフォルト値は 0 です。

bUpdateDispCS​

選択されたフェースに属する節点の変位座標系を指定されたローカル座標系に変更するかどうかを指定する Boolean です。

デフォルト値は True です。

crMPCConnection​

既存のMPC接続（2つのフェース）を指定する Cursor です。この引数が None でない場合、指定されたMPC接続が修正されます。それ以外の場合、新しいMPC接続が作成されます。crMasterFace、crSlaveFace、_crMPCConnection_の3つの引数は排他的です。いずれか1つを指定する必要があります。

デフォルト値は None です。

戻り値​

作成または修正されたMPC接続を指定する Cursor です。

サンプルコード​

Geometry.Part.Cube(iPartColor=7666683)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], 
                   strName="Cube_2", 
                   iPartColor=12867524)

created_mpc = Connections.MPC.Equation.TwoFaces(strName="MPC_1", 
                                                crMasterFace=Face(49), 
                                                crSlaveFace=Face(24),
                                                listMpcConnection=[MPC_CONNECTION(dCoef=1.0, 
                                                                                  iDof=1), 
                                                                   MPC_CONNECTION(dCoef=-1.0, 
                                                                                  iDof=1)], 
                                                bUpdateDispCS=1)

JPT.Debugger(created_mpc)
