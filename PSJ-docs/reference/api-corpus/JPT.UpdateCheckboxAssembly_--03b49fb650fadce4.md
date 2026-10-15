# JPT.UpdateCheckboxAssembly()

JPT.UpdateCheckboxAssembly()

説明​

アセンブリツリー内のアイテムのチェックボックスの状態を設定します。

構文​

JPT.UpdateCheckboxAssembly(DItemType, エンティティID, BoolType)

入力​

DItemType​

エンティティの DItemType を指定する Enum です。

これは必須の入力です。

エンティティID​

対象エンティティのIDを指定する Integer です。

これは必須の入力です。

BoolType​

チェックボックスの状態を説明する BoolType を指定する Enum です：

True: アセンブリツリー内のアイテムのチェックボックスをオンにします。

False: アセンブリツリー内のアイテムのチェックボックスをオフにします。

これは必須の入力です。

ヒント

JPT.BoolType.TRUE_VAL を入力する代わりに 1 を入力することもできますし、
JPT.BoolType.FALSE_VAL を入力する代わりに 0 を入力することもできます。

戻り値​

このユーティリティ関数には出力値はありません。

サンプルコード​

# モデルの準備…
JPT.Exec('CreateCube([0, 0, 0], [0.01, 0.01, 0.01], [10, 10, 10], "Cube_1", 7105764, 0:0)')
JPT.Exec('CreateCube([0.02, 0, 0], [0.01, 0.01, 0.01], [10, 10, 10], "Cube_2", 6409934, 0:0)')
JPT.Exec('CreateCube([0, 0.02, 0], [0.01, 0.01, 0.01], [10, 10, 10], "Cube_3", 13259210, 0:0)')

parts = JPT.GetAllParts()

# アセンブリツリーからチェックボックスを更新
for part in parts:
    JPT.UpdateCheckboxAssembly(JPT.DItemType.BODY, part.id, 1) # チェックをオンにする
    JPT.UpdateCheckboxAssembly(JPT.DItemType.BODY, part.id, 0) # チェックをオフにする
