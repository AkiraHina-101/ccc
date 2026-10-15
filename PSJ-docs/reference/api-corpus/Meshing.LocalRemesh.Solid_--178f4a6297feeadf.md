# Meshing.LocalRemesh.Solid()

Meshing.LocalRemesh.Solid()

Description​

Mesh the selected solid elements locally without affecting the other positions.

Syntax​

Meshing.LocalRemesh.Solid(...)

Ribbon: Meshing » LocalRemesh » Solid

Inputs​

crlParts​

A List of Cursor specifying the parts list to perform remesh.

This is a required input.

dlCenter​

A List of Double specifying the center of the sphere. This sphere is the region to remesh.

The default value is [0.0,0.0,0.0].

dRadius​

A Double specifying the radius of the remesh sphere in millimeter.

The default value is 5.0.

dGradFactor​

A Double specifying the grading factor of the result mesh.

The default value is 1.0.

dStretchLimit​

A Double specifying the stretch limit of the elements in the result mesh.

The default value is 0.1.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

cube = Geometry.Part.Cube(iPartColor=12603072)
MeshEdit.MoveNode.CADFollows(crlNodes=[Node(453)], 
                             dMovedPosX=5.527019999999999, 
                             dMovedPosY=5.43058, 
                             dMovedPosZ=10.0)

Meshing.SolidMeshing(crlParts=[cube], 
                     bTet10=True, 
                     dGradingFactor=1.05, 
                     dStretchLimit=0.1, 
                     iSpeedVsQual=1, 
                     iRegion=1, 
                     bSafeMode=False, 
                     iParallel=4, 
                     bSurfaceNodes=False, 
                     bEdgeNodes=False, 
                     bPreservation=False, 
                     iPartColor=65280)

remesh_status = Meshing.LocalRemesh.Solid(crlParts=[cube], 
                                          dlCenter=[0.005555555555555556, 
                                                    0.005555555555555556, 
                                                    0.01], 
                                          dRadius=2.0)

JPT.Debugger(remesh_status)
