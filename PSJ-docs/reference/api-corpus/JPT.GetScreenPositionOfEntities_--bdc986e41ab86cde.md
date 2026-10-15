# JPT.GetScreenPositionOfEntities()

JPT.GetScreenPositionOfEntities()

Description​

Obtains the position of the specified item in the Main Window in screen coordinate system [min_x,min_y,max_x,max_y].

Syntax​

JPT.GetScreenPositionOfEntities(...)

Inputs​

DItemVector​

A DItemVector object representing the item whose position on the Main Window is to be retrieved.

This is a required input.

Return Code​

A list of[int] representing the upper left and lower right coordinates of the area. If no item found on the Main Window, it returns a blank list.

Sample Code​

# Prepare model
Geometry.Part.Cube(iPartColor=13290083)
Geometry.Part.Cube(dlOrigin=[0.012, 0.0, 0.0], strName="Cube_2", iPartColor=6149981)
JPT.ViewFitToModel()

# Check screen position of parts in Main Window.
ditem_list=JPT.GetAllByTypeID(JPT.DItemType.BODY)
pos=JPT.GetScreenPositionOfEntities(ditem_list)
JPT.Debugger(pos)
