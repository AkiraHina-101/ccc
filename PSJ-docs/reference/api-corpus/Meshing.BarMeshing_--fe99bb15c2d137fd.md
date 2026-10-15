# Meshing.BarMeshing()

Meshing.BarMeshing()

説明​

メッシュ1D エッジ/バー パート。

構文​

Meshing.BarMeshing(...)

マクロ：BeamMeshing

リボン：Meshing » BarMeshing

入力​

crlCadEdge​

CAD エッジのリストを指定する Cursor のリスト。

これは必須の入力です。

crlBarEdge​

バー エッジのリストを指定する Cursor のリスト。

これは必須の入力です。

crlBarPart​

バー パートのリストを指定する Cursor のリスト。

これは必須の入力です。

dDocMeshSize​

メッシュ サイズを指定する Double 型の値。

デフォルト値は 0 です。

iDocNumofElem​

要素の数を指定する Integer の値。このパラメータが 0 より大きい場合、dDocMeshSize は無視されます。

デフォルト値は 4 です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean 値：

True: プロセスが正常に実行されました。

False: 関数を実行できませんでした。

サンプルコード​

MeshEdit.CreateNode.Absolute(veclNodeCoord=[[0.0, 0.0, 0.0]], 
                             ilNewNodeID=[1])
MeshEdit.CreateNode.Absolute(veclNodeCoord=[[0.001, 0.0, 0.0]], 
                             ilNewNodeID=[2])
Geometry.Bar.TwoNodes(iMeshCount=1, 
                      crStartNode=Node(2), 
                      crEndNode=Node(1))

mesh_status = Meshing.BarMeshing(crlCadEdge=[], 
                                 crlBarEdge=[1], 
                                 crlBarPart=[], 
                                 iDocNumofElem=10)

JPT.Debugger(mesh_status)
