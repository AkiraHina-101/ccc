# JPT.RemoveAllLoadsBCs()

JPT.RemoveAllLoadsBCs()

説明​

既存のすべての荷重と境界条件を削除します。

構文​

JPT.RemoveAllLoadsBCs()

入力​

このユーティリティ関数には、入力値は必要ありません。

戻り値​

このユーティリティ関数には出力値はありません。

サンプルコード​

# モデルの準備
Geometry.Part.Cube(iPartColor=13259210)
Geometry.Part.Cube(dlOrigin=[0.04, 0.0, 0.0], strName="Cube_2", iPartColor=7697908)
Geometry.Part.Cube(dlOrigin=[0.08, 0.0, 0.0], strName="Cube_3", iPartColor=7463537)
BoundaryConditions.FixedConstraint(crlTargets=[Face(78, 52)])
BoundaryConditions.FixedConstraint(strName="Constraint2", crlTargets=[Face(50)])
BoundaryConditions.FixedConstraint(strName="Constraint3", crlTargets=[Face(24)])
BoundaryConditions.FixedConstraint(strName="Constraint4", crlTargets=[Face(26)])
BoundaryConditions.Pressure.General(crlTargets=[Face(51)])
BoundaryConditions.Pressure.General(strName="Pressure2", crlTargets=[Face(77)])
BoundaryConditions.Pressure.General(strName="Pressure3", crlTargets=[Face(25)])
BoundaryConditions.Force.General("Force1",
                                 forceLBC=FORCE_LBC(vecForce=[1.0, DFLT_DBL, DFLT_DBL]),
                                 crlTargets=[Face(22)])
BoundaryConditions.Force.General("Force2",
                                 forceLBC=FORCE_LBC(vecForce=[1.0, DFLT_DBL, DFLT_DBL]),
                                 crlTargets=[Face(48)])
BoundaryConditions.Force.General("Force3",
                                 forceLBC=FORCE_LBC(vecForce=[1.0, DFLT_DBL, DFLT_DBL]),
                                 crlTargets=[Face(74)])

# 作成したすべての荷重と境界条件を削除します
JPT.RemoveAllLoadsBCs()
