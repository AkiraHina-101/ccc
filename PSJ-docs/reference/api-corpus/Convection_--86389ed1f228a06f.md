# Convection()

Convection()

説明​

対流を作成します

構文​

Convection(string strName, double dExtTemp, cursor crTimeTempTbl, double dCoef,
    cursor crTimeCoefTbl, cursor crTempCoefTbl, cursor crTargets, cursor crEdit)

入力​

1. String​

対流名

2. Double​

外部温度

3. Cursor​

時温度テーブルのカーソル（[81:FieldData ID]）

4. Double​

対流係数の値

5. Cursor​

時依存係数テーブル

6. Cursor​

時間温度依存係数テーブル

7. Cursor[]​

対象エンティティ

8. Cursor​

カーソル編集

戻り値​

"1": 関数が実行できます

"0": 関数を実行できません

サンプルコード​

Convection("Convection_1", 373.15, 81:1, 2000, 81:1, 81:1, [6:3, 11:764], 0:0)
