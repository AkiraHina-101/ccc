# MappingPressure()

MappingPressure()

説明​

マッピング圧力を作成します

構文​

MappingPressure(string name, Cursor[] target, int pos, int conflictMode, int component,
    int srcType, int mappedComponentIndex, double dSclFact, double[3] transitionVct, double[3] rotVct,
    double coordScl, double dSearchRange, int iInputUnit, string strDataScrFile, Cursor editCursor)

入力​

1. String​

マッピング圧力の名前

2. Cursor[]​

マッピング対象のエンティティ

3. Int​

マッピング位置。0：表面節点、1：ソリッド節点、2：表面要素、3：ソリッド要素

4. Int​

競合ケースの処理方法

5. Int​

成分番号。圧力は1

6. Int​

ソースデータのタイプ。0：Fluent、1：starCD、2：テキスト

7. Int​

ファイル内の圧力データインデックス

8. Double​

マッピング圧力のスケールファクター

9. Double[3]​

遷移ベクトル

10. Double[3]​

回転ベクトル

11. Double​

座標スケール値

12. Double​

検索範囲

0：自動検索範囲

値：許容範囲検索範囲

13. Int​

入力単位

0：MPa

1：Pa

2：kPa

3：kgf/mm^2

4：lbf/ft^2

5：tf/m^2

6：GPa

14. string​

ファイル内の圧力データインデックス

15. Cursor​

マッピング圧力の編集

戻り値​

"0"：関数を実行できません

サンプルコード​

MappingPressure("MappingPressure1", [6:30, 6:22], 2, 0, 1, 1, -1, 1, [0, 0, 0],
    [0, 0, 0], 1, 0, 0, "D:/Fluent.dat", 0:0)
