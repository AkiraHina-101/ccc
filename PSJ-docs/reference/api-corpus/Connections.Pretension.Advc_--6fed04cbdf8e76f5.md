# Connections.Pretension.Advc()

Connections.Pretension.Advc()

説明​

ADVCソルバーのボルトプリテンションを作成します。

構文​

Connections.Pretension.Advc(...)

リボン：Connections » Pretension » Advc

入力​

crlTargets​

ターゲットのリストを指定する Cursor リストです。フェースまたは1次元要素になります。

これは必須の入力です。

dForceValue​

プリテンション力の値を指定する Double です。

これは必須の入力です。

dlForceDirection​

ボルト締め付け方向を指定する Double のリストです。

これは必須の入力です。

dlControlNode​

制御節点の位置を指定する Double のリストです。

これは必須の入力です。

strName​

プリテンション力の名前を指定する String です。

デフォルト値は "PreTensionAdvc1" です。

bFixedLength​

ボルトの締め付け力が保持されているかどうかを指定する Boolean です。

デフォルト値は False です。

crLbcEnforcedVelocity​

プリテンション力（ADVC）の既存の強制速度を編集する Cursor です。crLbcPretensionADVC が指定された場合は、この引数を指定する必要があります。

デフォルト値は None です。

iDirectionUpdate​

締め付け方向が更新されたかどうかを指定する Integer です。

もし iDirectionUpdate=0 なら、この引数は無視されます。

もし iDirectionUpdate=1 なら、締め付け方向を更新します。

もし iDirectionUpdate=2 なら、締め付け方向を更新しません。

デフォルト値は 0 です。

iRefNodeId​

参照節点のIDを指定する Integer です。

デフォルト値は 0 です。

crLbcPretensionADVC​

既存のプリテンション力（ADVC）を指定する Cursor です。

このパラメータが使用されると、指定されたプリテンション力（ADVC）が変更されます。

None の場合は、新しいプリテンション力（ADVC）が作成されます。

デフォルト値は None です。

戻り値​

作成されたADVCプリテンションを指定する Cursor です。

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

creating_status = Connections.Pretension.Advc(crlTargets=[Face(8)], 
                                              dForceValue=1.0, 
                                              dlForceDirection=[0.0, -1.0, 0.0], 
                                              dlControlNode=[0.001419156, 0.02, 0.00012416],
                                              iRefNodeId=442)
JPT.Debugger(creating_status)
