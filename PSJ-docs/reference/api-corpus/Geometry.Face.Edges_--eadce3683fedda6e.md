# Geometry.Face.Edges()

Geometry.Face.Edges()

説明​

与えられたエッジを面の境界として使用して、フェースを作成します。基礎となる表面、関連するエッジ、および頂点で構成されるジオメトリを作成することにより、フェースを作成します。平面サーフェスとスムーズサーフェスは、関連する引数を変更することで切り替えることができます。

構文​

Geometry.Face.Edges(...)

マクロ: CreateFaceFromEdges

リボン: Geometry » Face » Edges

入力​

crlEdges​

新しいフェースの境界となるエッジを指定する Cursor のリスト。crlEdges または crlNodes のどちらか一方を指定する必要があります。

crlParts​

新しいフェースが所属する特定のパートを指定する Cursor のリスト。

デフォルト値は [] です。

crlNodes​

曲面がスムーズに作成される方向を定義するために使用される2つの節点を指定する Cursor のリスト。crlNodes が指定されている場合、曲面は境界エッジのみで作成されるフェースよりもスムーズになります。

デフォルト値は [] です。

bSharedFace​

指定されたエッジが共有エッジの場合に共有面を作成するかどうかを指定する Boolean 型の値です。

デフォルト値は False です。

bSmoothFace​

プレインなフェースの代わりにスムーズなフェースを作成するかどうかを指定する Boolean 型の値です。

デフォルト値は False です。

bCreatePart​

新たに作成されたフェースを新しいパートに縫い付けるかどうかを指定する Boolean 型の値です。bSharedFace=True の場合、この引数は無視されます。

デフォルト値は False です。

bImproved​

新たに作成されたフェースがスムーズな方向で作成されるかどうかを指定する Boolean 型の値です。crlNodes が指定されていない場合、この引数は操作に影響しません。

デフォルト値は False です。

bBarsOnly​

選択したすべてのエッジがバーパートだけであるかどうかを示す Boolean 型の値です。

デフォルト値は False です。

bOnlyOnePart​

新たに作成されたフェースが同じ新しいパートにあるかどうかを示す Boolean 型の値です。bCreatePart=False の場合、この引数は無視されます。

デフォルト値は True です。

bIncludeMidNodes​

フェースを作成する際に中間節点を含めるかどうかを指定する Boolean 型の値です。

デフォルト値は False です。

戻り値​

新たに作成されたフェースを指定する Cursor です。

サンプルコード​

Geometry.Part.Cube()

created_face = Geometry.Face.Edges(crlEdges=[Edge(9, 19)])

JPT.Debugger(created_face)
