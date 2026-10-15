# CreateEdgeByElemEdge()

CreateEdgeByElemEdge()

説明​

要素エッジによるエッジの作成

構文​

CreateEdgeByElemEdge(ElemEdge[] elem_edge,bool break_face)

入力​

1. ElemEdge[]​

（複数の）要素エッジElemEdge[] を選択します（[10:節点ID-10:節点ID]）

2. Bool​

エッジを分割するかどうかを指定します。True = 1、False = 0

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

CreateEdgeByElemEdge([10:59-10:227, 10:219-10:227, 10:211-10:219, 10:203-10:211], 1)
