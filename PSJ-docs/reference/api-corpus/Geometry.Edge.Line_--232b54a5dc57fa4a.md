# Geometry.Edge.Line()

Geometry.Edge.Line()

説明​

選択した節点に基づいてエッジを作成します。

構文​

Geometry.Edge.Line(...)

マクロ: ImprintLineS

リボン: Geometry » Edge » Line

入力​

dllPoints​

位置 のリストを指定して、対象のフェース上の点を指定します。

これは必須の入力です。

crlFaces​

エッジを印刷する対象のフェースを指定する Cursor のリストを指定します。

これは必須の入力です。

bBreakFace​

指定されたフェースを可能な限り分割するかどうかを指定する Boolean です。

デフォルト値は True です。

戻り値​

新しく作成されたエッジを指定する Cursor のリストです。

サンプルコード​

Geometry.Part.Cube(iPartColor=6215639)

lines = Geometry.Edge.Line(dllPoints=[[0.01, 0, 0.01], [0, 0.01, 0.01]], 
                            crlFaces=[Face(26)])

JPT.Debugger(lines)
