# Geometry.Edge.ElementEdges()

Geometry.Edge.ElementEdges()

説明​

選択した要素のエッジからエッジを作成します。

構文​

Geometry.Edge.ElementEdges(...)

マクロ: CreateEdgeByElemEdge

Ribbon: Geometry » Edge » Element Edges

入力​

crplElemEdges​

要素エッジをエッジに変換するために指定された Cursor ペアのリスト。

これは必須の入力です。

bBreakEdge​

ユーザができる限りエレメント・エッジを実行するフェースを分割するかどうかを指定します Boolean。

デフォルト値は True です。

戻り値​

新しく作成されたエッジを指定した Cursor のリスト。

サンプルコード​

Geometry.Part.Cube()

created_edges = Geometry.Edge.ElementEdges(crplElemEdges=[CursorPair(Node(443), Node(452)), 
                                                          CursorPair(Node(444), Node(445)), 
                                                          CursorPair(Node(454), Node(463))])
JPT.Debugger(created_edges)
