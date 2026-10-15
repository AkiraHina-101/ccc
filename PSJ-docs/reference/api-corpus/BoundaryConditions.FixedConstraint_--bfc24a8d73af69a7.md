# BoundaryConditions.FixedConstraint()

BoundaryConditions.FixedConstraint()

Description​

Create a fixed constraint on selected Face, Edge or Node. User inputs the degree of freedom of fixed constraint and it will return a fixed constraint on selected items.

Syntax​

BoundaryConditions.FixedConstraint(...)

Ribbon: Boundary Conditions » Fixed Constraint

Inputs​

strName​

A String specifying the name of the fixed constraint to be created.

The default value is "Constraint1".

iDwDof​

An Integer specifying the degree of freedom (dof). This value is calculated by using OR operator between the following options:

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

iType​

An Integer specifying the type that is one of the following.

0: None (do not use type)

1: SUPPORT type.

2: USET type.

The default value is 0.

iUsetType​

An Integer specifying the USET type. The USET type is only used when setting iType=2. The USET type is one of the following.

0: U1

1: U2

2: U3

3: U4

4: U5

5: U6

The default value is 0

crTable​

A Cursor specifying the table of field data.

The default value is None.

bAbaqusFixed​

A Boolean to enable (True) or disable (False) the Abaqus fixed. This parameter is used for Abaqus I/F.

The default value is False.

crlTargets​

A List of Cursor specifying the list of targets for fixed constraint. This target can be Face, Edge or Node.

The default value is [].

crEdit​

A Cursor specifying an existing fixed constraint. If this parameter is used, the specified fixed constraint will be modified. If it is left None, a new fixed constraint will be created.

The default value is None.

Return Code​

A Cursor specifying the created LBC.

Sample Code​

Geometry.Part.Cube()
creating_status = BoundaryConditions.FixedConstraint(crlTargets=[Face(26)])
JPT.Debugger(creating_status)
