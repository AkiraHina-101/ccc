# Connections.Pretension.General()

Connections.Pretension.General()

概要​

一般的にボルトのプリテンションを作成します（特定のソルバー用ではありません）。

構文​

Connections.Pretension.General(...)

マクロ：Pretension

リボン：Connections » Pretension » General

入力​

crlFaces​

プリテンション力に使用する対象フェースを指定する Cursor リスト。

これは必須の入力です。

dForceValue​

プリテンション力の値を指定する Double 。

これは必須の入力です。

strName​

プリテンション力の名前を指定する String 。

デフォルト値は "BoltLoad001" です。

iForceDirection​

プリテンション力の方向を指定する Integer 。

iForceDirection=0 の場合、方向はローカル座標系のUX軸に沿っています。

iForceDirection=1 の場合、方向はローカル座標系のUY軸に沿っています。

iForceDirection=2 の場合、方向はローカル座標系のUZ軸に沿っています。

デフォルト値は 0 です。

bFixedLength​

ボルトの締付け力を保持するかどうかを指定する Boolean 型。

デフォルト値は False です。

crLocalCoordinate​

プリテンション力の方向を定義するために使用されるローカル座標系を指定する Cursor 。
指定されていない場合、グローバル座標系が適用されます。

デフォルト値は None です。

戻り値​

作成されたADVCプリテンションを指定する Cursor 。

サンプルコード​

Geometry.Part.Cylinder(dHeight=0.04,
                       iPartColor=6447843)
MeshEdit.CreateNode.Between2Nodes(iNodeID=363,
                                  dX=7.66044e-06, 
                                  dY=2e-05, 
                                  dZ=-6.42788e-06, 
                                  iNumberofNodes=1, 
                                  crlNodes=[Node(65, 
                                                 66)])
MeshEdit.CreateNode.Between2Nodes(iNodeID=364, 
                                  dX=-1.73648e-06, 
                                  dY=2e-05, 
                                  dZ=9.84808e-06, 
                                  iNumberofNodes=1, 
                                  crlNodes=[Node(21, 
                                                 22)])
MeshEdit.CreateNode.Between2Nodes(iNodeID=365, 
                                  dX=-3.4202e-06, 
                                  dY=2e-05, 
                                  dZ=-9.39693e-06, 
                                  iNumberofNodes=1, 
                                  crlNodes=[Node(51, 
                                                 52)])
Geometry.BodyCut.By3Points(crPart=Part(1), 
                           poslPoints=[[-0.003420201433256686, 0.02, -0.009396926207859084], 
                                       [0.007660444431189778, 0.02, -0.006427876096865396], 
                                       [-0.001736481776669303, 0.02, 0.00984807753012208]], 
                           bSplitOnly=True)
MeshEdit.DeleteNode()

creating_status = Connections.Pretension.General(crlFaces=[Face(4, 3)], 
                                                 dForceValue=1.0, 
                                                 strName="BoltLoad001", 
                                                 iForceDirection=2)

JPT.Debugger(creating_status)
