# JPT.GetContactType()

JPT.GetContactType()

説明​

Abaqusの接触タイプを取得した後、contactID を入力します。

構文​

JPT.GetContactType(contactID)

入力​

contactID​

Abaqusの接触IDを指定する Integer 。

これは必須の入力です。

戻り値​

-1：入力された contactID はモデル上に存在しません。

0：入力された contactID は General 接触タイプです。

1：入力された contactID は Tied 接触タイプです。

2：入力された contactID は All with self 接触タイプです。

サンプルコード​

# 接触タイプの詳細説明を返す関数を作成する
def contact_case(iContactID: int) -> int:
    iContactType = JPT.GetContactType(iContactID)
    switch = {-1: "エラー - 入力された接触ID {} はモデル上に存在しません".format(iContactID),
              0: "入力された接触ID {} - タイプ = 一般接触".format(iContactID),
              1: "入力された接触ID {} - タイプ = 固定接触".format(iContactID),
              2: "入力された接触ID {} - タイプ = 自己接触オール".format(iContactID)}
    return switch.get(iContactType)

# モデルを準備する
Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], strName="Cube_2", iPartColor=6409934)
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], strName="Cube_3", iPartColor=13259210)
Tools.Group.CreateGroup(strGroupName="ContactAbaqus_2_Manual_Face_M", crlTargets=[Face(49)])
Tools.Group.CreateGroup(strGroupName="ContactAbaqus_2_Manual_Face_S", crlTargets=[Face(76)])
Connections.Contacts.Abaqus.ManualFace(strName="ContactAbaqus_2", dAdjustWidth=DFLT_DBL, dExtensionZone=DFLT_DBL,
    dMaxPenetration=DFLT_DBL, dSmoothAngle=DFLT_DBL, iFrictionType=-1, dFrictionCoeff1=DFLT_DBL,
    dFrictionCoeff2=DFLT_DBL, dShearStressLimit=DFLT_DBL, dSlipTolerance=DFLT_DBL, dStaticFrictionCoeff=DFLT_DBL,
    dKineticFrictionCoeff=DFLT_DBL, dDecayCoeff=DFLT_DBL, bAdjustPosition=True, dPositionTolerance=DFLT_DBL,
    iFormulationType=-1, iPressureOverclosureType=-1, dContactStiffness=DFLT_DBL, tshPressureOverclosure=[0, 0],
    iThermalConductanceDef=-1, tshClearanceData=[1, 2, DFLT_DBL, DFLT_DBL],
    tshPressureData=[1, 2, DFLT_DBL, DFLT_DBL], crplTargets=[CursorPair(Group(1), Group(2))],
    iContactColor=16711680)
Tools.Group.CreateGroup(strGroupName="ContactAbaqus_3_Manual_Face_M", crlTargets=[Face(24)])
Tools.Group.CreateGroup(strGroupName="ContactAbaqus_3_Manual_Face_S", crlTargets=[Face(75)])
Connections.Contacts.Abaqus.ManualFace(strName="ContactAbaqus_3", iContactType=1, dAdjustWidth=DFLT_DBL,
    dExtensionZone=DFLT_DBL, dMaxPenetration=DFLT_DBL, dSmoothAngle=DFLT_DBL, iFrictionType=-1,
    dFrictionCoeff1=DFLT_DBL, dFrictionCoeff2=DFLT_DBL, dShearStressLimit=DFLT_DBL, dSlipTolerance=DFLT_DBL,
    dStaticFrictionCoeff=DFLT_DBL, dKineticFrictionCoeff=DFLT_DBL, dDecayCoeff=DFLT_DBL, bAdjustPosition=True,
    dPositionTolerance=DFLT_DBL, iFormulationType=-1, iPressureOverclosureType=-1, dContactStiffness=DFLT_DBL,
    tshPressureOverclosure=[0, 0], iThermalConductanceDef=-1, tshClearanceData=[1, 2, DFLT_DBL, DFLT_DBL],
    tshPressureData=[1, 2, DFLT_DBL, DFLT_DBL], crplTargets=[CursorPair(Group(3), Group(4))],
    iContactColor=16711680)

# JPT.GetContactType のユーティリティの出力
JPT.Debugger(contact_case(2))
