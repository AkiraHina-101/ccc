# Connections.RigidElements.RBE3.OneToOne()

Connections.RigidElements.RBE3.OneToOne()

説明​

RBE3を作成します

構文​

Connections.RigidElements.RBE3.OneToOne(...)

リボン: Connections » RigidElements » RBE3 » OneToOne

入力​

iMethod​

メソッドを指定する Integer です。

デフォルト値は17です。

crlMasterTargets​

マスターターゲットを指定する Cursor リストです。

デフォルト値は[]です。

crlSlaveTargets​

スレーブターゲットを指定する Cursor リストです。

デフォルト値は[]です。

listRbe3TermConnection​

rbe3 term connection を指定する RBE3TERM_CONNECTION List です。

デフォルト値は[]です。

iTypeRBE3​

r e3 のタイプを指定する Integer です。

デフォルト値は3です。

strName​

名前を指定する String です。

デフォルト値は""です。

crCoordSys​

座標系を指定する Cursor です。

デフォルト値はNoneです。

dTolerance​

許容値を指定する Double です。

デフォルト値は0.0です。

dlVirtualNodePos​

仮想節点の位置を指定する Double List です。

デフォルト値は[0, 0, 0]です。

iSurfaceDef​

表面定義を指定する Integer です。

デフォルト値は0です。

crEdit​

編集を指定する Cursor です。

デフォルト値はNoneです。

bUpdateDispCS​

変位座標系の更新を有効にする Boolean です。

デフォルト値は True です。

戻り値​

成功時には1の文字列、失敗時には0の文字列です。

サンプルコード​

Geometry.Part.Cube(
    ilAxialNodes=[4, 4, 4], strName="Cube_2", iPartColor=14903267)

Geometry.Part.Cube(
    dlOrigin=[0.012, 0.0, 0.0], 
    ilAxialNodes=[4, 4, 4], 
    strName="Cube_3", 
    iPartColor=7829501)

Connections.RigidElements.RBE3.OneToOne(
    crlMasterTargets=[Node(61, 87, 88, 64, 57, 71, 72, 60)], 
    crlSlaveTargets=[Node(6, 27, 28, 7, 2, 11, 12, 3)],
     listRbe3TermConnection=[(0, 63, 8), (1, 7, 8)],
     strName="RBE3_3")
