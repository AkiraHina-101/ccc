# Assemble.FullLayer()

Assemble.FullLayer()

説明​

要素全体の表面メッシュから内側にオフセットしたレイヤー（PRISM6パート）を作成します。

構文​

Assemble.FullLayer(...)

リボン: Assemble » Full Layer

入力​

crPart​

新しいレイヤーを作成する対象パートを指定する Cursor です。

この入力は必須です。

dLayerWidth​

レイヤーの幅を指定する Double です。

デフォルト値は1.0です。

iLayer​

作成されるレイヤーの数を指定する Integer です。

デフォルト値は1です。

bUsePyramid​

レイヤーパートと内部パートを結ぶピラミッド要素を作成するオプションを有効化/無効化する Boolean です。

デフォルト値は False です。

戻り値​

関数の実行が正常に行われたかどうかを指定する Boolean です：

True: 問題なく実行された場合

False: 実行できなかった場合

サンプルコード​

cube = Geometry.Part.Cube()
flag = Assemble.FullLayer(crPart=cube)
JPT.Debugger(flag)
