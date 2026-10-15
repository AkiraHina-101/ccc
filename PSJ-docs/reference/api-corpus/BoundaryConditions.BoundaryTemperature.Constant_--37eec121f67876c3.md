# BoundaryConditions.BoundaryTemperature.Constant()

BoundaryConditions.BoundaryTemperature.Constant()

説明​

パート、フェース、エッジまたは節点に一定の温度負荷を作成します。ユーザーはスカラーまたは表形式で温度を入力し、指定した位置に温度負荷を返します。

構文​

BoundaryConditions.BoundaryTemperature.Constant(...)

リボン: Boundary Conditions » Boundary Temperature » Constant

入力​

strName​

温度負荷条件の名前を指定する String です。

デフォルト値は "BoundaryTemperature_1" です。

dFTemp​

一定の温度値を指定する Double です。

これは必須入力です。

crTable​

フィールドデータに入力されたテーブルを指定する Cursor です。

デフォルト値は None です。

crlTargets​

ターゲットのリストを指定する List of Cursor です。ターゲットはフェース、エッジ、または節点です。

これは必須入力です。

crEdit​

既存の温度負荷を指定する Cursor です。このパラメータを使用すると、指定した温度負荷が変更されます。 None のままにすると、新しい温度負荷が作成されます。

デフォルト値は None です。

戻り値​

作成されたLBCを指定する Cursor です。

サンプルコード​

Geometry.Part.Cube()

created_bcs = BoundaryConditions.BoundaryTemperature.Constant(strName="BoundaryTemperature_21",
                                                              dFTemp=373.15, 
                                                              crlTargets=[Face(21)])

JPT.Debugger(created_bcs)
