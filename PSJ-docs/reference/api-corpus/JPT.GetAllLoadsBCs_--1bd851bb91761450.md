# JPT.GetAllLoadsBCs()

JPT.GetAllLoadsBCs()

説明​

既存のすべての荷重と境界条件の情報を DItemVector 形式で取得します。

構文​

JPT.GetAllLoadsBCs()

入力​

このユーティリティ機能には入力値は不要です。

戻り値​

すべての既存の荷重と境界条件の情報を含む DItemVector オブジェクトまたは DItem オブジェクトのリスト。

サンプルコード​

# モデルの準備
Geometry.Part.Cube(iPartColor=6409934)
Geometry.Part.Cube(dlOrigin=[0.012, 0.0, 0.0], strName="Cube_2", iPartColor=13259210)
Geometry.Part.Cube(dlOrigin=[0.024, 0.0, 0.0], strName="Cube_3", iPartColor=7697908)
BoundaryConditions.FixedConstraint(crlTargets=[Face(76)])
BoundaryConditions.Pressure.General(crlTargets=[Face(52)])
JPT.ViewFitToModel()

# すべての既存の荷重および境界条件の情報を取得
listDItemLoadBCs = JPT.GetAllLoadsBCs()
JPT.Debugger(listDItemLoadBCs)

# リスト内の各既存の荷重/境界条件の関連情報をすべて出力
for lbc in listDItemLoadBCs:
    JPT.Debugger(lbc)
