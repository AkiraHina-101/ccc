# Assemble.SeparateFaces.Solid()

Assemble.SeparateFaces.Solid()

Description​

Separate a shared face between parts into distinct faces.

Syntax​

Assemble.SeparateFaces.Solid(...)

Ribbon: Assemble » Separate Faces » Solid

Inputs​

crlParts​

A List of Cursor specifying the target parts which have shared faces between them.

The default value is [].

crlFaces​

A List of Cursor specifying the target shared faces.

The default value is [].

iCreateGroup​

A Boolean specifying the type of group will be created.

The default value is 0.

Return Code​

A List Cursor of separated faces if success, or None if fail.

Sample Code​

Geometry.Part.Cube(iPartColor=15658599)
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], 
                   strName="Cube_2", 
                   iPartColor=7961077)
Assemble.AssembleFaceEx(ilPairFaceToMakeShareFace=[49, 24], 
                        dTolerance=0.001, 
                        iTypeConnectPos=0)

faces = Assemble.SeparateFaces.Solid(crlParts=[Part(1, 2)], 
                                     iCreateGroup=2)
JPT.Debugger(faces)
