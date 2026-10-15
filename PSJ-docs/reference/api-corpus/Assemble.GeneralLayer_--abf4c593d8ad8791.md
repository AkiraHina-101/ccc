# Assemble.GeneralLayer()

Assemble.GeneralLayer()

説明​

元となるフェースをオフセットして、パート内に新しいフェースを作成します。

構文​

Assemble.GeneralLayer(...)

リボン: Assemble » General Layer

入力​

crlFaces​

レイヤーを作成するフェースのリストを指定する Cursor のリスト。

これは必須の入力です。

dWidth​

作成される表面のオフセット量を指定する Double 。

デフォルト値は1.0です。

iLayer​

作成されるレイヤーの数を指定する Integer 。

デフォルト値は1です。

bSeparatePart​

新しいレイヤーパートが別の パートに作成されるオプションを有効化/無効化する Boolean 型。 境界レイヤーパートと元のパートは共有の表面を持ちます。

デフォルト値は False です。

bForceStitchToSide​

モデルジオメトリの外側とオフセットに従うオプションを有効化/無効化する Boolean 型。

デフォルト値は False です。

bSmoothingEdge​

オフセットフェースのエッジを準備するオプションを有効化/無効化する Boolean 型。

デフォルト値は False です。

bNoImprint​

オフセットフェースの作成後、隣接する表面に適用するかどうかを指定する Boolean 型。

デフォルト値は False です。

bWidthOnSurface​

モデル平面の形状に沿ってオフセットの量として解釈するかどうかを指定する Boolean 型。

デフォルト値は False です。

bMakeHexa​

レイヤーフェースと境界フェースの間にヘキサ要素を作成するかどうかを指定する Boolean 型。

デフォルト値は False です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean 型:

True: プロセスは正常に実行されました。

False: 関数を実行できません。

サンプルコード​

Geometry.Part.Cube()

creating_status = Assemble.GeneralLayer(crlFaces=[Face(26)])

JPT.Debugger(creating_status)
