# Imprint_ExtendLine()

Imprint_ExtendLine()

説明​

線を延長し、印字を作成します。

構文​

Imprint_ExtendLine(int Edge_ID, int Method_Type, int Position_Type, bool Break_Face, Cursor[] bodyCursor)

入力​

1. Int​

エッジID

2. Int​

メソッドタイプ 0=直線, 1=同じ曲率

3. Int​

位置タイプ 0=最も近いエッジ, 1=境界エッジ

4. Bool​

フラグ true = 1, false = 0

5. Cursor[]​

パートカーソル（[3:*]*= パートID）

戻り値コード​

"1": 関数が実行可能です

"0": 関数が実行できません

サンプルコード​

Imprint_ExtendLine(27, 0, 0, 1, [3:1])
