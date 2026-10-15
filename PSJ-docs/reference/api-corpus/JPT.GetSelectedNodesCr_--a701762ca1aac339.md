# JPT.GetSelectedNodesCr()

JPT.GetSelectedNodesCr()

Description​

Get all information of the selected nodes under List of Cursor format.

Syntax​

JPT.GetSelectedNodesCr()

Inputs​

This utility function does not require any input value.

Return Code​

A String specifying a cursor list (Macro string type) containing typeID and ID of the selected nodes.

Sample Code​

# Prepare model
Geometry.Part.Cube(iPartColor=7138156)
Geometry.Part.Cube(strName="Cube_2", iPartColor=5921475)
Geometry.Part.Cube(strName="Cube_3", iPartColor=6678117)
Geometry.Part.Cube(strName="Cube_4", iPartColor=11908427)
Geometry.Part.Cube(strName="Cube_5", iPartColor=15429611)
Geometry.Part.Cube(strName="Cube_6", iPartColor=7531634)
Geometry.Part.Cube(strName="Cube_7", iPartColor=12434775)
Home.Find(strSearch="20 21 22 23 24", strSelectedType="Node")
JPT.ViewFitToModel()

# Get the information of all selected nodes
listCursorSelNodes = JPT.GetSelectedNodesCr()
JPT.Debugger(listCursorSelNodes)
