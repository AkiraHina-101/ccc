# JPT.UpdateCheckboxWatchSelected()

JPT.UpdateCheckboxWatchSelected()

説明​

エンティティのIDとタイプを指定して、ウォッチ選択ウィンドウ内のチェックボックスの状態をONまたはOFFに変更します。

構文​

JPT.UpdateCheckboxWatchSelected(DItemType, listOfEntities, BoolType)

入力​

DItemType​

エンティティの DItemType を指定する Enum。

これは必須入力です。

listOfEntities​

選択または選択解除されるエンティティのIDを指定する Integer リスト。

これは必須入力です。

BoolType​

チェックボックスの状態を説明する BoolType を指定する Enum:

True: ウォッチ選択ウィンドウ内のアイテムのチェックボックスをオンにします。

False: ウォッチ選択ウィンドウ内のアイテムのチェックボックスをオフにします。

これは必須入力です。

ヒント

JPT.BoolType.TRUE_VAL を入力する代わりに 1 を入力することもできます。
JPT.BoolType.FALSE_VAL を入力する代わりに 0 を入力することもできます。

戻り値​

このユーティリティ関数には出力値がありません。

サンプルコード​

# モデルの準備
Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0],
                   strName="Cube_2",
                   iPartColor=6409934)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0],
                   strName="Cube_3",
                   iPartColor=13259210)
Geometry.Part.Cube(dlOrigin=[0.03, 0.0, 0.0],
                   strName="Cube_4",
                   iPartColor=7697908)
Geometry.Part.Cube(dlOrigin=[0.04, 0.0, 0.0],
                   strName="Cube_5",
                   iPartColor=7463537)
Geometry.Part.Cube(dlOrigin=[0.05, 0.0, 0.0],
                   strName="Cube_6",
                   iPartColor=7434735)
Geometry.Part.Cube(dlOrigin=[0.06, 0.0, 0.0],
                   strName="Cube_7",
                   iPartColor=14903267)
Geometry.Part.Cube(dlOrigin=[0.07, 0.0, 0.0],
                   strName="Cube_8",
                   iPartColor=15658599)
JPT.ViewFitToModel()

# 節点IDと要素IDの再番号付け
Tools.Renumber(listRenumberItem=[RENUMBER_ITEM(crTarget=Part(1),
                                               iBeginID=1,
                                               iCount=488,
                                               ilOffset=[10000, 100, 1],
                                               dlCoordTolerance=[0.1, 0.1, 0.1],
                                               bEnable=True),
                                 RENUMBER_ITEM(crTarget=Part(2),
                                               iBeginID=489,
                                               iCount=488,
                                               ilOffset=[10000, 100, 1],
                                               dlCoordTolerance=[0.1, 0.1, 0.1],
                                               bEnable=True),
                                ...

# エンティティの検索
Home.Find(strSearch="1 2 3 4 5",
          strSelectedType="Node")
Home.Find(strSearch="1 2 3 4 5",
          strSelectedType="2D Element")

# ウォッチ選択ウィンドウ内のチェックボックスの状態を変更
JPT.UpdateCheckboxWatchSelected(JPT.DItemType.NODE,
                                [1, 2, 3],
                                JPT.BoolType.FALSE_VAL)
JPT.UpdateCheckboxWatchSelected(JPT.DItemType.ELEM,
                                [1, 2, 3],
                                JPT.BoolType.FALSE_VAL)
