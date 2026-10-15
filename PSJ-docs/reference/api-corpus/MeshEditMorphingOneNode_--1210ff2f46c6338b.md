# MeshEditMorphingOneNode()

MeshEditMorphingOneNode()

説明​

選択した節点から影響範囲で節点を移動します。

構文​

MeshEditMorphingOneNode(Cursor[] taNodeMove, Cursor[] taFaceFixed, bool DirectionType, Cursor Coordinate, Vector Offset, double Offset, int DistType, double DistStrong, double dDistWeak)

入力​

1. Cursor[]​

節点移動を指定するCursorリストです。

2. Cursor[]​

フェース固定を指定するCursorリストです。

3. Bool​

方向タイプを指定するBoolです。

4. Cursor​

座標を指定するCursorです。

5. Double[]​

Direction Type: Offset値の強度を指定するDoubleベクトルです。

6. Double​

Direction Type: Normal Offsetの移動距離を指定するDoubleです。

7. Int​

効果範囲を指定するIntです。

8. Double​

強度を指定するDoubleです。

9. Double​

弱度を指定するDoubleです。

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

MeshEditMorphingOneNode([10:453], [], 1, 0:0, [0, 0.001, 0], 0, 0, 0.01, 0.02)
