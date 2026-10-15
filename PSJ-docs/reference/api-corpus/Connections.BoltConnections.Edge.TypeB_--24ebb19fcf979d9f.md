# Connections.BoltConnections.Edge.TypeB()

Connections.BoltConnections.Edge.TypeB()

Description​

Create Lbc TypeB Bolt Edge method.

Syntax​

Connections.BoltConnections.Edge.TypeB(...)

Ribbon: Connections » BoltConnections » Edge » TypeB

Inputs​

crlEdgeCur1​

A List of Cursor specifying the edge cur1.

This is a required input.

crlEdgeCur2​

A List of Cursor specifying the edge cur2.

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

bIfCreate2ADVCStaticProcessForBoltFixLength​

A Boolean specifying the if create2 ADVC static process for bolt fix length.

The default value is False.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Connections.BoltConnections.Edge.TypeB(crlEdgeCur1, crlEdgeCur2, strRbeName="RBE", strBarName="", iShaftType=0, crCurBarProperty=None, dPlaneTol=20.0, dMaxBoltHeight=100.0, bPretensionLoad=False, iSolverType=0, dForceValue=0.0, iPreTenDof=0, crCurCoord=None, iBoltFixLength=0, iTopSlot=0, dRBE1=0.0, dRBE2=0.0, dBotDtDia=0.0, dPitch=10.0, iBotRbeConnType=0, bIfCreate2ADVCStaticProcessForBoltFixLength=False)
