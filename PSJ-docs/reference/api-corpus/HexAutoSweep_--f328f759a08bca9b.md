# HexAutoSweep()

HexAutoSweep()

説明​

可能な場合、パートの自動六角形メッシュ作成者です。

構文​

HexAutoSweep(int[] nPartIds, double dMeshSize, int nFlagForLayerMesh, int nLayers)

入力​

1. Int[]​

パートを指定します

2. Double​

メッシュサイズ

3. Int​

レイヤーメッシュのフラグ（0-レイヤーメッシュなし、1-レイヤーメッシュ）

4. Int​

総レイヤー数

戻り値​

"1": 関数が実行可能です

"0": 関数を実行できません

サンプルコード​

HexAutoSweep([1], 0.002, 1, 3)
