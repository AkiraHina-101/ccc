# TranslateBody()

TranslateBody()

説明​

パートを移動します。

構文​

TranslateBody(cursor[] taBody, double[] tavdTranslate, cursor crCoord, bool bCreateNewBody,
    bool bcopyLBC, int iCopyCount)

入力​

1. Cursor[]​

対象パートカーソル([3:パートID])

2. Double[]​

移動ベクトルリスト

3. Cursor​

ローカル座標を使用するかどうか True = 27:*、False = 0:0

4. Bool​

新しいパートを作成するかどうか真偽フラグ True = 1、False = 0

5. Bool​

LBCコピー真偽フラグ True = 1、False = 0

6. Int​

コピー回数

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

TranslateBody([3:1], [[0.01, 0, 0]], 0:0, 1, 0, 1)
