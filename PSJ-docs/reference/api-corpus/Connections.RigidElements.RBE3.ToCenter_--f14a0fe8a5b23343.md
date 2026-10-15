# Connections.RigidElements.RBE3.ToCenter()

Connections.RigidElements.RBE3.ToCenter()

説明​

RBE3 を作成します。

構文​

Connections.RigidElements.RBE3.ToCenter(...)

リボン: Connections » RigidElements » RBE3 » ToCenter

入力​

iMethod​

メソッドを指定する Integer です。

デフォルト値は 18 です。

crlMasterTargets​

マスターターゲットを指定する Cursor リストです。

デフォルト値は [] です。

crlSlaveTargets​

スレーブターゲットを指定する Cursor リストです。

デフォルト値は [] です。

listRbe3TermConnection​

RBE3 のターム接続を指定する RBE3TERM_CONNECTION リスト です。

デフォルト値は [] です。

iTypeRBE3​

RBE3 のタイプを指定する Integer です。

デフォルト値は 3 です。

strName​

名前を指定する String です。

デフォルト値は "" です。

crCoordSys​

座標系を指定する Cursor です。

デフォルト値は None です。

dTolerance​

許容差を指定する Double です。

デフォルト値は 0.0 です。

dlVirtualNodePos​

仮想節点の位置を指定する Double リスト です。

デフォルト値は [0, 0, 0] です。

iSurfaceDef​

サーフェス定義を指定する Integer です。

デフォルト値は 0 です。

crEdit​

編集を指定する Cursor です。

デフォルト値は None です。

bUpdateDispCS​

変位座標系の更新を有効にする Boolean です。

デフォルト値は True です。

bCornerOnly​

コーナーのみを有効にする Boolean です。

デフォルト値は False です。

戻り値​

成功すると 1 の文字列、失敗すると 0 の文字列です。

サンプルコード​

Geometry.Part.Cylinder(bHollow=True, dTopInnerRadius=0.005, dBottomInnerRadius=0.005, iPartColor=15658599)

Connections.RigidElements.RBE3.ToCenter(crlMasterTargets=[Edge(1)], 
                                    listRbe3TermConnection=[(0, 63, 1), (1, 7, 1)], 
                                    strName="RBE3_1", 
                                    dlVirtualNodePos=[0, 0.01, 0])
