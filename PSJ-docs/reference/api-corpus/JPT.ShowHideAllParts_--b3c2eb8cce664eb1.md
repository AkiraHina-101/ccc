# JPT.ShowHideAllParts()

JPT.ShowHideAllParts()

説明​

画面に存在するすべてのパートを表示または非表示にします。

構文​

JPT.ShowHideAllParts(BoolType)

入力​

BoolType​

画面表示モードを示す BoolType を指定する Enum：

False: すべてのパートを非表示にします。

True: すべてのパートを表示します。

これは必須入力です。

戻り値​

このユーティリティ関数には出力値がありません。

サンプルコード​

# モデルの準備
Geometry.Part.Cube()
Geometry.Part.Cube(strName="Cube_2")
Geometry.Part.Cube(strName="Cube_3")
JPT.ViewFitToModel()

# すべてのパートを表示
JPT.ShowHideAllParts(JPT.BoolType.TRUE_VAL)
