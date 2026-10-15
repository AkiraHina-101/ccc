# Connections.Pretension.Abaqus()

Connections.Pretension.Abaqus()

説明​

Abaqusソルバーのためのボルトプリテンションを作成します。

構文​

Connections.Pretension.Abaqus(...)

マクロ： PretensionAbaqus

リボン： Connections » Pretension » Abaqus

入力​

crTargets​

プリテンションフォースを作成するためのフェースまたは要素を指定する Cursor です。

この入力は必須です。

dForceValue​

プリテンションフォースの値を指定する Double です。

この入力は必須です。

dlForceDirection​

プリテンションフォースの方向を指定する Double リストです。

この入力は必須です。

dlControlNode​

制御節点の位置を指定する Double リストです。

この入力は必須です。

strName​

プリテンションフォースの名前を指定する String です。

デフォルト値は "PreTensionAbaqus1" です。

bFixedLength​

ボルトオプションの締付け力を保持するかどうかを指定する Boolean です。

デフォルト値は False です。

crLbcConstraint​

プリテンションフォースの編集対象である既存の固定制約オブジェクトを指定する Cursor です。crLbcPretensionAbaqus が指定されている場合は、この引数を指定する必要があります。それ以外の場合は、新しい固定制約オブジェクトが作成されます。

デフォルト値は None です。

crLbcPretensionAbaqus​

既存のプリテンションフォース（Abaqus）を指定する Cursor です。プリテンションフォースが指定されていない場合は、新しいものが作成されます。指定されたプリテンションフォース（Abaqus）がある場合は、修正されます。

デフォルト値は None です。

iRefNodeID​

参照節点を指定する Int です。

この入力は必須です。

戻り値​

作成されたAbaqusプリテンションを指定する Cursor です。

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

max_node_id=JPT.GetMaxIDEntity(JPT.EntityType.NODE)

creating_status = Connections.Pretension.Abaqus(crlTargets=[Face(11)], 
                                                dForceValue=1000000.0, 
                                                dlForceDirection=[0.000000,
                                                                  -1.000000,
                                                                  0.000000],
                                                dlControlNode=[0.001419156, 
                                                               0.02, 
                                                               0.00012416],
                                                iRefNodeID=max_node_id+1)

JPT.Debugger(creating_status)
