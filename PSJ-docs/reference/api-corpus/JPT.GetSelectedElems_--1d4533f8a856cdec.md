# JPT.GetSelectedElems()

JPT.GetSelectedElems()

Description​

Get all information of the selected elements.

Syntax​

JPT.GetSelectedElems()

Inputs​

This utility function does not require any input value.

Return Code​

An ElemVector object or List of DElem objects containing all the information of the selected elements.

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
listSelElems = JPT.GetSelectedElems()
JPT.Debugger(listSelElems)
JPT.Debugger(listSelElems[2])
