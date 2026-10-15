# JPT.GetAllGroups()

JPT.GetAllGroups()

説明​

すべての既存のグループの情報を取得します。

構文​

JPT.GetAllGroups()

入力​

このユーティリティ関数は入力値を必要としません。

戻り値​

すべての既存のグループのすべての情報を含む GroupVector オブジェクトまたは List of DGroup オブジェクト。

サンプルコード​

# モデルの準備
Geometry.Part.Cube()
Geometry.Part.Cube(strName="Cube_2")
Geometry.Part.Cube(strName="Cube_3")
Tools.Group.CreateGroup(strGroupName="Group1", crlTargets=[Part(1)])
Tools.Group.CreateGroup(strGroupName="Group2", crlTargets=[Face(47, 48, 49, 50, 51, 52)])
Tools.Group.CreateGroup(strGroupName="Group3", crlTargets=[Elem(2784, 2296, 2677, 2295, 3144, 2977)])
JPT.ViewFitToModel()

# すべての既存のグループの情報を取得
listDGroups = JPT.GetAllGroups()
JPT.Debugger(listDGroups)

# リスト内の各既存グループの関連情報をすべて印刷
for group in listDGroups:
    JPT.Debugger(group)
