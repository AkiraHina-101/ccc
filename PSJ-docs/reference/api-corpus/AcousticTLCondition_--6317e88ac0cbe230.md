# AcousticTLCondition()

AcousticTLCondition()

説明​

入力側と出力側で作成された選択された節点グループからPCHファイルをインポートして、AC電力と透過率を計算します。

構文​

AcousticTLCondition(cursor crGroupIn, cursor crGroupOut, cursor crEdit)

入力​

1. cursor​

入力データの節点グループを指定する Cursor です。

2. cursor​

出力データの節点グループを指定する Cursor です。

3. cursor​

既存の伝達損失条件を指定する Cursor です。

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

AcousticTLCondition(0:0, 0:0, 0:0)
