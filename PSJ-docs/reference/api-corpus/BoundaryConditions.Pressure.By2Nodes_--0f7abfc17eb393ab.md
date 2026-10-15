# BoundaryConditions.Pressure.By2Nodes()

BoundaryConditions.Pressure.By2Nodes()

Description​

Create load boundary condition of 2nodes pressure.

Syntax​

BoundaryConditions.Pressure.By2Nodes(...)

Ribbon: BoundaryConditions » Pressure » By2Nodes

Inputs​

strName​

A String specifying the name.

The default value is "PressureLinear1".

crNodeA​

A Cursor specifying the node a.

The default value is None.

dPressureA​

A Double specifying the pressure a.

The default value is 0.0.

iNodeAUnit​

An Integer specifying the node a unit.

The default value is 0.

crNodeB​

A Cursor specifying the node .

The default value is None.

dPressureB​

A Double specifying the pressure .

The default value is 0.0.

iNodeBUnit​

An Integer specifying the node unit.

The default value is 0.

iDirection​

An Integer specifying the direction.

The default value is 0.

crlTargets​

A List of Cursor specifying the target.

The default value is [].

crEdit​

A Cursor specifying the edit.

The default value is None.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

BoundaryConditions.Pressure.By2Nodes(strName="PressureLinear1", crNodeA=None, dPressureA=0.0, iNodeAUnit=0, crNodeB=None, dPressureB=0.0, iNodeBUnit=0, iDirection=0, crlTargets=[], crEdit=None)
