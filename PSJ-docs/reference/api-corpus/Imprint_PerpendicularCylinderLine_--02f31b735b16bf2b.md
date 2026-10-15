# Imprint_PerpendicularCylinderLine()

Imprint_PerpendicularCylinderLine()

説明​

垂直シリンダーラインを作成します。

構文​

Imprint_PerpendicularCylinderLine(double[] Point_xyz, int FaceID, int type,double value,
    bool oppositeFlag, bool BreakFace,Cursor[] BodyCursor)

入力​

1. Double[]​

Point xyz [[x1,y1,z1],[x2,y2,z2],[x3,y3,z3]]

2. Int​

フェースID

3. Int​

メソッドタイプ 0=円弧長,1=中心角

4. Double​

長さ/角度値

5. Bool​

逆向きフラグ true=1,false=0

6. Bool​

フラグ：フェースの分割 true = 1,false=0

7. Cursor[]​

パートカーソル([3:*]*= パートID)

戻り値​

"1": 関数は実行可能です

"0": 関数は実行できません

サンプルコード​

Imprint_PerpendicularCylinderLine([[0.005, 0.00666667, 0.00866025], [0.005, 0.02, 0.00866025]], 5, 1, 0, 0, 1, [3:1])
