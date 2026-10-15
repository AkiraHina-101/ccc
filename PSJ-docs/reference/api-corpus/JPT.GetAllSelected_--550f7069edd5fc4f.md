# JPT.GetAllSelected()

JPT.GetAllSelected()

説明​

選択されたエンティティ（接続、接触、パートなど）の情報をすべて取得します。

構文​

JPT.GetAllSelected()

入力​

このユーティリティ関数には入力値は必要ありません。

戻り値​

選択されたすべてのエンティティの情報を含む DItemVector オブジェクトまたは DItem オブジェクトのリスト。

サンプルコード​

# モデルの準備
Geometry.Part.Cube()
Geometry.Part.Cube(strName="Cube_2")
Geometry.Part.Cube(strName="Cube_3")
JPT.ViewFitToModel()

# パートを選択
listIDParts = [part.id for part in JPT.GetAllParts()]
strIDCursor = " ".join(str(cursor) for cursor in listIDParts)
Home.Find(strSearch=f"{strIDCursor}", strSelectedType="Part")

# 選択されたすべてのパートの情報を取得
listSelParts = JPT.GetAllSelected()
JPT.Debugger(listSelParts)
