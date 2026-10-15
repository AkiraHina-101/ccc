# Assemble.SharedFace()

Assemble.SharedFace()

Description​

Create an assembled face/shared face group.

Syntax​

Assemble.SharedFace(...)

Macro: CreateSharedFace

Ribbon: Assemble » Shared Face

Inputs​

This function does not contains any input values.

Return Code​

A List of Cursor specifying the created shared faces.

Sample Code​

Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], 
                   strName="Cube_2", 
                   iPartColor=15658599)
Geometry.Part.Cube(dlOrigin=[0.01, 0.01, 0.0], 
                   strName="Cube_3", 
                   iPartColor=14903267)

Assemble.FindMatingFaceEx(crlTaBodies=[Part(1, 
                                            2, 
                                            3)], 
                          dMatingTol=0.000222222)
Assemble.AssembleFaceEx(ilPairFaceToMakeShareFace=[48, 
                                                   73, 
                                                   49, 
                                                   24], 
                        dTolerance=0.000222222, 
                        iTypeConnectPos=0, 
                        bFitEdge=True)

created_shared_faces = Assemble.SharedFace()

JPT.Debugger(created_shared_faces)
