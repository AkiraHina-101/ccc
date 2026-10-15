# Geom_FindFeatures()

Geom_FindFeatures()

説明​

機能別にグループ化されたフェース/エッジを選択します

構文​

Geom_FindFeatures(int taItems, int nType, int nOption, TKey taEdgeItems, int bCylinder, bool bDisc,
    bool bFourCorners, double dMinThickness, double dMaxThickness, double dDiameterMin,
    double dDiameterMax, TKey taFaceItems)

入力​

1. Int[]​

アイテムID

2. Int​

タイプが1の場合はフェースを検索し、タイプが2の場合はエッジを検索します

3. Int​

オプション

4. Int[]​

エッジID

5. Bool​

シリンダーフラグ true = 1、false = 0

6. Bool​

ディスクフラグ true = 1、false = 0

7. Bool​

四隅フラグ true = 1、false = 0

8. Double​

最小厚さ値

9. Double​

最大厚さ値

10. Double​

最小直径値

11. Double​

最大直径値

12. Int[]​

フェースID

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

Geom_FindFeatures([1], 1, 0, [], 1, 0, 1, 0.1, 2, 1, 2, [])
