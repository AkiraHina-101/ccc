# Geometry.MergeEntities.CBarParts()

Geometry.MergeEntities.CBarParts()

Description​

This method merges the adjacent bar parts into a single bar part.

Syntax​

Geometry.MergeEntities.CBarParts(crlCBarPart=[])

Ribbon: Geometry » Merge Entities » CBar Parts

Inputs​

crlCBarPart​

A List of Cursor specifying the bar parts to be merged.

The default value is [].

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

MeshEdit.CreateNode.Absolute(veclNodeCoord=[[0.0, 0.0, 0.0]], ilNewNodeID=[1])

MeshEdit.CreateNode.Absolute(veclNodeCoord=[[0.01, 0.0, 0.0]], ilNewNodeID=[2])

MeshEdit.CreateNode.Absolute(veclNodeCoord=[[0.01, 0.01, 0.0]], ilNewNodeID=[3])

MeshEdit.CreateNode.Absolute(veclNodeCoord=[[0.01, 0.01, 0.01]], ilNewNodeID=[4])

Geometry.Bar.TwoNodes(iMeshCount=4, crStartNode=Node(1), crEndNode=Node(2))

Geometry.Bar.TwoNodes(strName="Bar_2", iMeshCount=4, crStartNode=Node(2), crEndNode=Node(3))

Geometry.Bar.TwoNodes(strName="Bar_3", iMeshCount=4, crStartNode=Node(3), crEndNode=Node(4))

Geometry.MergeEntities.CBarParts(crlCBarPart=[Part(1, 2, 3)])
