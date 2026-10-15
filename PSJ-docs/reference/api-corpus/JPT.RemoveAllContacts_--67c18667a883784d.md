# JPT.RemoveAllContacts()

JPT.RemoveAllContacts()

説明​

すべての既存の連絡先を削除します。

構文​

JPT.RemoveAllContacts()

入力​

このユーティリティ関数には入力値が必要ありません。

戻り値​

このユーティリティ関数には出力値がありません。

サンプルコード​

# モデルの準備
Geometry.Part.Cube(iPartColor=7011837)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], strName="Cube_2", iPartColor=6351851)
Geometry.Part.Cube(dlOrigin=[0.04, 0.0, 0.0], strName="Cube_3", iPartColor=16543085)
Geometry.Part.Cube(dlOrigin=[0.04, 0.01, 0.0], strName="Cube_4", iPartColor=11948369)
Geometry.Part.Cube(dlOrigin=[0.02, 0.01, 0.0], strName="Cube_5", iPartColor=12079955)
Geometry.Part.Cube(dlOrigin=[0.02, 0.01, 0.01], strName="Cube_6", iPartColor=14837474)
Tools.Group.CreateGroup(strGroupName="Cube_5-G0001", crlTargets=[Face(130)])
Tools.Group.CreateGroup(strGroupName="Cube_6-G0002", crlTargets=[Face(155)])
Connections.Contacts.Abaqus.ContactTable(
    strName="C0001_Cube_5-G0001_Cube_6-G0002",
    iContactType=1,
    dAdjustWidth=DFLT_DBL,
    dExtensionZone=DFLT_DBL,
    dMaxPenetration=DFLT_DBL,
    dSmoothAngle=DFLT_DBL,
    iFrictionType=-1,
    dFrictionCoeff1=DFLT_DBL,
    dFrictionCoeff2=DFLT_DBL,
    dShearStressLimit=DFLT_DBL,
    dSlipTolerance=DFLT_DBL,
    dStaticFrictionCoeff=DFLT_DBL,
    dKineticFrictionCoeff=DFLT_DBL,
    dDecayCoeff=DFLT_DBL,
    bAdjustPosition=True,
    dPositionTolerance=DFLT_DBL,
    iFormulationType=-1,
    iPressureOverclosureType=-1,
    dContactStiffness=DFLT_DBL,
    tshPressureOverclosure=[0, 0],
    tshClearanceData=[1, 2, DFLT_DBL, DFLT_DBL],
    tshPressureData=[1, 2, DFLT_DBL, DFLT_DBL],
    crplTargets=[CursorPair(Group(1), Group(2))],
    iContactColor=65280,
)
Tools.Group.CreateGroup(strGroupName="Cube_5-G0004", crlTargets=[Face(125)])
Tools.Group.CreateGroup(strGroupName="Cube_2-G0003", crlTargets=[Face(48)])
Connections.Contacts.Abaqus.ContactTable(
    strName="C0002_Cube_5-G0004_Cube_2-G0003",
    iContactType=1,
    dAdjustWidth=DFLT_DBL,
    dExtensionZone=DFLT_DBL,
    dMaxPenetration=DFLT_DBL,
    dSmoothAngle=DFLT_DBL,
    iFrictionType=-1,
    dFrictionCoeff1=DFLT_DBL,
    dFrictionCoeff2=DFLT_DBL,
    dShearStressLimit=DFLT_DBL,
    dSlipTolerance=DFLT_DBL,
    dStaticFrictionCoeff=DFLT_DBL,
    dKineticFrictionCoeff=DFLT_DBL,
    dDecayCoeff=DFLT_DBL,
    bAdjustPosition=True,
    dPositionTolerance=DFLT_DBL,
    iFormulationType=-1,
    iPressureOverclosureType=-1,
    dContactStiffness=DFLT_DBL,
    tshPressureOverclosure=[0, 0],
    tshClearanceData=[1, 2, DFLT_DBL, DFLT_DBL],
    tshPressureData=[1, 2, DFLT_DBL, DFLT_DBL],
    crplTargets=[CursorPair(Group(3), Group(4))],
    iContactColor=65280,
)
# 作成されたすべての連絡先を削除します（ここにAbaqusの連絡先タイプがあります）
JPT.RemoveAllContacts()
