# JPT.GetSelectedElemsCr()

JPT.GetSelectedElemsCr()

Description​

Get all information of the selected elements under List of Cursor format.

Syntax​

JPT.GetSelectedElemsCr()

Inputs​

This utility function does not require any input value.

Return Code​

A String specifying a cursor list (Macro string type) containing typeID and ID of the selected elements.

Sample Code​

# Prepare model
Geometry.Part.Cube(iPartColor=7138156)
Geometry.Part.Cube(strName="Cube_2", iPartColor=5921475)
Geometry.Part.Cube(strName="Cube_3", iPartColor=6678117)
Geometry.Part.Cube(strName="Cube_4", iPartColor=11908427)
Geometry.Part.Cube(strName="Cube_5", iPartColor=15429611)
Geometry.Part.Cube(strName="Cube_6", iPartColor=7531634)
Geometry.Part.Cube(strName="Cube_7", iPartColor=12434775)
Home.Find(strSearch="3199 3204 3201 3202 3200 3203 3186 3185 3183 3184 3181",
          strSelectedType="2D Element")
JPT.ViewFitToModel()

# Get the information of all selected elements
listCursorSelElems = JPT.GetSelectedElemsCr()
JPT.Debugger(listCursorSelElems)
