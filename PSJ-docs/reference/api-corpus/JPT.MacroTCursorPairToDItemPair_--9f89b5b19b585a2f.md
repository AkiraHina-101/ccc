# JPT.MacroTCursorPairToDItemPair()

JPT.MacroTCursorPairToDItemPair()

Description​

Convert cursor pair (Macro string type) to a pair of DItem object.

Syntax​

JPT.MacroTCursorPairToDItemPair(cursorPair)

Inputs​

cursorPair​

A String specifying the cursor pair (Macro string type).

This is a required input.

Return Code​

A DItemPair object.

Sample Code​

# Prepare model
Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], strName="Cube_2", iPartColor=7730934)
JPT.ViewFitToModel()

# Get all the information of the 2 created cubes
dItemPair = JPT.Debugger(JPT.MacroTCursorPairToDItemPair("3:1-3:2"))
JPT.Debugger(dItemPair.firstDItem)
JPT.Debugger(dItemPair.secondDItem)
