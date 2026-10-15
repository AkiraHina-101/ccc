# Geometry.Edge.Spline()

Geometry.Edge.Spline()

説明​

フェース上にスプライン曲線状のエッジを作成します。指定されたフェース上に少なくとも3つの節点が指定されており、その節点を通過するスプラインを作成します。

構文​

Geometry.Edge.Spline(...)

マクロ: GeoImprintSplineS

リボン: Geometry » Edge » Spline

入力​

dllPoints​

スプラインを通過する必要がある指定したフェース上のポイントを指定する Position のリスト。

これは必須の入力です。

crlFaces​

スプラインエッジが印字されるターゲットフェースを指定する Cursor のリスト。

これは必須の入力です。

bBreakFace​

可能であれば指定されたフェースを分割するかどうかを指定する Boolean。

デフォルト値は True です。

戻り値​

新しく作成されたエッジを指定する Cursor のリスト。

サンプルコード​

Geometry.Part.Cube()

created_splines = Geometry.Edge.Spline(dllPoints=[[0.01, 0.003, 0.01],
                                                  [0.007, 0.003, 0.01],
                                                  [0.005, 0.004, 0.01], 
                                                  [0.004, 0.006, 0.01], 
                                                  [0.002, 0.007, 0.01], 
                                                  [0.0, 0.003, 0.01]],
                                       crlFaces=[Face(26)])
JPT.Debugger(created_splines)
