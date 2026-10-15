# Assemble.CylinderLayer()

Assemble.CylinderLayer()

説明​

シリンダーのトップフェース/ボトムフェースを指定して、内部円柱面を作成します。

構文​

Assemble.CylinderLayer(...)

マクロ: CylinderLayer

リボン: Assemble » Cylinder Layer

入力​

crFace​

円柱面のリストを指定する Cursor です。

デフォルト値はありません。

crNode​

フェースとエッジの長さを含む拡張部分を決定する節点を指定する Cursor です。

デフォルト値はありません。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean です：

True: プロセスが正常に実行されました。

False: 関数を実行できません。

サンプルコード​

Geometry.Part.Cylinder(bHollow=True, 
                       dTopInnerRadius=0.007, 
                       dBottomInnerRadius=0.007)
Geometry.Edge.OffsetLine(crlFaces=[Face(5)], 
                         crlEdges=[Edge(2)], 
                         iOffsetMethod=1,
                         dlOffsetDistance=[0.0015], 
                         iImprintMethod=0)

creating_status = Assemble.CylinderLayer(crFace=Face(5), crNode=Node(41))

JPT.Debugger(creating_status)
