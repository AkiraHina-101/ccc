# MeshEditMorphingRibThickness()

MeshEditMorphingRibThickness()

説明​

節点を移動してリブの厚さを変更します。

構文​

MeshEditMorphingRibThickness(Cursor[] taFaceMove, Cursor[] taFaceFixed, double move, double distStrong, double distWeak)

入力​

1. Cursor[]​

フェース移動を指定する Cursor リストです。

2. Cursor[]​

フェースの固定を指定する Cursor リストです。

3. Double​

移動距離を指定するDouble型です。

4. Double​

強度距離を指定するDouble型です。

5. Double​

弱度距離を指定するDouble型です。

戻り値​

"1": 関数が実行可能です

"0": 関数を実行できません

サンプルコード​

MeshEditMorphingRibThickness([6:26, 6:25], [], 0.003, 0.01, 0.02)
