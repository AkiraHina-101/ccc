# JPT.GetContactType()

JPT.GetContactType()

Description​

Get Abaqus contact type after inputting contact ID.

Syntax​

JPT.GetContactType(contactID)

Inputs​

contactID​

An Integer specifying Abaqus contact ID.

This is a required input.

Return Code​

-1: Inputted contactID does not exist on the model.

0: Inputted contactID is a General contact type.

1: Inputted contactID is a Tied contact type.

2: Inputted contactID is a All with self contact type.

Sample Code​

# Make a function to return detail description of contact type
def contact_case(iContactID: int) -> int:
    iContactType = JPT.GetContactType(iContactID)
    switch = {-1: "Error - Inputted contact ID {} does not exist on the model".format(iContactID),
              0: "Inputted contact ID {} - Type = General Contact".format(iContactID),
              1: "Inputted contact ID {} - Type = Tied Contact".format(iContactID),
              2: "Inputted contact ID {} - Type = All with self Contact".format(iContactID)}
    return switch.get(iContactType)

# Prepare model
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

# Output of the JPT.GetContactType utilities
JPT.Debugger(contact_case(2))
