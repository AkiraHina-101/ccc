# Geometry.Edge.ProjectLine()

Geometry.Edge.ProjectLine()

説明​

選択したエッジを選択したフェースに投影して新しいエッジを作成します。

構文​

Geometry.Edge.ProjectLine(...)

リボン: Geometry » Edge » Project Line

入力​

crlEdges​

投影するエッジを指定する Cursor リストです。

これは必須入力です。

crlFaces​

エッジが印刷される対象のフェースを指定する Cursor リストです。

これは必須入力です。

crlNodes​

投影方向を定義する2つの節点を指定する Cursor リストです。 iType=1 の場合はこの引数を指定する必要があります。

デフォルト値は [] です。

bBreakFace​

面をできる限り破壊するかどうかを指定する Boolean です。

デフォルト値は True です。

iType​

対象フェースに投影する方法を指定する Integer です。

iType=0 の場合、対象フェースの法線方向に投影します。

iType=1 の場合、crlNodes で指定された2つの節点が定義する方向に投影します。

iType=2 の場合、選択したエッジに最も近いフェースに投影します。

デフォルト値は 0 です。

bCheckGap​

プロジェクション距離を入力値に制限するかどうかを指定する Boolean です。

デフォルト値は False です。

dGap​

ギャップ値を指定する Double です。bCheckGap=True の場合に使用される引数です。

デフォルト値は 0.0 です。

戻り値​

新しく作成されたエッジを指定する Cursor リストです。

サンプルコード​

Geometry.Part.Cube(iPartColor=13064794)
line = Geometry.Edge.Line(dllPoints=[[0.004444444444444444, 0.01, 0.01], [0.007777777777777778, 0, 0.01]], 
                          crlFaces=[Face(26)])

project_lines = Geometry.Edge.ProjectLine(crlEdges=line, crlFaces=[Face(25)])
JPT.Debugger(project_lines)
