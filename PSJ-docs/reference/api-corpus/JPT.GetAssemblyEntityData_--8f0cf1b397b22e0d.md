# JPT.GetAssemblyEntityData()

JPT.GetAssemblyEntityData()

説明​

アセンブリツリーから特定アイテムのすべての情報を取得します。

構文​

JPT.GetAssemblyEntityData(DItemType, アイテムID)

入力​

DItemType​

対象アイテムの DItemType を指定する Enum。

これは必須の入力です。

アイテムID​

アイテムのIDを指定する Integer。

これは必須の入力です。

戻り値​

入力タイプのデータ情報を指定する Dictionary。

サンプルコード​

# モデルの準備
JPT.Exec('CreateCube([0, 0, 0], [0.01, 0.01, 0.01], [10, 10, 10], "Cube_1", 7105764, 0:0)')
JPT.Exec('CreateCube([0.02, 0, 0], [0.01, 0.01, 0.01], [10, 10, 10], "Cube_2", 6409934, 0:0)')
JPT.Exec('CreateCube([0, 0.02, 0], [0.01, 0.01, 0.01], [10, 10, 10], "Cube_3", 13259210, 0:0)')
JPT.Exec('PressureGeneral("Pressure2", 1e+08, 0, 0:0, 0, 0, 0:0, "", 0:0, [1.7976931e+308, 1.7976931e+308, 1.7976931e+308], "", "", "", 1, [6:52], 0:0)')
JPT.Exec('ForceGeneral("Force2", [-100, 1.7976931e+308, 1.7976931e+308], [1.7976931e+308, 1.7976931e+308, 1.7976931e+308], 0, 0, 0:0, 0:0, 0:0, 0, 0, 0:0, "", "", "", "", "", "", [6:23], 0:0)')
JPT.Exec('FixedConstraint("Constraint1", 7, 0:0, 0, 0, 0:0, 0, [6:77], 0:0)')
JPT.Exec('BoundaryTemperature("BoundaryTemperature_1", 293.15, 0:0, [6:78], 0:0)')
JPT.ViewFitToModel()

# アセンブリツリーから Cube_1 の情報を取得
PartDict = JPT.GetAssemblyEntityData(JPT.DItemType.BODY, 1)

# 結果を出力
pprint(PartDict)

# フィーチャーエッジの色を取得してRGB形式に変換して表示
colorRGB = JPT.ConvertJPTColorToRGB(int(PartDict["Part"]["Surface"]["Colors"]["Feature Edge"]))
print("Feature Edge Color: " + colorRGB)

# アセンブリツリーから境界条件の情報を取得
ConstraintDict = JPT.GetAssemblyEntityData(JPT.DItemType.LBC_CONSTRAINT, 1)
pprint(ConstraintDict)

# アセンブリツリーからフォースの情報を取得
ForceDict = JPT.GetAssemblyEntityData(JPT.DItemType.LBC_FORCE, 2)
pprint(ForceDict)

# アセンブリツリーからプレッシャーの情報を取得
PressureDict = JPT.GetAssemblyEntityData(JPT.DItemType.LBC_G_PRESSURE, 1)
pprint(PressureDict)

# アセンブリツリーからプレッシャーの情報を取得
TempDict = JPT.GetAssemblyEntityData(JPT.DItemType.LBC_TEMP_BOUNDARY, 1)
pprint(TempDict)
