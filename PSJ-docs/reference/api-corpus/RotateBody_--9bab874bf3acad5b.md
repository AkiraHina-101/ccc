# RotateBody()

RotateBody()

説明​

パートを回転します

構文​

RotateBody(cursor[] taBody, double[3] vdCenter, double[3] vdAxis, double angle,
    bool createNewBody, bool copyLBC, int copyCount, bool mergeNode, double dTolerance)

入力​

1. Cursor[]​

ターゲットパートのカーソル([3:Part ID])

2. Double[3]​

回転座標ポイント([x, y, z])

3. Double[3]​

回転軸

4. Double​

回転角度（ラジアン）

5. Bool​

新しいパートを作成するかのフラグ True = 1, False = 0

6. Bool​

LBCをコピーするかのフラグ True = 1, False = 0

7. Int​

コピー回数の値

8. Bool​

等価節点をマージするかのフラグ True = 1, False = 0

9. Double​

等価許容差

戻り値​

"1": 関数を実行できる

"0": 関数を実行できない

サンプルコード​

RotateBody([3:1], [0, 0, 0.0055556], [0, 0, 0.001], 0.523599, 1, 0, 1, 0, 1e-08)
