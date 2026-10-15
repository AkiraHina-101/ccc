# Connections.SpringsDampers.Bush.TwoNodes()

Connections.SpringsDampers.Bush.TwoNodes()

Description​

Create bush connection

Syntax​

Connections.SpringsDampers.Bush.TwoNodes(iMethod=1, strName="BUSH_1", crlMaster=[], crlSlave=[], crCoord=None, dTol=DFLT_DBL, iGround=0, iOriMode=0, iEqual=1, poslVector=[], dlStiffness=[], dlDampCoef=[], dlDampConst=[], dRotStrain=DFLT_DBL, dTransStrain=DFLT_DBL, dRotStress=DFLT_DBL, dTransStress=DFLT_DBL, crEditObj=None)

Ribbon: Connections » SpringsDampers » Bush » TwoNodes

Inputs​

iMethod​

An Integer specifying the method.

The default value is 1.

strName​

A String specifying the name.

The default value is "BUSH_1".

crlMaster​

A List of Cursor specifying the master.

The default value is [].

crlSlave​

A List of Cursor specifying the slave.

The default value is [].

crCoord​

A Cursor specifying the coordinate.

The default value is None.

dTol​

A Double specifying the tolerance.

The default value is DFLT_DBL.

iGround​

An Integer specifying the ground.

The default value is 0.

iOriMode​

An Integer specifying the ori mode.

The default value is 0.

iEqual​

An Integer specifying the equal.

The default value is 1.

poslVector​

A Position List specifying the vector.

The default value is [].

dlStiffness​

A Double List specifying the stiffness.

The default value is [].

dlDampCoef​

A Double List specifying the damp coefficient .

The default value is [].

dlDampConst​

A Double List specifying the damp const.

The default value is [].

dRotStrain​

A Double specifying the rotation strain.

The default value is DFLT_DBL.

dTransStrain​

A Double specifying the trans strain.

The default value is DFLT_DBL.

dRotStress​

A Double specifying the rotation stress.

The default value is DFLT_DBL.

dTransStress​

A Double specifying the trans stress.

The default value is DFLT_DBL.

crEditObj​

A Cursor specifying the edit object.

The default value is None.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Connections.SpringsDampers.Bush.TwoNodes(iMethod=1, strName="BUSH_1", crlMaster=[], crlSlave=[], crCoord=None, dTol=DFLT_DBL, iGround=0, iOriMode=0, iEqual=1, poslVector=[], dlStiffness=[], dlDampCoef=[], dlDampConst=[], dRotStrain=DFLT_DBL, dTransStrain=DFLT_DBL, dRotStress=DFLT_DBL, dTransStress=DFLT_DBL, crEditObj=None)
