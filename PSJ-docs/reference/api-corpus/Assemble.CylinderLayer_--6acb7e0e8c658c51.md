# Assemble.CylinderLayer()

Assemble.CylinderLayer()

Description​

Create an inner cylindrical face based on specified top face/bottom face of the cylinder.

Syntax​

Assemble.CylinderLayer(...)

Macro: CylinderLayer

Ribbon: Assemble » Cylinder Layer

Inputs​

crFace​

A Cursor specifying the list of cylindrical face.

The default value is None.

crNode​

A Cursor specifying the node that determines the face and the length including the extension you want for the edge.

The default value is None.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

Geometry.Part.Cylinder(bHollow=True, 
                       dTopInnerRadius=0.007, 
                       dBottomInnerRadius=0.007)
Geometry.Edge.OffsetLine(crlFaces=[Face(5)], 
                         crlEdges=[Edge(2)], 
                         iOffsetMethod=1,
                         dlOffsetDistance=[0.0015], 
                         iImprintMethod=0)

creating_status = Assemble.CylinderLayer(crFace=Face(5), crNode=Node(41))

JPT.Debugger(creating_status)
