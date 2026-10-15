# Geometry.MergeEntities.Edges()

Geometry.MergeEntities.Edges()

説明​

選択したすべてのエッジを途切れないエッジにマージします。

構文​

Geometry.MergeEntities.Edges(...)

リボン: Geometry » Merge Entities » Edges

入力​

crlEdges​

マージするエッジを指定する Cursor のリストです。

これは必須入力です。

戻り値​

マージされたエッジを指定する Cursor のリストです。

サンプルコード​

Geometry.Part.Cube()
Geometry.BreakEntity.Edge(crlNodes=[Node(95, 92, 90)])

merged_edges = Geometry.MergeEntities.Edges(crlEdges=[Edge(9, 
                                                           10, 
                                                           11, 
                                                           12, 
                                                           13, 
                                                           14, 
                                                           15, 
                                                           16, 
                                                           17, 
                                                           18, 
                                                           20, 
                                                           28, 
                                                           32, 
                                                           34, 
                                                           35)])

JPT.Debugger(merged_edges)
