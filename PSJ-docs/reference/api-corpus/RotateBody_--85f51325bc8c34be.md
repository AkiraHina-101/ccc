# RotateBody()

RotateBody()

説明​

パートの回転

構文​

RotateBody(cursor[] body, double[3] rotate_centre, double[3] rotate_axis, double rotate_angle,
    bool create_new, bool copy_lbc, int copy_count, bool merge_node, double tolerance)

入力​

1. Cursor[]​

パートリスト

2. Double[3]​

回転中心

3. Double[3]​

回転軸

4. Double​

回転角（ラジアン）

5. Bool​

新しいパートを作成 1=はい、0=いいえ

6. Bool​

LBCをコピー 1=はい、0=いいえ

7. Int​

コピー回数

8. Bool​

節点をマージ 1=はい、0=いいえ

9. Double​

節点マージ許容差

戻り値​

"1": 関数を実行できる

"0": 関数を実行できない

サンプルコード​

RotateBody([3:1], [0.005, 0, 0.01], [0.001, 0, 0], 0.785398, 0, 0, 0, 0, 0)
