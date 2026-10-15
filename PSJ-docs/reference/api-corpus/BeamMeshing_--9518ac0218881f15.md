# BeamMeshing()

BeamMeshing()

説明​

Beam1Dメッシュ作成

構文​

BeamMeshing(int[] vcrCadEdgeKey, int[] vcrBarEdgeKey, int[] vcrBarBody, double dDocMeshSize, int iDocNumOfElem)

入力​

1. Int[]​

エッジカーソル（[エッジID]）

2. Int[]​

バーとエッジカーソル（[バーエッジID]）

3. Int[]​

バーカーソル（[バーID]）

4. Double​

メッシュサイズ

5. Int​

要素数

戻り値​

"1": 関数が実行可能です

"0": 関数を実行できません

サンプルコード​

BeamMeshing([], [155, 156], [5], 0, 5)
