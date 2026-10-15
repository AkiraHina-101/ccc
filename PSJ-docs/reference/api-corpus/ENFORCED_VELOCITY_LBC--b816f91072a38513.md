# ENFORCED_VELOCITY_LBC

ENFORCED_VELOCITY_LBC

概要​

Enforced Velocity LBC のパラメータを制御するために使用されるデータ型です。

属性​

iDwDof​

自由度（dof）を指定する Integer の属性です。この値は次のオプション間で OR 演算子を使用して計算されます：

例えば、x、y、z の移動を制約する必要がある場合、iDwDof = 1 |2 |4 = 7 となります。

デフォルト値は 0 です。

dVelocityTX​

X 方向の移動に対する強制速度値を指定する Double 型の属性です。

デフォルト値は DFLT_DBL です。

dVelocityTY​

Y 方向の移動に対する強制速度値を指定する Double 型の属性です。

デフォルト値は DFLT_DBL です。

dVelocityTZ​

Z 方向の移動に対する強制速度値を指定する Double 型の属性です。

デフォルト値は DFLT_DBL です。

dVelocityRX​

X 方向の回転に対する強制速度値を指定する Double 型の属性です。

デフォルト値は DFLT_DBL です。

dVelocityRY​

Y 方向の回転に対する強制速度値を指定する Double 型の属性です。

デフォルト値は DFLT_DBL です。

dVelocityRZ​

Z 方向の回転に対する強制速度値を指定する Double 型の属性です。

デフォルト値は DFLT_DBL です。

crCurCoord​

ロードの参照座標系の方向を指定する Cursor 型の属性です。

デフォルト値は None です。

iEndArrowDir​

マーカー表示の描画位置を指定する Integer の属性です。

0: 節点から開始。マーカーが節点から開始されます。

1: 節点で終了。マーカーが節点で終了します。

デフォルト値は 0 です。

crTable​

周波数および時間履歴を参照するテーブルを指定する Cursor 型の属性です。

デフォルト値は None です。

... (以下略)
