# NASTRAN_PSD_DATA

NASTRAN_PSD_DATA

説明​

周波数に依存する形式を持つランダム解析に使用される、負荷セットのパワースペクトル密度係数を定義するデータ型です。
Sjk=(X+iY)G(F)S_{jk} = (X + iY)G(F)Sjk​=(X+iY)G(F)

属性​

iMasterID​

興奮負荷セットのサブケース識別番号を指定する Integer です。

デフォルト値は0です。

iSlaveID​

適用される負荷セットのサブケース識別番号を指定する Integer です。

デフォルト値は0です。

dRealX​

複素数の実部を指定する Double です。

デフォルト値は1.0です。

dImagY​

複素数の虚部を指定する Double です。

デフォルト値は0.0です。

iTableID​

G(F) を定義する TABRNDi エントリの識別番号を指定する Integer です。

デフォルト値は0.0です。
