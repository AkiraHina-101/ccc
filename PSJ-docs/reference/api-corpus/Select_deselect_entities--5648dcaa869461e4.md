# Select/deselect entities

Select/deselect entities

🎯 Introduction​

In this tutorial, you'll learn how to select or deselect entities on display view:

Change selector entity to Part.

Select/Deselect entity by Part entity type and ID.

Select/Deselect all entities has Part entity type.

Change selector entity to Face, select all entities has Face entity type.

Deselect all current selected entities.

Example of entity types for select method:

Part: JPT.SelectMethodType.SELMTD_BODY

Face: JPT.SelectMethodType.SELMTD_FACE

Edge: JPT.SelectMethodType.SELMTD_EDGE

Node: JPT.SelectMethodType.SELMTD_NODE

2D Element: JPT.SelectMethodType.SELMTD_ELEM

In this tutorial, Part (Body) and Face entities are used. Other entities can be used as same way.

📖 Tutorial​

# Encoding for Japanese
# coding: cp932

# Clear the log message in Python API window
JPT.ClearLog()

# Create sample model
Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], strName="Cube_2", iPartColor=6409934)

# Fit view of model on display view
JPT.ViewFitToModel()

# Change selector entity to 'Part'
JPT.SetSelectMethod(JPT.SelectMethodType.SELMTD_BODY)

########## Select/Deselect entity by entity's type and ID ##########

# Select/Deselect 'Part' entity has ID 1
# Select mode: True, Deselect mode: False
JPT.SelectionByID(JPT.DItemType.BODY, 1, True)
JPT.SelectionByID(JPT.DItemType.BODY, 1, False)

########## Select/Deselect entities by entity's type ##########

# Select/Deselect all entities has type: 'Part'
# Select mode: True, Deselect mode: False
JPT.SelectionByType(JPT.DItemType.BODY, True)
JPT.SelectionByType(JPT.DItemType.BODY, False)

# Change selector entity to 'Face'
# Select all entities has type: 'Face'
JPT.SetSelectMethod(JPT.SelectMethodType.SELMTD_FACE)
JPT.SelectionByType(JPT.DItemType.FACE, True)

# Deselect all current selected entities
JPT.ClearAllSelection()
