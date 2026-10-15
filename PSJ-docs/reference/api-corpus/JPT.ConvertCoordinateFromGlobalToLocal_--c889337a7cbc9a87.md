# JPT.ConvertCoordinateFromGlobalToLocal()

JPT.ConvertCoordinateFromGlobalToLocal()

Description​

Convert global coordinate of selected DItem Type into specified local coordinate.

Syntax​

JPT.ConvertCoordinateFromGlobalToLocal(DItemType, itemID, DCoord)

Inputs​

DItemType​

An Enum specifying the DItemType of BODY, FACE, ELEMENT, EDGE, or NODE entity in Jupiter.

This is a required input.

itemID​

An Integer specifying the ID of the target entity.

This is a required input.

DCoord​

A DCoord object specifying Coordinate System which will be used to convert.

This is a required input.

Return Code​

A DItemPair object specifying the information of target entity according to the converted Coordinate System.

firstDItem is an integer specifying the Node IDs of target entity.

secondDItem is a TVector3d object specifying the coordinates of the corresponding node according to the converted Coordinate System.

Sample Code​

# Prepare model and local coordinate
Geometry.Part.Cube()
JPT.ViewFitToModel()
Tools.Coordinates.ThreeNode(crlNodes=[Node(488, 96, 88)])

# Get all local coordinates
# And convert global coordinate of specified DItemType.NODE into the selected local coordinate
listCoords = JPT.GetAllCoordinates()
convertCoord = JPT.ConvertCoordinateFromGlobalToLocal(JPT.DItemType.NODE, 8, listCoords[0])

# Get node ID and coordinates of DItem.NODE object according to the converted Coordinate System
JPT.Debugger(convertCoord[0].first)
JPT.Debugger(convertCoord[0].second)
