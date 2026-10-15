# JPT.HighlightByID()

JPT.HighlightByID()

説明​

アセンブリツリー内のアイテムを、その DItemType とそのIDを使用してハイライト表示します。

構文​

JPT.HighlightByID(DItemType, entityID, BoolType)

入力​

DItemType​

対象エンティティの DItemType を指定する Enum です。

この入力は必須です。

entityID​

選択したエンティティのIDを指定する Integer です。

この入力は必須です。

BoolType​

選択モードを示す BoolType を指定する Enum です：

True: 入力されたIDのエンティティを選択します。

False: 入力されたIDのエンティティの選択を解除します。

この入力は必須です。

戻り値​

このユーティリティ関数には出力値がありません。

サンプルコード​

# モデルの準備
Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], strName="Cube_2", iPartColor=6409934)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], strName="Cube_3", iPartColor=13259210)
JPT.ViewFitToModel()

# 荷重境界条件の作成
BoundaryConditions.Pressure.General(dPressure=100000000.0, crlTargets=[Face(26)])
BoundaryConditions.Force.General(forceLBC=FORCE_LBC(vecForce=[DFLT_DBL, DFLT_DBL, -10.0]), 
    crlTargets=[Face(52)])
BoundaryConditions.FixedConstraint(crlTargets=[Face(77, 51, 25)])

# アセンブリツリー内の圧力アイテムをハイライト表示
listDItemLoadBCs = JPT.GetAllLoadsBCs()
for lbc in listDItemLoadBCs:
    if lbc.type == JPT.DItemType.LBC_G_PRESSURE:
        iID = lbc.id
JPT.HighlightByID(JPT.DItemType.LBC_G_PRESSURE, iID, JPT.BoolType.TRUE_VAL)
