# BoundaryConditions.DofSet()

BoundaryConditions.DofSet()

Description​

Create the degrees of freedom in the analysis set(ASET) in TS-Solver.

Syntax​

BoundaryConditions.DofSet(...)

Ribbon: BoundaryConditions » DofSet

Inputs​

crlTargets​

A List of Cursor specifying the list of the target(face/edge/node) for creating the ASET.

The default value is [].

strName​

A String specifying the name of the ASET to be created.

The default value is "DofSet1".

iDwDof​

An Integer specifying the degree of freedom(DoF). This value is calculated by using OR operator between the following options:

 | Value | Option

 | 1 | Ux (x translation)

 | 2 | Uy (y translation)

 | 4 | Uz (z translation)

 | 8 | Rx (x rotation)

 | 16 | Ry (y rotation)

 | 32 | Rz (z rotation)

For example, if x, y, z translation must be constrained, then the iDwDof = 1 |2 |4 = 7.

The default value is 7.

crCurCoord​

A Cursor specifying the coordinate from which the fixed constraint is created.

The default value is None(global coordinate).

crTable​

A Cursor specifying the table of field data.

The default value is None.

crEdit​

A Cursor specifying an existing DoF Set. If this parameter is used, the specified DoF Set will be modified. If it is left None, a new DoF Set will be created.

The default value is None.

Return Code​

A Cursor specifying the created LBC.

Sample Code​

Geometry.Part.Cube()

created_lbc = BoundaryConditions.DofSet(crlTargets=[Face(26)],
                                        strName="DofSet1",
                                        iDwDof=7)

JPT.Debugger(created_lbc)
