# Meshing.GridMesh()

Meshing.GridMesh()

Description​

Create a mesh with grid pattern for the selected faces.

Syntax​

Meshing.GridMesh(...)

Ribbon: Meshing » GridMesh

Inputs​

listGridMesh​

A List specifying the parameters of Grid Mesh function (Refer to GRID_MESH). Each parameter specifying an option of Grid Mesh funciton.

This is a required input.

bProjectToCad​

A Boolean used to enable/disable CAD projection. If this is enabled (True), after meshing, the meshed nodes is projected back to CAD model.

The default value is False.

strGroupName​

A String specifying the name of a DGroup to contain the chosen target faces. If this parameter is left blank (""), no group will be created.

The default value is "".

bMakeNewGroup​

A Boolean specifying whether the function creates a new group or not:

True: Add all the meshed faces to a new group which will be created after executing the function.

False: Add all the meshed faces to the nearly created group after executing the function.

The default value is False.

Return Code​

A Boolean of True if success, or False if fail.

Sample Code​

Geometry.Part.Cube(strName="Cube_2", iPartColor=5820248)
Geometry.MakeFillet(crlEdges=[Edge(18, 19, 15)])

meshed_status = Meshing.GridMesh(listGridMesh=[GRID_MESH(crlFaces=[Face(29)],
                                                         crlCorner=[Node(1838,
                                                                         1837,
                                                                         1387,
                                                                         1397)],
                                                         ilMeshCount=[3, 3],
                                                         iShape=4),
                                               GRID_MESH(crlFaces=[Face(27)],
                                                         crlCorner=[Node(1837,
                                                                         1836,
                                                                         489,
                                                                         499)],
                                                         ilMeshCount=[3, 3],
                                                         iShape=4),
                                               GRID_MESH(crlFaces=[Face(28)],
                                                         crlCorner=[Node(1386,
                                                                         1376,
                                                                         1836,
                                                                         1838)],
                                                         ilMeshCount=[3, 3],
                                                         iShape=4),
                                               GRID_MESH(crlFaces=[Face(30)],
                                                         crlCorner=[Node(1837,
                                                                         1838,
                                                                         1836)],
                                                         ilMeshCount=[3],
                                                         iShape=3)],
                                 bProjectToCad=True,
                                 strGroupName="GridMeshFace")

JPT.Debugger(meshed_status)
