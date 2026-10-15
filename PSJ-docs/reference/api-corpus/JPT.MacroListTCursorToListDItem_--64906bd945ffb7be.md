# JPT.MacroListTCursorToListDItem()

JPT.MacroListTCursorToListDItem()

Description​

Convert a cursor list (Macro string type) to a DItemVector.

Syntax​

JPT.MacroListTCursorToListDItem(cursorList)

Inputs​

cursorList​

A String specifying the cursor list (Macro string type).

This is a required input.

Return Code​

A DItemVector object or List of DItem objects specifying the converted items.

Sample Code​

# Prepare model
Geometry.Part.Cube()

# Convert a cursor list (Macro string type) to a DItemVector
## Create a list of Node cursor
strCursorNode1 = "10:467"
strCursorNode2 = "10:477"
strCursorNode3 = "10:483"
listCursorNode = f"[{strCursorNode1}, {strCursorNode2}, {strCursorNode3}]"
## Convert cursor list to list of DItem
JPT.Debugger(JPT.MacroListTCursorToListDItem(listCursorNode))
