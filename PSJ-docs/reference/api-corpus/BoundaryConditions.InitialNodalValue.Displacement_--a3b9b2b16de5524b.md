# BoundaryConditions.InitialNodalValue.Displacement()

BoundaryConditions.InitialNodalValue.Displacement()

Description​

Create Initial Dynamic.

Syntax​

BoundaryConditions.InitialNodalValue.Displacement(...)

Ribbon: BoundaryConditions » InitialNodalValue » Displacement

Inputs​

strName​

A String specifying the name.

The default value is "InitialDisplacement1".

iType​

An Integer specifying the type.

The default value is 0.

vecInit​

A Vector specifying the initial.

The default value is [DFLT_DBL,DFLT_DBL,DFLT_DBL].

bSelNode​

A Boolean specifying the selection node.

The default value is False.

crNodeSet​

A Cursor specifying the node set.

The default value is None.

crTable​

A Cursor specifying the table.

The default value is None.

crCoord​

A Cursor specifying the coordinate.

The default value is None.

crlTargets​

A List of Cursor specifying the target.

The default value is [].

crEdit​

A Cursor specifying the edit.

The default value is None.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

BoundaryConditions.InitialNodalValue.Displacement(strName="InitialDisplacement1", iType=0, vecInit=[DFLT_DBL,DFLT_DBL,DFLT_DBL], bSelNode=False, crNodeSet=None, crTable=None, crCoord=None, crlTargets=[], crEdit=None)
