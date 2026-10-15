# LBCの表示/非表示

LBCの表示/非表示

🎯 はじめに​

このチュートリアルでは、LBC（境界条件）の表示を変更する方法を学びます：

LBCを持つモデルを準備します。

メインウィンドウで表示されているすべてのLBCを非表示にします。

メインウィンドウで「力」だけを表示します。

📖 チュートリアル​

# Python APIウィンドウのログメッセージをクリア
JPT.ClearLog()

# モデルの準備...
JPT.Exec('CreateCube([0, 0, 0], [0.01, 0.01, 0.01], [10, 10, 10], "Cube_1", 7105764, 0:0)')
JPT.Exec('CreateCube([0.02, 0, 0], [0.01, 0.01, 0.01], [10, 10, 10], "Cube_2", 6409934, 0:0)')
JPT.Exec('CreateCube([0, 0.02, 0], [0.01, 0.01, 0.01], [10, 10, 10], "Cube_3", 13259210, 0:0)')
JPT.Exec('PressureGeneral("Pressure2", 1e+08, 0, 0:0, 0, 0, 0:0, "", 0:0, [1.7976931e+308, 1.7976931e+308, 1.7976931e+308], "", "", "", 1, [6:52], 0:0)')
JPT.Exec('ForceGeneral("Force2", [-100, 1.7976931e+308, 1.7976931e+308], [1.7976931e+308, 1.7976931e+308, 1.7976931e+308], 0, 0, 0:0, 0:0, 0:0, 0, 0, 0:0, "", "", "", "", "", "", [6:23], 0:0)')
JPT.Exec('FixedConstraint("Constraint1", 7, 0:0, 0, 0, 0:0, 0, [6:77], 0:0)')
JPT.Exec('BoundaryTemperature("BoundaryTemperature_1", 293.15, 0:0, [6:78], 0:0)')
JPT.ViewFitToModel()

# すべてのLBCを非表示にする
for lbc in JPT.GetAllLoadBoundaryConditions():
    JPT.ShowHideEntitiesByID(lbc.tableID, lbc.id, JPT.BoolType.FALSE_VAL)

# 「力」だけを表示する
for lbc in JPT.GetAllLoadBoundaryConditions():
    if lbc.tableID==21: # LBC 力の tableID = 21
        JPT.ShowHideEntitiesByID(lbc.tableID, lbc.id, JPT.BoolType.TRUE_VAL)
