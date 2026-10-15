# NASTRAN_FREQ_TIMESTEP

NASTRAN_FREQ_TIMESTEP

説明​

Nastran Freq Timestepのパラメータを制御するために使用されるデータ型です。

属性​

iNumberOfSteps​

DTiの値の時間ステップ数を指定する Integer です。

デフォルト値はDFLT_INTです。

dTimeIncrement​

時間増分を指定する Double です。

デフォルト値はDFLT_DBLです。

iOutputInterval​

出力のスキップ要因を指定する Integer です。NOiステップごとに出力されます。

デフォルト値はDFLT_INTです。

iDampingType​

モーダル減衰テーブルタイプを指定する Integer です。

0：なしタイプ。

1：CRITタイプ（臨界減衰比）。

2：Gタイプ（構造減衰係数）。

3：Qタイプ（Qファクター）。

デフォルト値は2です。

iModalDampingTableId​

モーダル減衰テーブルIDを指定する Integer です。

デフォルト値は0です。
