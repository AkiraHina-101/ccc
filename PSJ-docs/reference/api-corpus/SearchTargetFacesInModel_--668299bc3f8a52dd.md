# SearchTargetFacesInModel()

SearchTargetFacesInModel()

説明​

モデル内の対象フェースを検索します。

構文​

SearchTargetFacesInModel(int BodyType, double[3] OriginPoint, double[3] LengthXYZ,
    double[3] CenterPoint, double[3] MajorPoint, double[3] MinorPoint, bool Enclosed)

入力​

1. Int​

パートタイプ

0: キューブ

1: スフェロイド

2. Double[3]​

原点

3. Double[3]​

X、Y、Zの長さ

4. Double[3]​

中心点

5. Double[3]​

主要点

6. Double[3]​

補助点

7. Bool​

包含フラグ 0: False, 1: True

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

SearchTargetFacesInModel(0, [0, 0, 0], [0.01, 0.01, 0.01], [0, 0, 0], [0, 0, 0.01], [0.005, 0, 0], 0)
