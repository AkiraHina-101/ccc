# JPT.Exec()

JPT.Exec()

説明​

Jupiterマクロを実行します。

構文​

JPT.Exec(macroCommand)

入力​

macroCommand​

マクロコマンドを指定する String です。

これは必須の入力です。

戻り値​

入力されたマクロコマンドの出力に基づきます。

サンプルコード​

# 立方体を作成し、そのカーソルを保存します
createdCube = JPT.Exec('CreateCube([0, 0, 0], [0.01, 0.01, 0.01], \
                        [10, 10, 10], "Cube_1", 12999622, 0:0)')
JPT.Debugger(createdCube) # 値が3:1である文字列オブジェクトを返します。
