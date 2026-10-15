# Geometry.Edge.Angle()

Geometry.Edge.Angle()

説明​

指定した要素エッジに指定された角度以下の角度で隣接する要素エッジを再帰的に探し、エッジを生成します。
自動選択の方向は、要素エッジを選択することで変更できます。

構文​

Geometry.Edge.Angle(...)

リボン: Geometry » Edge » Angle

入力​

crplElemEdges​

自動選択に使用される要素エッジを指定する Cursor ペアのリストです。

この入力は必須です。

dEdgeAngle​

角度を度で指定する Double です。

デフォルト値は 135.0 です。

bCurvature​

円を形成するために連鎖できる隣接要素エッジを見つけるかどうかを指定する Boolean です。

デフォルト値は False です。

bBreakFace​

指定された要素エッジが存在するフェースを切断するかどうかを指定する Boolean です。

デフォルト値は True です。

戻り値​

新しく作成されたエッジを指定する Cursor のリストです。

サンプルコード​

Geometry.Part.Cube()

created_edges = Geometry.Edge.Angle(crplElemEdges=[CursorPair(Node(461), Node(470)), 
                                        CursorPair(Node(445), Node(446))], 
                                    dEdgeAngle=135.0, 
                                    bCurvature=False, 
                                    bBreakFace=True)
JPT.Debugger(created_edges)
