# NASTRAN_NONLINEAR

NASTRAN_NONLINEAR

説明​

非線形静解析反復戦略のパラメータセットを定義するために使用されるデータ型です。

属性​

iNINC​

インクリメント数を指定する Integer です。

デフォルト値は 1 です。

iKMETHOD​

剛性更新を制御する方法を指定する Integer です。

0: AUTO。

1: ITER。

2: SEMI。

3: FNT。

4: PFNT。

デフォルト値は 3 です。

iMAXITER​

各負荷増分の反復数に対する制限を指定する Integer です。

デフォルト値は 1 です。

bUseEPSU​

ずれ（U）基準の誤差許容を有効／無効にする Boolean です。

デフォルト値は False です。

bUseEPSP​

負荷（P）基準の誤差許容を有効／無効にする Boolean です。

デフォルト値は False です。

bUseEPSW​

仕事（W）基準の誤差許容を有効／無効にする Boolean です。

デフォルト値は False です。

dEPSU​

ずれ（U）基準の誤差許容を指定する Double です。

デフォルト値は 1.0E-2 です。

dEPSP​

負荷（P）基準の誤差許容を指定する Double です。

デフォルト値は 1.0E-2 です。

dEPSW​

仕事（W）基準の誤差許容を指定する Double です。

デフォルト値は 1.0E-2 です。
