# HexBoxMesh()

HexBoxMesh()

説明​

パート用のボックス六角メッシュ作成者

構文​

HexBoxMesh(int[] taBodyKey, double dMeshSize, string sMaterialName)

入力​

1. Int[]​

パートID

2. Double​

ボックスメッシュサイズ

3. String​

材料名

戻り値​

"1": 関数は実行可能

"0": 関数は実行できません

サンプルコード​

HexBoxMesh([1], 0.002, "Magnesium_Alloy")
