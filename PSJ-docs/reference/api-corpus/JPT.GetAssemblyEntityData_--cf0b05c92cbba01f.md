# JPT.GetAssemblyEntityData()

JPT.GetAssemblyEntityData()

Description​

Get all information of a specific item from Assembly Tree.

Syntax​

JPT.GetAssemblyEntityData(DItemType,itemID)

Inputs​

DItemType​

An Enum specifying DItemType of the target item.

This is a required input.

itemID​

An Integer specifying the ID of the item.

This is a required input.

Return Code​

A Dictionary specifying the data information of the inputted type.

Sample Code​

# Prepare model
JPT.Exec('CreateCube([0, 0, 0], [0.01, 0.01, 0.01], [10, 10, 10], "Cube_1", 7105764, 0:0)')
JPT.Exec('CreateCube([0.02, 0, 0], [0.01, 0.01, 0.01], [10, 10, 10], "Cube_2", 6409934, 0:0)')
JPT.Exec('CreateCube([0, 0.02, 0], [0.01, 0.01, 0.01], [10, 10, 10], "Cube_3", 13259210, 0:0)')
JPT.Exec('PressureGeneral("Pressure2", 1e+08, 0, 0:0, 0, 0, 0:0, "", 0:0, [1.7976931e+308, 1.7976931e+308, 1.7976931e+308], "", "", "", 1, [6:52], 0:0)')
JPT.Exec('ForceGeneral("Force2", [-100, 1.7976931e+308, 1.7976931e+308], [1.7976931e+308, 1.7976931e+308, 1.7976931e+308], 0, 0, 0:0, 0:0, 0:0, 0, 0, 0:0, "", "", "", "", "", "", [6:23], 0:0)')
JPT.Exec('FixedConstraint("Constraint1", 7, 0:0, 0, 0, 0:0, 0, [6:77], 0:0)')
JPT.Exec('BoundaryTemperature("BoundaryTemperature_1", 293.15, 0:0, [6:78], 0:0)')
JPT.ViewFitToModel()

# Get information of Cube_1 from assembly tree
PartDict = JPT.GetAssemblyEntityData(JPT.DItemType.BODY, 1)

# Dump out result
pprint(PartDict)

# Print out the color of Feature Edge and convert to RGB format
colorRGB = JPT.ConvertJPTColorToRGB(int(PartDict["Part"]["Surface"]["Colors"]["Feature Edge"]))
print("Feature Edge Color: " + colorRGB)

# Get information of Boundary Constraint from assembly tree
ConstraintDict = JPT.GetAssemblyEntityData(JPT.DItemType.LBC_CONSTRAINT, 1)
pprint(ConstraintDict)

# Get information of Force from assembly tree
ForceDict = JPT.GetAssemblyEntityData(JPT.DItemType.LBC_FORCE, 2)
pprint(ForceDict)

# Get information of Pressure from assembly tree
PressureDict = JPT.GetAssemblyEntityData(JPT.DItemType.LBC_G_PRESSURE, 1)
pprint(PressureDict)

# Get information of Pressure from assembly tree
TempDict = JPT.GetAssemblyEntityData(JPT.DItemType.LBC_TEMP_BOUNDARY, 1)
pprint(TempDict)
