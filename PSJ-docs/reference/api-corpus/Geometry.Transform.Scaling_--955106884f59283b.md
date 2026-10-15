# Geometry.Transform.Scaling()

Geometry.Transform.Scaling()

Description​

Resize an part about its centroid or a coordinate system. It can resize different dimensions at different scales.

Syntax​

Geometry.Transform.Scaling(...)

Macro: ScaleBody

Ribbon: Geometry » Transform » Scaling

Inputs​

crlParts​

A List of Cursor specifying the parts to be scaled.

This is a required input.

dlScaleVector​

A List of Double specifying the scale vector. It defines how much scaling is done in each direction.

The default value is [1.0,1.0,1.0].

dlScaleCenter​

A List of Double specifying the scale center. It defines a point about which the given part figure scales.

The default value is [0.0,0.0,0.0].

crCoordinate​

A Cursor specifying the coordinate system.

The default value is None.

bCreateNew​

A Boolean specifying whether to create new part or attach to original parts.

The default value is False.

bCopyLbc​

A Boolean specifying whether to copy load boundary condition of original part to scaled part.

The default value is False.

bCopyProperty​

A Boolean specifying whether to copy property of original part to scaled part.

The default value is False.

bUsePartCenter​

A Boolean specifying whether to use original part center as scaled center.

The default value is True.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

Geometry.Part.Cube()

scaling_status = Geometry.Transform.Scaling(crlParts=[Part(1)], 
                                            dlScaleVector=[1.5, 
                                                           0.5, 
                                                           0.5], 
                                            bCreateNew=True)

JPT.Debugger(scaling_status)
