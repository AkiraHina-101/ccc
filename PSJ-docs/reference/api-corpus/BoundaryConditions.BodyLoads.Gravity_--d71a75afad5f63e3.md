# BoundaryConditions.BodyLoads.Gravity()

BoundaryConditions.BodyLoads.Gravity()

説明​

重力の加速度負荷を選択した部分に定義します。ユーザーは重力の加速度負荷の値を入力し、選択した部分に重力の加速度負荷を返します。

構文​

BoundaryConditions.BodyLoads.Gravity(...)

リボン: Boundary Conditions » Body Loads » Gravity

入力​

strName​

重力負荷の名前を指定する String です。

デフォルト値は "Gravity1" です。

dlGravity​

各方向（X、Y、Z）の加速度値リストを指定する Double List です。

これは必須の入力です。

crCurCoord​

負荷の座標系を指定する Cursor です。

デフォルト値は None （グローバル座標系）です。

crlTargets​

重力の加速度負荷を作成する対象パートのリストを指定する Cursor リストです。

デフォルト値は [] です。

crEdit​

既存の重力負荷を指定する Cursor です。このパラメータを使用すると、指定された重力負荷が変更されます。 None の場合、新しい重力負荷が作成されます。

デフォルト値は None です。

戻り値​

作成された LBC を指定する Cursor です。

サンプルコード​

Geometry.Part.Cube()

created_bcs = BoundaryConditions.BodyLoads.Gravity(strName="Gravity1", 
                                                   dlGravity=[0.0, 0.0, -9810.0],
                                                   crlTargets=[Part(1)])

JPT.Debugger(created_bcs)
