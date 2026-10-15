# JPT.GetRedoCount()

JPT.GetRedoCount()

Description​

Get the total number of Redo which is capable for executing.

Syntax​

JPT.GetRedoCount()

Inputs​

This utility function does not require any input value.

Return Code​

An Integer specifying the number of Redo operation.

Sample Code​

# Prepare model and redo steps
Geometry.Part.Cube(strName="Cube_11", iPartColor=11842649)
Geometry.Part.Cube(strName="Cube_12", iPartColor=14968422)
Geometry.Part.Cube(strName="Cube_13", iPartColor=6250447)
Geometry.Part.Cube(strName="Cube_14", iPartColor=12734402)
Geometry.Part.Cube(strName="Cube_15", iPartColor=16579696)
Geometry.Part.Cube(strName="Cube_16", iPartColor=7666683)
Geometry.Part.Cube(strName="Cube_17", iPartColor=12867524)
Toolbar.Undo(iCntUndo=3)

# Get the number of the available Redo
iRedoSteps = JPT.GetRedoCount()
JPT.Debugger(iRedoSteps) # Return an integer object with value = 3
