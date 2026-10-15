# CadProject_NodeToFace()

CadProject_NodeToFace()

説明​

CADフェースに向けてメッシュ化されたフェースの節点をプロジェクトします

構文​

CadProject_NodeToFace(cursor[] taCadFaces, cursor[] taNodes, int Direction, bool bImproveQuality,
    double tolerance, bool bNearest3Nodes)

入力​

1. Cursor[]​

対象のCADフェース（15:RefFace ID）

2. Cursor[]​

対象節点（[10:Node IDs]）

3. int​

方向 Min=0, X=1, Y=2, Z=3, -X=4, -Y=5, -Z=6

4. Bool​

品質向上チェックフラグ True = 1, False = 0

5. Double​

許容範囲。-1に設定すると、自動設定（メッシュサイズに基づいて検索）を意味します。

7. Bool​

最も近い3つの節点チェックフラグ True = 1, False = 0

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

CadProject_NodeToFace([15:5], [10:377, 10:378, 10:390], 0, 0, 0.003, 1)
