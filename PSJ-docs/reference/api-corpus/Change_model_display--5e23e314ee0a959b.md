# Change model display

Change model display

🎯 Introduction​

In this tutorial, you'll learn how to change display of current model:

Fit view to model (equivalent to press shortcut F on keyboard).

Hide/Show all parts on display view.

Hide entity (face, element) by ID.

Show only one part by ID.

📖 Tutorial​

# Clear the log message in Python API window
JPT.ClearLog()

# Create 3 cubes
Geometry.Part.Cube(dlOrigin=[0.0, 0.0, 0.0], dlLength=[0.01, 0.01, 0.01], ilAxialNodes=[10, 10, 10],
    strName="Cube_1", iPartColor=12999622,  crLocalCoordinate=None)
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], dlLength=[0.01, 0.01, 0.01], ilAxialNodes=[10, 10, 10],
    strName="Cube_2", iPartColor=5093709,  crLocalCoordinate=None)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], dlLength=[0.01, 0.01, 0.01], ilAxialNodes=[10, 10, 10],
    strName="Cube_3", iPartColor=6118877,  crLocalCoordinate=None)

# Fit view of model on display view
JPT.ViewFitToModel()

# Hide all parts on display view
JPT.ShowHideAllParts(JPT.BoolType.FALSE_VAL)

# Show all parts on display view
JPT.ShowHideAllParts(JPT.BoolType.TRUE_VAL)

# Hide a face with id 26, refer method DTABLE_SHAPE (vertex, edge, face, solid) for usage
JPT.ShowHideEntitiesByID(JPT.DTableType.DTABLE_SHAPE, 26, JPT.BoolType.FALSE_VAL)

# Hide a element with id 322, refer method DTABLE_ELEM for usage
JPT.ShowHideEntitiesByID(JPT.DTableType.DTABLE_ELEM, 322, JPT.BoolType.FALSE_VAL)

# Show only part with id 1
JPT.InverseHideBodies(1)
