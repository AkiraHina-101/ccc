# Connections.BoltConnections.Face.TypeB()

Connections.BoltConnections.Face.TypeB()

Description​

Create Lbc TypeB Bolt Face method.

Syntax​

Connections.BoltConnections.Face.TypeB(...)

Ribbon: Connections » BoltConnections » Face » TypeB

Inputs​

crlFaceCur1​

A List of Cursor specifying the face cur1.

This is a required input.

crlFaceCur2​

A List of Cursor specifying the face cur2.

This is a required input.

strRbeName​

A String specifying the rbe name.

The default value is "RBE".

strBarName​

A String specifying the bar name.

The default value is "".

iShaftType​

An Integer specifying the shaft type.

The default value is 0.

crCurBarProperty​

A Cursor specifying the cur bar property.

The default value is None.

dPlaneTol​

A Double specifying the plane tolerance.

The default value is 20.0.

dMaxBoltHeight​

A Double specifying the maximum bolt height.

The default value is 100.0.

dMaxDiameter​

A Double specifying the maximum diameter.

The default value is 0.0.

dMinDiameter​

A Double specifying the minimum diameter.

The default value is 0.0.

bPretensionLoad​

A Boolean specifying the pretension load.

The default value is False.

iSolverType​

An Integer specifying the solver type.

The default value is 0.

dForceValue​

A Double specifying the force value.

The default value is 0.0.

iPreTenDof​

An Integer specifying the pre ten dof.

The default value is 0.

crCurCoord​

A Cursor specifying the cur coordinate.

The default value is None.

iBoltFixLength​

An Integer specifying the bolt fix length.

The default value is 0.

iTopSlot​

An Integer specifying the top slot.

The default value is 0.

dRBE1​

A Double specifying the r e1.

The default value is 0.0.

dRBE2​

A Double specifying the r e2.

The default value is 0.0.

dBotDtDia​

A Double specifying the bot data dia.

The default value is 0.0.

dPitch​

A Double specifying the pitch.

The default value is 10.0.

iBotRbeConnType​

An Integer specifying the bot rbe conn type.

The default value is 0.

dScale1​

A Double specifying the scale1.

The default value is 1.10.

bIsCreate2ADVCStaticProcessForFixLength​

A Boolean specifying the is create2 ADVC static process for fix length.

The default value is False.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Connections.BoltConnections.Face.TypeB(crlFaceCur1, crlFaceCur2, strRbeName="RBE", strBarName="", iShaftType=0, crCurBarProperty=None, dPlaneTol=20.0, dMaxBoltHeight=100.0, dMaxDiameter=0.0, dMinDiameter=0.0, bPretensionLoad=False, iSolverType=0, dForceValue=0.0, iPreTenDof=0, crCurCoord=None, iBoltFixLength=0, iTopSlot=0, dRBE1=0.0, dRBE2=0.0, dBotDtDia=0.0, dPitch=10.0, iBotRbeConnType=0, dScale1=1.10, bIsCreate2ADVCStaticProcessForFixLength=False)
