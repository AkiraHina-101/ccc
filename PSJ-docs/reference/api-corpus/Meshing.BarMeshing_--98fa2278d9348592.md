# Meshing.BarMeshing()

Meshing.BarMeshing()

Description​

Mesh 1D edge/bar part.

Syntax​

Meshing.BarMeshing(...)

Macro: BeamMeshing

Ribbon: Meshing » BarMeshing

Inputs​

crlCadEdge​

A List of Cursor specifying list of CAD edges.

This is a required input.

crlBarEdge​

A List of Cursor specifying list of bar edges.

This is a required input.

crlBarPart​

A List of Cursor specifying list of bar parts./

This is a required input.

dDocMeshSize​

A Double specifying desired mesh size.

The default value is 0.

iDocNumofElem​

An Integer specifying desired number of elements. If this parameter is bigger than 0 , dDocMeshSize is ignored.

The default value is 4.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

MeshEdit.CreateNode.Absolute(veclNodeCoord=[[0.0, 0.0, 0.0]], 
                             ilNewNodeID=[1])
MeshEdit.CreateNode.Absolute(veclNodeCoord=[[0.001, 0.0, 0.0]], 
                             ilNewNodeID=[2])
Geometry.Bar.TwoNodes(iMeshCount=1, 
                      crStartNode=Node(2), 
                      crEndNode=Node(1))

mesh_status = Meshing.BarMeshing(crlCadEdge=[], 
                                 crlBarEdge=[1], 
                                 crlBarPart=[], 
                                 iDocNumofElem=10)

JPT.Debugger(mesh_status)
