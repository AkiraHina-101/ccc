# CadProject_NodeToEdge()

CadProject_NodeToEdge()

説明​

CAD エッジに向けてメッシュ 節点をプロジェクトします

構文​

CadProject_NodeToFace(Cursor taCadEdge, Cursor[] taNodes, int Direction)

入力​

1. Cursor​

対象の CAD エッジを参照します（14:RefFace ID）

2. Cursor[]​

対象の節点を指定します（[10:Node IDs]）

3. int​

方向 Min=0, X=1, Y=2, Z=3, -X=4, -Y=5, -Z=6

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプル コード​

CadProject_NodeToEdge(14:2, [10:378, 10:377, 10:376], 0)
