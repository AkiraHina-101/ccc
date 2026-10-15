# BoundaryConditions.Pressure.General()

BoundaryConditions.Pressure.General()

説明​

選択されたフェース、要素、またはグループに一般的な圧力を加えます。ユーザーは圧力値を入力し、それを選択されたアイテムに適用します。

構文​

BoundaryConditions.Pressure.General(...)

リボン: BoundaryConditions » Pressure » General

入力​

strName​

圧力条件の名前を指定する String 。

デフォルト値は "Pressure1" です。

dPressure​

選択されたターゲットに適用される圧力値を指定する Double 。

デフォルト値は 0.0 です。

iDistribute​

LBC 矢印位置を指定する Integer 。

0: DISTRIBUTE_PER_SELECTION

1: DISTRIBUTE_PER_NODE

2: DISTRIBUTE_TOTAL

デフォルト値は 0 です。

crTable​

テーブルを指定する Cursor 型。

デフォルト値は None です。

dPhase​

相の値を指定する Double 。

デフォルト値は 0.0 です。

dDelay​

遅延値を指定する Double 。

デフォルト値は 0.0 です。

crPhaseTable​

相テーブルを指定する Cursor 型。

デフォルト値は None です。

strFormulaValue​

式値を指定する String 。

デフォルト値は "" です。

crCoord​

使用する座標を指定する Cursor 型。

デフォルト値は None です。

dlDirection​

方向を指定する Double 型のリスト 型。

デフォルト値は [DFLT_DBL,DFLT_DBL,DFLT_DBL] です。

strFormulaDirX​

X方向の式を指定する String 。

デフォルト値は "" です。

strFormulaDirY​

Y方向の式を指定する String 。

デフォルト値は "" です。

strFormulaDirZ​

Z方向の式を指定する String 。

デフォルト値は "" です。

iArrowDir​

矢印の方向を指定する Integer 。

0: 節点で開始

1: 節点で終了

デフォルト値は 1 です。

crlTargets​

一般圧力の対象のリストを指定する List of Cursor 型。これらの対象はフェース、要素、またはグループになります。

デフォルト値は [] です。

crEdit​

既存の一般圧力を指定する Cursor 型。

このパラメータを使用すると、指定された一般圧力が修正されます。

None のままにしておくと、新しい一般圧力が作成されます。

デフォルト値は None です。

戻り値​

生成された LBC を指定する Cursor 型。

サンプルコード​

Geometry.Part.Cube()

created_lbc = BoundaryConditions.Pressure.General(dPressure=10000000.0, 
                                                  crlTargets=[Face(26)])

JPT.Debugger(created_lbc)
