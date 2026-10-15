# EXTEND_FACE_DIRECTION

EXTEND_FACE_DIRECTION

説明​

拡張面の方向設定を制御するために使用されるデータ型です。

属性​

iMetric​

面を作成するメソッドを指定する Integer です。

0: 座標

1: 2つの節点

2: 要素エッジ

3: オフセット

4: 円筒

デフォルト値は0です。

iCoordinateSystem​

iMetric=0 の場合に参照する座標系を指定する Integer です。

デフォルト値は0（グローバル）です。

iDirection​

iMetric=0 の場合に面を拡張する方向を指定する Integer です。

0: 成分別

1: 角度別

デフォルト値は0です。

dComponentX​

iDirection=0 の場合に X 方向を指定する Double です。

デフォルト値は1です。

dComponentY​

iDirection=0 の場合に Y 方向を指定する Double です。

デフォルト値は1です。

dComponentZ​

iDirection=0 の場合に Z 方向を指定する Double です。

デフォルト値は1です。

dAngleTheta​

iDirection=1 の場合に theta 値を指定する Double です。

デフォルト値は45です。

dAnglePhi​

iDirection=1 の場合に phi 値を指定する Double です。

デフォルト値は45です。

bBothDirections​

面を両方向に拡張するかどうかを指定する Boolean です。

デフォルト値は False です。

bReverseDirection​

面を反対方向に作成するかどうかを指定する Boolean です。

デフォルト値は False です。

iMethod​

iMetric=4 の場合に面を作成する方法を指定する Integer です。

0: 軸へ

1: 面へ

2: アーク角

3: アーク長

4: スイープ

デフォルト値は0です。

iAxisPlane​

iMethod=0 の場合に軸平面を指定する Integer です。

0: XY

1: YZ

2: ZX

デフォルト値は0です。

dZXY​

Z / X / Y のパラメータを指定する Double です。

デフォルト値は0.001です。
