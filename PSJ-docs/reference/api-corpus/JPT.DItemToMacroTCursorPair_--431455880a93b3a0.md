# JPT.DItemToMacroTCursorPair()

JPT.DItemToMacroTCursorPair()

Description​

Convert pair of DItem objects to Cursor pair (Macro string type).

Syntax​

JPT.DItemToMacroTCursorPair(DItem1, DItem2)

Inputs​

DItem1​

The first DItem object to be converted.

This is a required input.

DItem2​

The second DItem object to be converted.

This is a required input.

Return Code​

A String containing all the converted items.

Sample Code​

# Prepare model
Geometry.Part.Cube()
Geometry.Part.Cube(strName="Cube_2")
Geometry.Part.Cube(strName="Cube_3")
JPT.ViewFitToModel()

# Get all the existing Nodes and convert a pair of them to cursor pair (Macro string type)
## Get all Nodes from model
listNodes = JPT.GetAllNodes() # List of DNode objects
## Get 2 Nodes and convert them to DItem object
dItemNode1 = JPT.CastToDItem(listNodes[0]) # The first DItem object
dItemNode2 = JPT.CastToDItem(listNodes[1]) # The second DItem object
## Return 2 DItems to a string object, for example, return value = 10:772-10:251
JPT.Debugger(JPT.DItemToMacroTCursorPair(dItemNode1, dItemNode2))
