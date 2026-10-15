# Imprint_Projection_LineS()

Imprint_Projection_LineS()

説明​

Imprint Projection lineを作成します。

構文​

Imprint_Projection_LineS(cursor[] taCrEdges, cursor[] taCrFaces, cursor[] taCrNodes, 
    bool bBreakFace, int iType, bool bCheckGap, double dGap)

入力​

1. Cursor[]​

Projection lineの対象となるエッジを指すカーソル([5:Edge ID])

2. Cursor[]​

Projection lineを投影する対象となるフェースを指すカーソル([6:Face ID])

3. Cursor[]​

Vector Directionタイプ1に対応する節点を指すカーソル([10:Node ID])

4. Bool​

フェースを分割するかどうか（True = 1、False = 0）

5. Int​

Vector Directionタイプ

0: 対象フェース法線

1: 2つの節点

2: 最も近いベクトル

6. Bool​

ギャップをチェックするかどうか（True =1、False = 0）

7. Double​

ギャップの値

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

Imprint_Projection_LineS([5:568], [6:67], [10:1347, 10:1324], 1, 1, 1, 0.003)
