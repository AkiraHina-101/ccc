# CmdPlotStrainGaugeDirCos()

CmdPlotStrainGaugeDirCos()

説明​

インポート

構文​

CmdPlotStrainGaugeDirCos(ポストジョブのカーソル, 節点のIDのint[], ステップ情報のvector[], X軸の名前のstring, Y軸の名前のstring, 高さのfloat, 幅のfloat, 修正係数のfloat, 方向余弦のfloat[], 相の種類のint, 相の角度のfloat, マークアップの作成のbool)

Time/Freq(Default)", "Stress(Node)", 0.005, 0.005, 1, 1, -1, 0.000000, 1)

入力​

1. cursor  ​

ポストジョブ

2. int[]  ​

対象節点のID。

3. vector[]  ​

ステップ情報ベクトル。

1. int ​

解析タイプ

2. int ​

結果の設定

3. int ​

タイムステップ

4. string  ​

X軸の名前。

5. string  ​

Y軸の名前。

6. float  ​

ゲージの長さ

7. float  ​

ゲージの幅

8. float  ​

ゲージの修正係数

9. float[]  ​

方向ベクトル [x,y,z]

10. int  ​

相の設定 - 相

11. float  ​

相の設定 - 角度

12. bool  ​

ノートの追加フラグ

戻り値​

なし

サンプルコード​

CmdPlotStrainGaugeDirCos(183:1, [13226], [[2,1,1], [2,1,2], [2,1,3], [2,1,4], [2,1,5], [2,1,6], [2,1,7], [2,1,8], [2,1,9], [2,1,10]], "Time/Freq(Default)", "Stress(Node)", 0.005, 0.005, 1, [1,0,0], -1, 0.000000, 1)
