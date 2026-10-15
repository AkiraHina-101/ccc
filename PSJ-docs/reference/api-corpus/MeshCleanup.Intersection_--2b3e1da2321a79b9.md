# MeshCleanup.Intersection()

MeshCleanup.Intersection()

説明​

要素の交差エラーを検出します。

構文​

MeshCleanup.Intersection(...)

マクロ：MC_Intersection

リボン：MeshCleanup » Intersection

入力​

crlParts​

対象パートを指定する Cursor のリストです。

これは必須の入力です。

dTolerance​

交差を検出するための許容値を指定する Double です。

デフォルト値は0.001です。

iDisplayTypeOption​

表示される交差の種類を指定する Integer です。

0：パート内の交差のみ

1：すべての交差

2：パート間の交差

デフォルト値は0です。

iElementLayers​

エラー要素の周囲のレイヤー数を指定する Integer です。

デフォルト値は1です。

bErrorText​

要素の交差に関する出力情報をテキストデータとして出力ウィンドウと一時フォルダに出力するかどうかを指定する Boolean です。

デフォルト値は False です。

戻り値​

MESH_QUALITY_FREE_EDGE​

bSuccess​

関数の成功を表す Boolean の値です。

iIntersectElements​

交差する要素の数を表す Integer の値です。

crlElemEdges​

交差する要素を表す Cursor のリストです。

サンプルコード​

#モデルの準備
Geometry.Part.Cube(strName="Cube_1", iPartColor=6409934)
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], strName="Cube_2", iPartColor=13259210)
Geometry.Edge.Angle(
    [CursorPair(Node(452), Node(460)), 
    CursorPair(Node(92), Node(200)), 
    CursorPair(Node(28), Node(392)), 
    CursorPair(Node(12), Node(108))])

Geometry.Face.Edges(crlEdges=[Edge(60, 58)])

#パート内の交差を確認
res=MeshCleanup.Intersection(crlParts=[Part(1,2)], dTolerance=1e-06, iDisplayTypeOption=0)
JPT.Debugger(res)

#パート間の交差を確認
res=MeshCleanup.Intersection(crlParts=[Part(1,2)], dTolerance=1e-06, iDisplayTypeOption=2)
JPT.Debugger(res)
