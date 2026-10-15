# JPT.GetAllSubGroups()

JPT.GetAllSubGroups()

説明​

すべてのサブグループ情報を取得します。

構文​

JPT.GetAllSubGroups()

入力​

このユーティリティ機能には入力値は必要ありません。

戻り値​

すべての既存要素の情報を含む SubGroupVector オブジェクトまたは DSubGroup オブジェクトのリスト。

サンプルコード​

# モデルの準備
Geometry.Part.Cube(iPartColor=6409934)
Tools.Group.CreateGroup(
    strGroupName="Group1", 
    crlTargets=[Face(26, 22)])
Groups.RightClick.AddSubGroup()
Groups.RightClick.AddSubGroup()
Groups.RightClick.CopyGroup(
    crlGroups=[Group(1)], 
    strlNames=["Group1(1)"], 
    crSubGroup=SubGroup(1), bKeepOriginalGroup=True)
Groups.RightClick.CopyGroup(
    crlGroups=[Group(1)], 
    strlNames=["Group1(2)"], 
    crSubGroup=SubGroup(2), bKeepOriginalGroup=True)

# すべてのサブグループを取得
listSubGroups = JPT.GetAllSubGroups()
JPT.Debugger(listSubGroups)

# モデルのすべてのサブグループを反復処理
for subGroup in listSubGroups:
    JPT.Debugger(subGroup)    
    # DItemにキャスト
    dItem = JPT.CastToDItem(subGroup)
    JPT.Debugger(dItem)
    # サブグループの子をアクセス
    children = dItem.children
    JPT.Debugger(children)
    # すべての子を反復処理
    for child in children:
        JPT.Debugger(child)
