# MeshEditMorphingFaces()

MeshEditMorphingFaces()

説明​

選択した節点からの影響範囲で節点を移動します。

構文​

MeshEditMorphingFaces(Cursor[] taFaceMove, Cursor[] taFaceFixed, bool DirectionType, Cursor Coordinate, Vector Offset, double Offset, int DistType, double DistStrong, double dDistWeak, int nodeID, Vector pointPosition )

入力​

1. Cursor[]​

節点の移動を指定するCursorリストです。

2. Cursor[]​

固定するフェースを指定するCursorリストです。

3. Bool​

方向タイプを指定するBoolです。

4. Cursor​

座標を指定するCursorです。

5. Double[]​

方向タイプ: Offset値のdist strongを指定するDoubleベクトルです。

6. Double​

方向タイプ: 通常のOffsetに対する移動距離を指定するDoubleです。

7. Int​

影響範囲を指定するIntです。

8. Double​

dist strongを指定するDoubleです。

9. Double​

dist weakを指定するDoubleです。

10. Int​

方向タイプ: 回転のための回転中心を指定するIntです。

11. Vector​

方向タイプ: Node+Pointのためのポイント位置を指定するDoubleベクトルです。

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

MeshEditMorphingFaces([6:26], [], 0, 0:0, [0, 0.001, 0], 0, 0, 0.01, 0.02, -1, [])
