# Connections.SpringsDampers.BushGeneral()

Connections.SpringsDampers.BushGeneral()

Description​

Unknown Description

Syntax​

Connections.SpringsDampers.BushGeneral(iMethod, strName, crlMaster, crlSlave, crCoord, dTol, iGround, iOriMode, iEqual, poslVector, dlStiffness, dlDampCoef, dlDampConst, dRotStrain, dTransStrain, dRotStress, dTransStress, crEditObj)

Macro: Bush

Ribbon: Connections » SpringsDampers » BushGeneral

Inputs​

iMethod​

An Integer specifying the method.

This is a required input.

strName​

A String specifying the name.

This is a required input.

crlMaster​

A List of Cursor specifying the master.

This is a required input.

crlSlave​

A List of Cursor specifying the slave.

This is a required input.

crCoord​

A Cursor specifying the coordinate.

This is a required input.

dTol​

A Double specifying the tolerance.

This is a required input.

iGround​

An Integer specifying the ground.

This is a required input.

iOriMode​

An Integer specifying the ori mode.

This is a required input.

iEqual​

An Integer specifying the equal.

This is a required input.

poslVector​

A Position List specifying the vector.

This is a required input.

dlStiffness​

A Double List specifying the stiffness.

This is a required input.

dlDampCoef​

A Double List specifying the damp coefficient .

This is a required input.

dlDampConst​

A Double List specifying the damp const.

This is a required input.

dRotStrain​

A Double specifying the rotation strain.

This is a required input.

dTransStrain​

A Double specifying the trans strain.

This is a required input.

dRotStress​

A Double specifying the rotation stress.

This is a required input.

dTransStress​

A Double specifying the trans stress.

This is a required input.

crEditObj​

A Cursor specifying the edit object.

This is a required input.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Connections.SpringsDampers.BushGeneral(iMethod, strName, crlMaster, crlSlave, crCoord, dTol, iGround, iOriMode, iEqual, poslVector, dlStiffness, dlDampCoef, dlDampConst, dRotStrain, dTransStrain, dRotStress, dTransStress, crEditObj)
