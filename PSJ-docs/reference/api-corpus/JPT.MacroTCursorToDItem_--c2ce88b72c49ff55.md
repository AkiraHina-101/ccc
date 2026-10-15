# JPT.MacroTCursorToDItem()

JPT.MacroTCursorToDItem()

Description​

Convert cursor (Macro string type) to a DItem object.

Syntax​

JPT.MacroTCursorToDItem(cursor)

Inputs​

cursor​

A String specifying the cursor (Macro string type).

This is a required input.

Return Code​

A DItem object.

Sample Code​

# Prepare model
Geometry.Part.Cube()
JPT.ViewFitToModel()

# Convert to DItem and get all the information of the created Cube_1
dItem = JPT.Debugger(JPT.MacroTCursorToDItem("3:1"))
JPT.Debugger(dItem)
