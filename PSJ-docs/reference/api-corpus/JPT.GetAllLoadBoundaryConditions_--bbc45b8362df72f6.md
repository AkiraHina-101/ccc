# JPT.GetAllLoadBoundaryConditions()

JPT.GetAllLoadBoundaryConditions()

説明​

すべての既存の荷重および境界条件の情報を取得します。

構文​

JPT.GetAllLoadBoundaryConditions()

入力​

このユーティリティ関数には入力値が必要ありません。

戻り値​

すべての既存の荷重および境界条件の情報を含む LoadBCVector オブジェクトまたは List of DLoadBC オブジェクト。

サンプルコード​

# モデルの準備
Geometry.Part.Cube(iPartColor=6409934)
Geometry.Part.Cube(dlOrigin=[0.012, 0.0, 0.0], strName="Cube_2", iPartColor=13259210)
Geometry.Part.Cube(dlOrigin=[0.024, 0.0, 0.0], strName="Cube_3", iPartColor=7697908)
BoundaryConditions.FixedConstraint(crlTargets=[Face(76)])
BoundaryConditions.Pressure.General(crlTargets=[Face(52)])
JPT.ViewFitToModel()

# すべての既存の荷重および境界条件の情報を取得する
listDLoadBCs = JPT.GetAllLoadBoundaryConditions()
JPT.Debugger(listDLoadBCs)

# リスト内の各既存の荷重/境界条件の関連情報をすべて印刷する
for lbc in listDLoadBCs:
    JPT.Debugger(lbc)
