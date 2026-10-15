# ViewFindEntities()

ViewFindEntities()

Description​

Find for entity

Syntax​

ViewFindEntities(string strID/PartName/Coordinate, string strEntityType, bool bMatch)

Inputs​

1. String​

ID, Coordinate or Part Name

Entity ID of Part, Face, Edge, Vertex, 3D Element, 2D Element, 1D Element, Node, Group, Force, Pressure, Constraint, DoF Set, Centrifugal Force, Gravity, Connection, Contact or Coordinate

Coordinate: "Position of X coordinate, Position of Y coordinate, Position of Z coordinate"

Part Name: String of part name

2. String​

Target entity name (ID/Coordinate/Part Name)

Entity ID name: Part, Face, Edge, Vertex, 3D Element, 2D Element, 1D Element, Node, Group, Force, Pressure, Constraint, DoF Set, Centrifugal Force, Gravity, Connection, Contact or Coordinate

Coordinate: Part, Face, Edge, 3D Element, 2D Element, 1D Element, Node

Part Name: Part

3. Bool​

Match bool flag True = 1, False = 0

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

ViewFindEntities("Cube_1","Part",0) or ViewFindEntities("1","Part",0)

or

ViewFindEntities("0.00555,0.01,0.005555","Part",0)
