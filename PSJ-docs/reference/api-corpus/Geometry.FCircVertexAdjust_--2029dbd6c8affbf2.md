# Geometry.FCircVertexAdjust()

Geometry.FCircVertexAdjust()

説明​

円周上の頂点の位置を整えます。円柱の面は90度ずつ分割することもでき、マップ済みメッシュを作成できます。

構文​

Geometry.FCircVertexAdjust(...)

リボン: Geometry » FCirc Vertex Adjust

入力​

crlParts​

頂点が調整されるパートを指定する Cursor リストです。

デフォルト値は [] です。

bFullCylinder​

全円柱の面を90度で分割するかどうかを指定する Boolean です。bFullCylinder=True の場合、選択したパートの円筒面とトーラス面が90度ごとに4か所に分割されます。この分割により、マップ済みメッシュの作成が容易になります。

デフォルト値は False です。

bCylinderMoreThan90​

円柱面を90度以上の内角で分割するかどうかを指定する Boolean です。bCylinderMoreThan90=True の場合、内角が90度以上の選択されたパートの円柱面は、90度位置で分割されます。

デフォルト値は False です。

dMinRadius​

分割される円柱面の最小半径を指定する Double です。入力値より半径が小さい面は保持されます。

デフォルト値は 0.0 です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean 型です：

True: プロセスは正常に実行されました。

False: 関数を実行できません。

サンプルコード​

# 2つの整列していない頂点を持つ円柱を作成します
Geometry.Part.Cylinder()
Geometry.BreakEntity.Edge(crlNodes=[Node(66)])
Geometry.BreakEntity.Edge(crlNodes=[Node(51)])

# 円柱の2つの円周上の頂点位置を整えます
adjust_status = Geometry.FCircVertexAdjust(crlParts=[Part(1)])

JPT.Debugger(adjust_status)
