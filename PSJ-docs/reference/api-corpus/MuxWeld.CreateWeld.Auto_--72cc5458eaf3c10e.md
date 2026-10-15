# MuxWeld.CreateWeld.Auto()

MuxWeld.CreateWeld.Auto()

Description​

Auto create weld

Syntax​

MuxWeld.CreateWeld.Auto(iIconnectattributeMethod, strStrconnectattributeName, crlMasterTargets, crlSlaveTargets, iIconnectattributeCoordsys, crEdit)

Ribbon: MuxWeld » CreateWeld » Auto

Inputs​

iIconnectattributeMethod​

An Integer specifying the iconnectattribute method.

This is a required input.

strStrconnectattributeName​

A String specifying the strconnectattribute name.

This is a required input.

crlMasterTargets​

A List of Cursor specifying the master target.

This is a required input.

crlSlaveTargets​

A List of Cursor specifying the slave target.

This is a required input.

iIconnectattributeCoordsys​

An Integer specifying the iconnectattribute coordsys.

This is a required input.

crEdit​

A Cursor specifying the edit.

This is a required input.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

MuxWeld.CreateWeld.Auto(iIconnectattributeMethod, strStrconnectattributeName, crlMasterTargets, crlSlaveTargets, iIconnectattributeCoordsys, crEdit)
