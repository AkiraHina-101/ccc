# BoundaryConditions.LoadCase()

BoundaryConditions.LoadCase()

説明​

負荷と拘束をまとめる負荷ケースを作成します。負荷ケースは、解析ソルバー入力データを作成する際に参照できます。

構文​

BoundaryConditions.LoadCase(...)

リボン: Boundary Conditions » LoadCase

入力​

strName​

作成する負荷ケースの名前を指定する String 。

デフォルト値は "LoadCase1" です。

dFactor​

Nastran用の負荷係数を指定する Double 。負荷に係数を乗じる際に使用します。

デフォルト値は 1.0 です。

crlTargets​

すべての作成された境界条件のリストを指定する Cursor リスト型。

デフォルト値は [] です。

iExportId​

負荷ケースのエクスポートID番号を指定する Integer 。

デフォルト値は 1 です。

dlTargetFactor​

各境界条件のリスト係数を指定する Double リスト型。

デフォルト値は [] です。

crEdit​

既存の負荷ケースを指定する Cursor 型。このパラメータを使用すると、指定された負荷ケースが変更されます。None になっている場合は新しい負荷ケースが作成されます。

デフォルト値は None です。

戻り値​

作成されたLBCを指定する Cursor 型。

サンプルコード​

Geometry.Part.Cube()

BoundaryConditions.Pressure.General(dPressure=1000000.0, 
                                    crlTargets=[Face(24)])

BoundaryConditions.Pressure.General(strName="Pressure2", 
                                    dPressure=2000000.0,
                                    crlTargets=[Face(21)])

BoundaryConditions.Pressure.General(strName="Pressure3", 
                                    dPressure=3000000.0,
                                    crlTargets=[Face(25)])

created_bcs = BoundaryConditions.LoadCase(crlTargets=[LbcGPressure(1, 2, 3)], 
                                          iExportId=4,
                                          dlTargetFactor=[1.0, 1.0, 1.0])

JPT.Debugger(created_bcs)
