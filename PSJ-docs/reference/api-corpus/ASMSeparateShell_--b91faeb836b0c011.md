# ASMSeparateShell()

ASMSeparateShell()

説明​

シェルモデル内の結合されたフェースを分離します。

構文​

ASMSeparateShell(int iType, int[] taKeyEntity, bool bCreateGroup)

入力​

1. Int​

タイプオプション:

1: パート

2: エッジ

2. Int[]​

エンティティカーソル([エンティティID]) -> 選択タイプに依存

3. Bool​

グループを作成するかどうか

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

ASMSeparateShell(1, [4, 1], 0)
