# Update window checkbox

Update window checkbox

🎯 Introduction​

In this tutorial, you'll learn how to control checkboxes of Assembly Tree and Watch Selected Window:

Prepare models.

Select entities and check on/off item in Watch Selected Window.

Show/hide entities by checking on/off item in Assembly Tree.

📖 Tutorial​

# Clear the log message in Python API window
JPT.ClearLog()

# prepare model...
JPT.Exec('CreateCube([0, 0, 0], [0.01, 0.01, 0.01], [10, 10, 10], "Cube_1", 7105764, 0:0)')
JPT.Exec('CreateCube([0.02, 0, 0], [0.01, 0.01, 0.01], [10, 10, 10], "Cube_2", 6409934, 0:0)')
JPT.Exec('CreateCube([0, 0.02, 0], [0.01, 0.01, 0.01], [10, 10, 10], "Cube_3", 13259210, 0:0)')
JPT.ViewFitToModel()

# Select and update checkboxes in Watch Selected Window
Home.Find(strSearch="1 2 3")
listParts = JPT.GetSelectedParts()
listIDParts = [part.id for part in listParts]
JPT.Debugger(listIDParts)
JPT.UpdateCheckboxWatchSelected(JPT.EntityType.BODY, listIDParts, JPT.BoolType.FALSE_VAL) # JPT.BoolType.TRUE_VAL means turn on

# Show/hide entities by checking on/off item in Assembly Tree
JPT.UpdateCheckboxAssembly(JPT.EntityType.BODY, 1, 0) # turn off checkbox
JPT.UpdateCheckboxAssembly(JPT.EntityType.BODY, 1, 1) # turn on checkbox
JPT.UpdateCheckboxAssembly(JPT.EntityType.BODY, 2, 0) # turn off checkbox
