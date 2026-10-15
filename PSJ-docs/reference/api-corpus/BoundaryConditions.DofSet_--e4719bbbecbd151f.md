# BoundaryConditions.DofSet()

BoundaryConditions.DofSet()

説明​

TS-Solverで解析セット（ASET）内の自由度を作成します。

構文​

BoundaryConditions.DofSet(...)

リボン: BoundaryConditions » DofSet

入力​

crlTargets​

A Cursor を指定し、ASETの作成対象（面/エッジ/節点）のリストを指定します。

デフォルト値は [] です。

strName​

A String を指定し、作成するASETの名前を指定します。

デフォルト値は "DofSet1" です。

iDwDof​

Integer を指定し、自由度（DoF）を指定します。この値は次のオプション間のOR演算子を使用して計算されます:

 | 値 | オプション

 | 1 | Ux（x方向変位）

 | 2 | Uy（y方向変位）

 | 4 | Uz（z方向変位）

 | 8 | Rx（x方向回転）

 | 16 | Ry（y方向回転）

 | 32 | Rz（z方向回転）

例えば、x、y、z方向の変位を拘束する場合、iDwDof = 1 | 2 | 4 = 7 となります。

デフォルト値は 7 です。

crCurCoord​

Cursor を指定し、固定拘束が作成される座標を指定します。

デフォルト値は None（グローバル座標）です。

crTable​

Cursor を指定し、フィールドデータのテーブルを指定します。

デフォルト値は None です。

crEdit​

Cursor を指定し、既存のDoFセットを指定します。このパラメータを使用すると、指定されたDoFセットが修正されます。None のままにしておくと、新しいDoFセットが作成されます。

デフォルト値は None です。

戻り値​

作成されたLBCを指定する Cursor です。

サンプルコード​

Geometry.Part.Cube()

created_lbc = BoundaryConditions.DofSet(crlTargets=[Face(26)],
                                        strName="DofSet1",
                                        iDwDof=7)

JPT.Debugger(created_lbc)
