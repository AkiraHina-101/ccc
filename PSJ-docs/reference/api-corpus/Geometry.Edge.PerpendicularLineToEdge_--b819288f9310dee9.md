# Geometry.Edge.PerpendicularLineToEdge()

Geometry.Edge.PerpendicularLineToEdge()

説明​

選択したフェース上の指定された点を通過する、選択したエッジに垂直なエッジを作成します。作成されたエッジは指定された点から始めるか、最も近いエッジに伸ばすことができます。

構文​

Geometry.Edge.PerpendicularLineToEdge(...)

リボン: Geometry » Edge » Perpendicular Line To Edge

入力​

crNode​

新しいエッジの開始節点を指定する Cursor。bAuto またはスケールが指定されている場合、この引数は無視されます。

デフォルト値は None です。

crEdge​

新しいエッジを延長する必要があるエッジを指定する Cursor。bAuto またはスケールが指定されている場合、この引数は無視されます。

デフォルト値は None です。

crlFaces​

エッジが印刷される対象のフェースを指定する Cursor のリスト。

これは必須入力です。

bBreakFace​

可能な場合、与えられたフェースを分割するかどうかを指定する Boolean 値。

デフォルト値は True です。

bExtend​

新しいエッジを指定された節点を通過して最寄りのエッジオブジェクトまで延長するかどうかを指定する Boolean 値。

デフォルト値は True です。

bAuto​

エッジ間の角度が指定された角度 dLimitAngle 以上であるエッジのペアから節点とエッジを自動的に指定するかどうかを指定する Boolean 値。間の節点が自動的に選択され、その節点から指定されたフェースの反対のエッジまでの印刷ラインが作成されます。

デフォルト値は False です。

dLimitAngle​

エッジエンティティを考慮する角度を制限する度数を指定する Double 型の値。bAuto が True の場合に使用される引数です。

デフォルト値は 135.0 です。

戻り値​

新しく作成されたエッジを指定する Cursor のリスト。

サンプルコード​

Geometry.Part.Cylinder()

created_edges = Geometry.Edge.PerpendicularLineToEdge(crNode=Node(250), 
                                                      crEdge=Edge(1), 
                                                      crlFaces=[Face(5)])
JPT.Debugger(created_edges)
