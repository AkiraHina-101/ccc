# Geometry.Transform.Rotation()

Geometry.Transform.Rotation()

Description​

Rotate given parts by the specified angle.

Syntax​

Geometry.Transform.Rotation(...)

Macro: RotateBody

Ribbon: Geometry » Transform » Rotation

Inputs​

crlParts​

A List of Cursor specifying the parts to be rotated.

The default value is [].

posCenter​

A List specifying the center position of rotation.

The default value is [0,0,0].

vecAxis​

A List specifying the axis of rotation.

The default value is [1,0,0].

dAngle​

A Double specifying the rotation angle.

The default value is 0.

bCreateNewPart​

A Boolean specifying whether to copy a new one and perform the transform operation.

The default value is False.

bCopyLBC​

A Boolean specifying whether to copy load boundary condition of the original part to rotation part. This argument will be ignored if bCreateNewPart=False.

The default value is False.

bCopyProperty​

A Boolean specifying the option that copy property of the original part to rotation part. This argument will be ignored if bCreateNewPart=False.

The default value is False.

iCopyCount​

An Integer specifying the number of copy parts. This argument will be ignored if bCreateNewPart=False.

The default value is 1.

bMergeNode​

A Boolean specifying whether to merge nodes between the original part and the transformed one. This argument will be ignored if bCreateNewPart=False.

The default value is False.

dTol​

A Double specifying the merge tolerance. This argument should be specified when bMergeNode=True.

The default value is 1.0e-5.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

Geometry.Part.Cube()

rotate_status = Geometry.Transform.Rotation(crlParts=[Part(1)], 
                                            vecAxis=[0.0, 0.001, 0.0],
                                            dAngle=0.5,
                                            bCreateNewPart=True, 
                                            iCopyCount=3,
                                            dTol=1e-05)

JPT.Debugger(rotate_status)
