# Show/Hide LBCs

Show/Hide LBCs

🎯 Introduction​

In this tutorial, you'll learn how to change display of of LBCs:

Prepare models with LBCs.

Hide all LBCs displaying on Main Window.

Show only Force on Main Window.

📖 Tutorial​

# Clear the log message in Python API window
JPT.ClearLog()

# prepare model...
JPT.Exec('CreateCube([0, 0, 0], [0.01, 0.01, 0.01], [10, 10, 10], "Cube_1", 7105764, 0:0)')
JPT.Exec('CreateCube([0.02, 0, 0], [0.01, 0.01, 0.01], [10, 10, 10], "Cube_2", 6409934, 0:0)')
JPT.Exec('CreateCube([0, 0.02, 0], [0.01, 0.01, 0.01], [10, 10, 10], "Cube_3", 13259210, 0:0)')
JPT.Exec('PressureGeneral("Pressure2", 1e+08, 0, 0:0, 0, 0, 0:0, "", 0:0, [1.7976931e+308, 1.7976931e+308, 1.7976931e+308], "", "", "", 1, [6:52], 0:0)')
JPT.Exec('ForceGeneral("Force2", [-100, 1.7976931e+308, 1.7976931e+308], [1.7976931e+308, 1.7976931e+308, 1.7976931e+308], 0, 0, 0:0, 0:0, 0:0, 0, 0, 0:0, "", "", "", "", "", "", [6:23], 0:0)')
JPT.Exec('FixedConstraint("Constraint1", 7, 0:0, 0, 0, 0:0, 0, [6:77], 0:0)')
JPT.Exec('BoundaryTemperature("BoundaryTemperature_1", 293.15, 0:0, [6:78], 0:0)')
JPT.ViewFitToModel()

# Hide all LBCs
for lbc in JPT.GetAllLoadBoundaryConditions():
    JPT.ShowHideEntitiesByID(lbc.tableID, lbc.id, JPT.BoolType.FALSE_VAL)

# Show only Force
for lbc in JPT.GetAllLoadBoundaryConditions():
    if lbc.tableID==21: #LBC Force tableID = 21
        JPT.ShowHideEntitiesByID(lbc.tableID, lbc.id, JPT.BoolType.TRUE_VAL)
