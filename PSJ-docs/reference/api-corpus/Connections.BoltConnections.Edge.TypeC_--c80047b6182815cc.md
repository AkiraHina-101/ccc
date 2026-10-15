# Connections.BoltConnections.Edge.TypeC()

Connections.BoltConnections.Edge.TypeC()

Description​

Create Lbc TypeC Bolt Edge method.

Syntax​

Connections.BoltConnections.Edge.TypeC(...)

Ribbon: Connections » BoltConnections » Edge » TypeC

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

dPlaneTol​

A Double specifying the plane tolerance.

The default value is 20.0.

dMaxBoltHeight​

A Double specifying the maximum bolt height.

The default value is 100.0.

iConnectionType​

An Integer specifying the connection type.

The default value is 0.

iCoincidentNodes​

An Integer specifying the coincident nodes.

The default value is 1.

dTolerance​

A Double specifying the tolerance.

The default value is 0.0.

iGround​

An Integer specifying the ground.

The default value is 0.

dStiffnessX​

A Double specifying the stiffness x.

The default value is 0.0.

dStiffnessY​

A Double specifying the stiffness y.

The default value is 0.0.

dStiffnessZ​

A Double specifying the stiffness z.

The default value is 0.0.

iLocalStiffUnit​

An Integer specifying the local stiff unit.

The default value is 0.

dRotateStiffX​

A Double specifying the rotate stiff x.

The default value is 0.0.

dRotateStiffY​

A Double specifying the rotate stiff y.

The default value is 0.0.

dRotateStiffZ​

A Double specifying the rotate stiff z.

The default value is 0.0.

iLocalRotateStiffUnit​

An Integer specifying the local rotate stiff unit.

The default value is 0.

dDampCoef​

A Double specifying the damp coefficient .

The default value is 0.0.

dStressCoef​

A Double specifying the stress coefficient .

The default value is 0.0.

crCurCoord​

A Cursor specifying the cur coordinate.

The default value is None.

iTopRbeType​

An Integer specifying the top rbe type.

The default value is 0.

dTopPitch​

A Double specifying the top pitch.

The default value is 10.

dTopRemoveDepth​

A Double specifying the top remove depth.

The default value is 0.0.

iBotRbeType​

An Integer specifying the bot rbe type.

The default value is 0.

dBotPitch​

A Double specifying the bot pitch.

The default value is 10.

dBotRemoveDepth​

A Double specifying the bot remove depth.

The default value is 0.0.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Connections.BoltConnections.Edge.TypeC(crlEdgeCur1, crlEdgeCur2, strRbeName="RBE", dPlaneTol=20.0, dMaxBoltHeight=100.0, iConnectionType=0, iCoincidentNodes=1, dTolerance=0.0, iGround=0, dStiffnessX=0.0, dStiffnessY=0.0, dStiffnessZ=0.0, iLocalStiffUnit=0, dRotateStiffX=0.0, dRotateStiffY=0.0, dRotateStiffZ=0.0, iLocalRotateStiffUnit=0, dDampCoef=0.0, dStressCoef=0.0, crCurCoord=None, iTopRbeType=0, dTopPitch=10, dTopRemoveDepth=0.0, iBotRbeType=0, dBotPitch=10, dBotRemoveDepth=0.0)
