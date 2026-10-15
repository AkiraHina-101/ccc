# BoundaryConditions.FixedConstraint()

BoundaryConditions.FixedConstraint()

説明​

選択したフェース、エッジ、または節点に固定拘束を作成します。ユーザーが固定拘束の自由度を入力し、選択したアイテムに固定拘束を返します。

構文​

BoundaryConditions.FixedConstraint(...)

リボン: Boundary Conditions » Fixed Constraint

入力​

strName​

作成する固定拘束の名前を指定する String です。

デフォルト値は「Constraint1」です。

iDwDof​

自由度（dof）を指定する Integer です。この値は次のオプション間のOR演算で計算されます：

 | 値 | オプション

 | 1 | Ux（x方向移動）

 | 2 | Uy（y方向移動）

 | 4 | Uz（z方向通訳）

 | 8 | Rx（x軸回転）

 | 16 | Ry（y軸回転）

 | 32 | Rz（z軸回転）

例えば、x、y、z方向の移動を拘束する必要がある場合、iDwDof = 1 |2 |4 = 7 とします。

デフォルト値は7です。

crCurCoord​

固定拘束が作成される座標を指定する Cursor です。

デフォルト値は None（グローバル座標）です。

iType​

使用するタイプを指定する Integer です。以下のいずれかです。

0: 使用しない

1: SUPPORT タイプ

2: USET タイプ

デフォルト値は0です。

iUsetType​

USET タイプを指定する Integer です。iType=2 の場合にのみUSET タイプが使用されます。USET タイプは次のいずれかです。

0: U1

1: U2

2: U3

3: U4

4: U5

5: U6

デフォルト値は0です。

crTable​

フィールドデータのテーブルを指定する Cursor です。

デフォルト値は None です。

bAbaqusFixed​

Abaqus I/F に使用される、Abaqus 固定の有効（True）または無効（False）を指定する Boolean です。

デフォルト値は False です。

crlTargets​

固定拘束の対象のリストを指定する List of Cursor です。このターゲットはフェース、エッジ、または節点であることがでます。

デフォルト値は [] です。

crEdit​

既存の固定拘束を指定する Cursor です。このパラメータを使用すると、指定された固定拘束が変更されます。None の場合、新しい固定拘束が作成されます。

デフォルト値は None です。

戻り値​

作成された LBC を指定する Cursor です。

サンプルコード​

Geometry.Part.Cube()
creating_status = BoundaryConditions.FixedConstraint(crlTargets=[Face(26)])
JPT.Debugger(creating_status)
