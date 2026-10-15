# Get info from Assembly Tree

Get info from Assembly Tree

🎯 Introduction​

In this tutorial, you'll learn how to get all information of a specific item from Assembly Tree:

Prepare models with LBCs.

Get and display all information of a Cube at Python API window.

Access the child property of Cube to get color of Feature Edge of the Surface of Cube.

Convert color value of Feature Edge to RGB (Red, Green, Blue) code.

Get and display all information of the Boundary Constraint at Python API window.

Get and display all information of the Force at Python API window.

Get and display all information of the Pressure at Python API window.

Get and display all information of the Boundary Temperature at Python API window.

Please note that displaying language will affect to the returned value of JPT.GetAssemblyEntityData().

The sample is using English language, for other languages, please pass the appropriate character string.

📖 Tutorial​

# Clear the log message in Python API window
JPT.ClearLog()

# Prepare model...
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
# Print out result
pprint(PartDict)

# Print out the color of Feature Edge and convert to RGB format
## For Japanese language:
## colorRGB = JPT.ConvertJPTColorToRGB(int(PartDict["パーツ"]["表面"]["色"]["エッジ"]))
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
