# JPT.GetAllContacts()

JPT.GetAllContacts()

説明​

すべての既存接触の情報を取得します。

構文​

JPT.GetAllContacts()

入力​

このユーティリティ関数には入力値は必要ありません。

戻り値​

すべての既存カスタムノートの情報を含む ContactVector オブジェクトまたは List of DContact オブジェクト。

サンプルコード​

# モデルの準備
Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], strName="Cube_2", iPartColor=6409934)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], strName="Cube_3", iPartColor=13259210)
JPT.ViewFitToModel()

Tools.Group.CreateGroup(strGroupName="Cube_2(49)-G0002", crlTargets=[Face(49)])
Tools.Group.CreateGroup(strGroupName="Cube_1(24)-G0001", crlTargets=[Face(24)])

Connections.Contacts.TSSS.ContactTable(
    strName="C0001_Cube_2-G0002_Cube_1-G0001", 
    sunshineContact=SUNSHINE_CONTACT(
        iType=1, 
        dERROR=0.001, 
        dFRIC=DFLT_DBL, 
        dSLIDE=DFLT_DBL, 
        iICOORD=1, 
        dSFACT=DFLT_DBL, 
        dSFACTT=DFLT_DBL), 
    crplTarget=[CursorPair(Group(1), Group(2))], iColor=65280)
Tools.Group.CreateGroup(strGroupName="Cube_3(75)-G0004", crlTargets=[Face(75)])
Tools.Group.CreateGroup(strGroupName="Cube_2(50)-G0003", crlTargets=[Face(50)])
Connections.Contacts.TSSS.ContactTable(strName="C0002_Cube_3-G0004_Cube_2-G0003", 
    sunshineContact=SUNSHINE_CONTACT(
        dERROR=0.001, 
        dFRIC=DFLT_DBL, 
        dSLIDE=DFLT_DBL, 
        iICOORD=1, 
        dSFACT=DFLT_DBL, 
        dSFACTT=DFLT_DBL), 
    crplTarget=[CursorPair(Group(3), Group(4))], iColor=65280)

# すべての既存接触の情報を取得します
listDContacts=JPT.GetAllContacts() 
JPT.Debugger(listDContacts)

# 各既存接触の関連情報をすべて出力
for contact in listDContacts:
    JPT.Debugger(contact)
