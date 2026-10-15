# SeparateNode()

SeparateNode()

説明​

節点を分離します。

構文​

SeparateNode(cursor[] vcrNode, cursor[] vcrTarget, int iKeepIDsOn)

入力​

1. Cursor[]​

ターゲット節点カーソル（[10:節点ID]）

2. Cursor[]​

ターゲットエンティティカーソル

3. Int​

Node IDsを保持する場合のタイプ

0: なし

1: 選択パートの順序

2: より高いパートID

3: より低いパートID

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

SeparateNode([10:7, 10:1955, 10:1954, 10:1953], [10:7, 10:1955, 10:1954, 10:1953], 0)
