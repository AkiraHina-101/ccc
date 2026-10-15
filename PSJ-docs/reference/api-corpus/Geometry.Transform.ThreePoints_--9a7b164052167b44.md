# Geometry.Transform.ThreePoints()

Geometry.Transform.ThreePoints()

Description​

Move the parts by selecting three pairs of nodes. The selected parts are moved onto the target position in a one-to-one correspondence between source and target.

Syntax​

Geometry.Transform.ThreePoints(...)

Ribbon: Geometry » Transform » ThreePoints

Inputs​

crlTargetParts​

A List of Cursor specifying the parts to be transformed.

This is a required input.

poslOriginalPoints​

A List of Vector specifying the original points using for movement.
Three points are required corresponding to three original points.

This is a required input.

poslNextPoints​

A List of Vector specifying the next points using for movement. Three points are required corresponding to three next points, respectively to the three original pointed defined in poslOriginalPoints.

This is a required input.

bCreateNewPart​

A Boolean specifying whether to copy the transformed parts to new parts.

If True, a new part is copied to new location.

If False, the original part is moved to new location.

The default value is False.

bCopyLBC​

A Boolean specifying whether to copy load boundary conditions from the existing parts to new parts. This argument will only affect the functionality when bCreateNewPart=True.

The default value is False.

bCopyProperty​

A Boolean selecting whether to copy property from the existing part to new parts. This argument will only affect the functionality when bCreateNewPart=True.

The default value is False.

bCopyReference​

A Boolean selecting whether to copy reference from the existing part to new parts. This argument will only affect the functionality when bCreateNewPart=True.

The default value is False.

Return Code​

A List of Cursor specifying the created parts.

Sample Code​

target_part = Geometry.Part.Cube()
move_part = Geometry.Part.Cube(dlOrigin=[0.012, 0.0, 0.0], 
                               strName="Cube_2", 
                               iPartColor=6409934)

created_parts = Geometry.Transform.ThreePoints(crlTargetParts=[movedPart],
                                               poslOriginalPoints=[[0.022, 0, 0.01], 
                                                                   [0.022, 0.01, 0.01], 
                                                                   [0.012, 0, 0.01]],
                                               poslNextPoints=[[0.01, 0, 0.01], 
                                                               [0, 0, 0.01], 
                                                               [0, 0.01, 0.01]],
                                               bCreateNewPart=True, 
                                               bCopyLBC=True, 
                                               bCopyProperty=True,
                                               bCopyReference=True)

JPT.Debugger(created_parts)
