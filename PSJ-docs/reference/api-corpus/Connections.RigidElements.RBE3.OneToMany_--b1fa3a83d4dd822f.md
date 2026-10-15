# Connections.RigidElements.RBE3.OneToMany()

Connections.RigidElements.RBE3.OneToMany()

説明​

RBE3を作成します。

構文​

Connections.RigidElements.RBE3.OneToMany(...)

リボン: Connections » RigidElements » RBE3 » OneToMany

入力​

iMethod​

メソッドを指定する Integer 。

デフォルト値は16です。

crlMasterTargets​

マスターターゲットを指定する Cursor リスト。

デフォルト値は[]です。

crlSlaveTargets​

スレーブターゲットを指定する Cursor リスト。

デフォルト値は[]です。

listRbe3TermConnection​

RBE3用語の接続を指定する RBE3TERM_CONNECTION List。

デフォルト値は[]です。

iTypeRBE3​

R E3のタイプを指定する Integer 。

デフォルト値は3です。

strName​

名前を指定する String 。

デフォルト値は""（空白）です。

crCoordSys​

座標系を指定する Cursor。

デフォルト値はNoneです。

dTolerance​

誤差を指定する Double 。

デフォルト値は0.0です。

dlVirtualNodePos​

仮想節点位置を指定する Double List。

デフォルト値は[0, 0, 0]です。

iSurfaceDef​

表面定義を指定する Integer 。

デフォルト値は0です。

crEdit​

編集を指定する Cursor。

デフォルト値はNoneです。

bUpdateDispCS​

変位座標系の更新を有効にする Boolean です。

デフォルト値は_True_ です。

bCornerOnly​

コーナーのみを有効にする Boolean です。

デフォルト値は False です。

戻り値​

成功の場合は1、失敗の場合は0の文字列です。

サンプルコード​

# モデルの準備
Geometry.Part.Cube(iPartColor=7697908)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], strName="Cube_2", iPartColor=14903267)

# 接続を作成します
Connections.RigidElements.RBE3.OneToMany(crlMasterTargets=[Node(589, 496, 493)], 
                                        crlSlaveTargets=[Node(84)], 
                                        listRbe3TermConnection=[(0, 63, 1), (1, 7, 3)], 
                                        strName="RBE3_1")
