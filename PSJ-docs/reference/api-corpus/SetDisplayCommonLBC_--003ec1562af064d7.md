# SetDisplayCommonLBC()

SetDisplayCommonLBC()

説明​

共通のLBCの表示を設定します。

構文​

SetDisplayCommonLBC(int DisplayTargetEntity, int MarkerDensity, int ValueDisplay, int PartConnection, int OpacityColor, int MasterColor, int SlaveColor, int Enable3DMarker)

入力​

1. int​

表示対象エンティティ。

0: オフ

1: 常に

2: 選択済み

2. int​

マーカー密度。

0: ターゲットエンティティごと

1: 低

2: 中

3: 高

4: 有効エリアのみ

5: 各条件ごと

3. int​

値の表示。

0: オフ

1: 画面上に表示

2: 3Dに表示

3: 3Dに単位とともに表示

4. int​

パート接続。

0: オン

1: オフ

5. int​

Jupiterで色値で表される不透明色。

6. int​

Jupiterで色値で表されるマスターカラー。

7. int​

Jupiterで色値で表されるスレイブカラー。

8. bool​

3Dマーカーを有効にする

0: オン

1: オフ

戻り値​

戻り値はありません。

サンプルコード​

SetDisplayCommonLBC(0, 0, 1, 1, 255, 255, 16711680, 0)
