# JPT.GetSelectedEdgesCr()

JPT.GetSelectedEdgesCr()

Description​

Get all information of the selected edges under List of Cursor format.

Syntax​

JPT.GetSelectedEdgesCr()

Inputs​

This utility function does not require any input value.

Return Code​

A String specifying a cursor list (Macro string type) containing typeID and ID of the selected edges.

Sample Code​

# Prepare model
Geometry.Part.Cube(iPartColor=7138156)
Geometry.Part.Cube(strName="Cube_2", iPartColor=5921475)
Geometry.Part.Cube(strName="Cube_3", iPartColor=6678117)
Geometry.Part.Cube(strName="Cube_4", iPartColor=11908427)
Geometry.Part.Cube(strName="Cube_5", iPartColor=15429611)
Geometry.Part.Cube(strName="Cube_6", iPartColor=7531634)
Geometry.Part.Cube(strName="Cube_7", iPartColor=12434775)
Home.Find(strSearch="87 90 91 94 95 96 97 98", strSelectedType="Edge")
JPT.ViewFitToModel()

# Get the information of all selected edges
listCursorSelEdges = JPT.GetSelectedEdgesCr()
JPT.Debugger(listCursorSelEdges)
