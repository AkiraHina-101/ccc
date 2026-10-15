# JPT.GetSelectedGroups()

JPT.GetSelectedGroups()

説明​

選択されたグループのすべての情報を取得します。

構文​

JPT.GetSelectedGroups()

入力​

このユーティリティ関数には入力値が必要ありません。

戻り値​

選択されたグループのすべての情報を含む GroupVector オブジェクト、または List of DGroup オブジェクト。

サンプルコード​

# モデルの準備
Geometry.Part.Cube(iPartColor=7138156)
Geometry.Part.Cube(strName="Cube_2", iPartColor=5921475)
Geometry.Part.Cube(strName="Cube_3", iPartColor=6678117)
Geometry.Part.Cube(strName="Cube_4", iPartColor=11908427)
Geometry.Part.Cube(strName="Cube_5", iPartColor=15429611)
Geometry.Part.Cube(strName="Cube_6", iPartColor=7531634)
Geometry.Part.Cube(strName="Cube_7", iPartColor=12434775)
Tools.Group.CreateGroup(strGroupName="FaceGroup1", crlTargets=[Face(130)])
Tools.Group.CreateGroup(strGroupName="EdgeGroup1", crlTargets=[Edge(122, 121)])
Tools.Group.CreateGroup(strGroupName="PartGroup1", crlTargets=[Part(5)])
Tools.Group.CreateGroup(strGroupName="Element2DGroup1", crlTargets=[Elem(3166, 2439, 2367)])
Tools.Group.CreateGroup(strGroupName="NodeGroup1", crlTargets=[Node(1217, 977, 1116, 1286)])
Home.Find(strSearch="1 2 3 4 5", strSelectedType="Group")
JPT.ViewFitToModel()

# 選択されたすべてのグループの情報を取得
listSelGroups = JPT.GetSelectedGroups()
JPT.Debugger(listSelGroups)
JPT.Debugger(listSelGroups[4])
