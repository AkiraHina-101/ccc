# BoundaryConditions.Force.General()

BoundaryConditions.Force.General()

Description​

Create a general force applied to the selected Face, Edge or Node. User inputs the force values and it will apply the force to the selected items.

Syntax​

BoundaryConditions.Force.General(...)

Ribbon: Boundary Conditions » Force » General

Inputs​

strName​

A String specifying the name of force condition to be created.

The default value is "Force1".

forceLoad​

A FORCE_LBC specifying the general force parameters.

The default value is FORCE_LBC.

crlTargets​

A List of Cursor specifying the list of targets for general force. This targets can be Face, Edge or Node.

The default value is [].

crEdit​

A Cursor specifying an existing general force. 
If this parameter is used, the specified general force will be modified. 

If it is left None, a new general force will be created.

The default value is None.

Return Code​

A Cursor specifying the created LBC.

Sample Code​

Geometry.Part.Cube()

created_bcs = BoundaryConditions.Force.General(strName="Force1",
                                               forceLBC=FORCE_LBC(vecForce=[1.0,
                                                                            DFLT_DBL, 
                                                                            DFLT_DBL]),
                                               crlTargets=[Face(23)])

JPT.Debugger(created_bcs)
