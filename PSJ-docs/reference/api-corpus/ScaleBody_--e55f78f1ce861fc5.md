# ScaleBody()

ScaleBody()

説明​

パートをスケールします。

構文​

ScaleBody(cursor[] taBody, double[3] scaleVector, double[3] scaleCentre, cursor crCoord, 
    bool createNew, bool copyLBC, bool usePartCenter)

入力​

1. Cursor[]​

対象パートのカーソル（[3:Part ID]）

2. Double[3]​

スケールベクトル（x、y、z）

3. Double[3]​

スケール中心（x、y、z）

4. Cursor​

ローカル座標を使用するかどうか True = 27:*、False = 0:0

5. Bool​

新しいパートを作成するかどうかのフラグ True = 1、False = 0

6. Bool​

LBCのコピーを行うかどうかのフラグ True = 1、False = 0

7. Bool​

パート中心を使用するかどうかのフラグ True = 1、False = 0

戻り値​

"1": 関数が実行可能です

"0": 関数を実行できません

サンプルコード​

ScaleBody([3:1], [1, 5, 1], [0, 0, 0], 0:0, 1, 0, 1)
