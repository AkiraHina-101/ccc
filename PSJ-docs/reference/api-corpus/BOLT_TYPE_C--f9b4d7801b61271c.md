# BOLT_TYPE_C

BOLT_TYPE_C

説明​

ボルトタイプ C のパラメータを制御するために使用されるデータ型です。

属性​

iTopConType​

Connection を指定する Int です。

0 : RBE2 を作成します

1 : RBE3 を作成します

デフォルト値は 0 です。

iBotConType​

iCenterType が Spring の場合に作成される接続を指定する Int です。

0 : RBE2 を作成します

1 : RBE3 を作成します

デフォルト値は 0 です。

iCenterType​

中心接続タイプを指定する Int です。

0 : なし

1 : Spring

デフォルト値は 0 です。

dlStiffness​

バネの剛性を指定する Double Vector です。

デフォルト値は [0.0, 0.0, 0.0] です。

iUnit​

dlStiffness の入力単位を指定する Int です。

デフォルト値は 0 です。

dDampCoef​

バネの減衰係数を指定する Double です。

デフォルト値は 0.0 です。

crCoord​

ローカル座標を指定する Cursor です。

デフォルト値は None です。

dlRStiffness​

バネの回転剛性を指定する Double Vector です。

デフォルト値は [0.0, 0.0, 0.0] です。

iRUnit​

dlRStiffness の入力単位を指定する Int です。

デフォルト値は 0 です。

dStressCoef​

バネの応力係数を指定する Double です。

デフォルト値は 0 です。

pretension​

予張負荷を指定する PRETENSION_LOAD です。
