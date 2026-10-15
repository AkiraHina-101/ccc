# Assemble.SeparateFaces.AllSharedNodes()

Assemble.SeparateFaces.AllSharedNodes()

Description​

Separate all shared nodes existing on the current model (Also separate all the existing shared faces).

Syntax​

Assemble.SeparateFaces.AllSharedNodes(...)

Macro: ASMSeparateAll2

Ribbon: Assemble » Separate Faces » All Shared Nodes

Inputs​

This function does not contains any input values.

Return Code​

A Boolean specifying whether the shared nodes are separated successfully or not:

True: All the shared nodes are separated successfully.

False: Cannot separate shared nodes/The model does not contains any shared nodes.

Sample Code​

Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], 
                   strName="Cube_2", 
                   iPartColor=6409934)

Assemble.FindMatingFaceEx(crlTaBodies=[Part(1, 2)], 
                          dMatingTol=0.000222222)
Assemble.AssembleFaceEx(ilPairFaceToMakeShareFace=[49, 24], 
                        dTolerance=0.000222222, 
                        iTypeConnectPos=0, 
                        bFitEdge=True)

separate_nodes = Assemble.SeparateFaces.AllSharedNodes()

JPT.Debugger(separate_nodes)
