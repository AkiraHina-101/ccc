# TranslateBody()

TranslateBody()

説明​

パートを移動します。

構文​

TranslateBody(cursor[] body, double[3] trans_vector, cursor coordinate, bool create_new,
    bool copy_lbc, int copy_count)

入力​

1. Cursor[]​

パートのカーソルリスト

2. double[3]​

平行移動ベクトル

3. Cursor​

基準座標

4. Bool​

新しいパートを作成 1=はい、0=いいえ

5. Bool​

LBCをコピー 1=はい、0=いいえ

6. Int​

コピー回数

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

TranslateBody([3:2], [[0.002, 0, 0]], 0:0, 0, 0, 0)
