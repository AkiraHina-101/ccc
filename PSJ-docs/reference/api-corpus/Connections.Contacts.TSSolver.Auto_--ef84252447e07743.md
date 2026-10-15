# Connections.Contacts.TSSolver.Auto()

Connections.Contacts.TSSolver.Auto()

説明​

指定された条件に基づいて、既存のパート間の接点を自動的に検索し作成します。

構文​

Connections.Contacts.TSSolver.Auto(...)

リボン：Connections » Contacts » TSSolver » Auto

入力​

strlNames​

作成する接点名のリストを指定する String のリストです。

この入力は必須です。

crllMasterFaceTargets​

マスターフェースのリストを指定する Cursor のリストです。

この入力は必須です。

crllSlaveFaceTargets​

スレーブフェースのリストを指定する Cursor のリストです。

この入力は必須です。

crlContactTypes​

接点種別のリストを指定する Cursor のリストです。

デフォルト値は [1] です。

dlInterferenceClosures​

干渉クロージャのリストを指定する Double のリストです。

デフォルト値は [1.0] です。

dlFrictionCoefficients​

摩擦係数のリストを指定する Double のリストです。

デフォルト値は [DFLT_DBL] です。

blInitialAdjustments​

初期調整を使用するかどうかを指定する Boolean です。

デフォルト値は False です。

crlColors​

接点色のリストを指定する Cursor のリストです。

デフォルト値は 65280 です。

crlEdit​

既存の接点設定アイテムのリストを指定する Cursor のリストです。

このパラメータを使用すると、指定された接点設定アイテムが変更されます。

None の場合は新しい接点設定アイテムが作成されます。

デフォルト値は [] です。

crlMasterGroups​

マスターグループのリストを指定する Cursor のリストです。

デフォルト値は [] です。

crlSlaveGroups​

スレーブグループのリストを指定する Cursor のリストです。

デフォルト値は [] です。

戻り値​

作成された接点を指定する Cursor です。

サンプルコード​

Geometry.Part.Cube(iPartColor=12537679)
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], 
                   strName="Cube_2", 
                   iPartColor=6250449)

created_contact = Connections.Contacts.TSSolver.Auto(strlNames=["C1_Cube_1(24)_Cube_2(49)"], 
                                                     crllMasterFaceTargets=[[Face(24)]], 
                                                     crllSlaveFaceTargets=[[Face(49)]],
                                                     crlEdit=[None],
                                                     crlMasterGroups=[None], 
                                                     crlSlaveGroups=[None])

JPT.Debugger(created_contact)
