# Connections.MassElements()

Connections.MassElements()

Description​

Connection new mass

Syntax​

Connections.MassElements(...)

Ribbon: Connections » MassElements

Inputs​

strName​

A String specifying the name.

This is a required input.

crlTargets​

A List of Cursor specifying the target.

This is a required input.

dMass​

A Double specifying the mass.

The default value is 0.01.

iDof​

An Integer specifying the dof.

The default value is 1.

bDesigner​

A Boolean for license switcher. If true, it is used in Designer.

The default value is True.

crCoordinate​

A Cursor specifying the coordinate.

The default value is None.

dOffset0​

A Double specifying the offset0.

The default value is 0.0.

dOffset1​

A Double specifying the offset1.

The default value is 0.0.

dOffset2​

A Double specifying the offset2.

The default value is 0.0.

dInertia0​

A Double specifying the inertia0.

The default value is 0.0.

dInertia1​

A Double specifying the inertia1.

The default value is 0.0.

dInertia2​

A Double specifying the inertia2.

The default value is 0.0.

dInertia3​

A Double specifying the inertia3.

The default value is 0.0.

dInertia4​

A Double specifying the inertia4.

The default value is 0.0.

dInertia5​

A Double specifying the inertia5.

The default value is 0.0.

crEdit​

A Cursor specifying the edit.

The default value is None.

bUpdateDispCS​

A Boolean specifying the update displacement coordinate system.

The default value is True.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Geometry.Part.Cube()
Connections.MassElements(strName="Mass1", crlTargets=[Node(5)], dMass=0.01, iDof=1, bDesigner=True, 
                        crCoordinate=None, dOffset0=0.0, dOffset1=0.0, dOffset2=0.0, dInertia0=0.0, 
                        dInertia1=0.0, dInertia2=0.0, dInertia3=0.0, dInertia4=0.0, dInertia5=0.0, 
                        crEdit=None, bUpdateDispCS=True)
