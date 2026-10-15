# MC_Intersection()

MC_Intersection()

説明​

交差

構文​

MC_Intersection(cursor[] crBody, double dTol, int iDispType, int iNoLayer, bool bErrText)

入力​

1. Cursor[]​

対象の パートーカーソル（[3:パートID]）

2. Double​

エッジ許容数

3. Int​

交差の表示タイプ

0:  パートー交差のみ

1: すべての交差

2:  パートー間の交差

4. Int​

交差レイヤーの数

5. Bool​

エラーテキストブールフラグ True = 1、False = 0

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

MC_Intersection([3:1], 0, 0, 1, 0)
