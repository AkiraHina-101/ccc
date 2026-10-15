# Assemble.FindMatingFaceEx()

Assemble.FindMatingFaceEx()

Description​

Find the mating faces which can be used in Assemble.AssembleFaceEx() function.

Syntax​

Assemble.FindMatingFaceEx(...)

Ribbon: Assemble » Find Mating Face

Inputs​

crlTaBodies​

A List of Cursor specifying the parts to make assemble faces.

This is the required input.

crlMasterFace​

A List of Cursor specifying the master faces.

The default value is [].

crlSlaveFace​

A List of Cursor specifying the slave faces.

The default value is [].

dTolerance​

A Double specifying the tolerance.

The default value is 0.1.

Return Code​

A list of pair mating faces ID found.

Sample Code​

cube1 = Geometry.Part.Cube()
cube2 = Geometry.Part.Cube(dlOrigin=[0.011, 0.0, 0.0], 
                           strName="Cube_2", 
                           iPartColor=6409934)

pair_faces = Assemble.FindMatingFaceEx(crlTaBodies=[cube1, cube2], 
                                      dMatingTol=0.001)

JPT.Debugger(pair_faces)
