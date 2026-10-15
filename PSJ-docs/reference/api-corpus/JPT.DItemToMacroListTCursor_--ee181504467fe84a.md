# JPT.DItemToMacroListTCursor()

JPT.DItemToMacroListTCursor()

Description​

Convert DItem object to List of Cursor (Macro string type).

Syntax​

JPT.DItemToMacroListTCursor(DItem)

Inputs​

DItem​

A DItem object to be converted.

This is a required input.

Return Code​

A String containing all the converted items.

Sample Code​

# Prepare model
Geometry.Part.Cube()
Geometry.Part.Cube(strName="Cube_2")
Geometry.Part.Cube(strName="Cube_3")
JPT.ViewFitToModel()

# Get all the existing Nodes and convert one of them to List of Cursor (Macro string type)
## Get all Nodes from model
listNodes = [JPT.CastToDItem(node) for node in JPT.GetAllNodes()] # List of DItem objects
## Get 1 Node from the created list
node = listNodes[0] # DItem object
## Return Node to a string object, for example, return value = [10:772]
JPT.Debugger(JPT.DItemToMacroListTCursor(node))
