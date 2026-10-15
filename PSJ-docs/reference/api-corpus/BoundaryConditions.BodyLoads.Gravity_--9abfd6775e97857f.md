# BoundaryConditions.BodyLoads.Gravity()

BoundaryConditions.BodyLoads.Gravity()

Description​

Define the acceleration load of gravity to the selected part. User inputs the value of the acceleration load of gravity and it will return the acceleration load of gravity to the selected parts.

Syntax​

BoundaryConditions.BodyLoads.Gravity(...)

Ribbon: Boundary Conditions » Body Loads » Gravity

Inputs​

strName​

A String specifying the name of gravity load to be created.

The default value is "Gravity1"

dlGravity​

A Double List specifying the list of acceleration value of each direction (X,Y,Z).

This is a required input.

crCurCoord​

A Cursor specifying the coordinate system for the load.

The default value is None(global coordinate system).

crlTargets​

A List of Cursor specifying the list of target parts for creating the acceleration load of gravity.

The default value is [].

crEdit​

A Cursor specifying an existing gravity load. If this parameter is used, the specified gravity load will be modified. If it is left None, a new gravity load will be created.

The default value is None.

Return Code​

A Cursor specifying the created LBC.

Sample Code​

Geometry.Part.Cube()

created_bcs = BoundaryConditions.BodyLoads.Gravity(strName="Gravity1", 
                                                   dlGravity=[0.0, 0.0, -9810.0],
                                                   crlTargets=[Part(1)])

JPT.Debugger(created_bcs)
