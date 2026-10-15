# Home.Find()

Home.Find()

説明​

Jupiter内のエンティティをIDまたは名前で検索します。

構文​

Home.Find(...)

リボン: Home » Find

入力​

strSearch​

検索する対象のIDまたは名前を指定する String です。

デフォルト値は "" です。

strSelectedType​

検索タイプを指定する String です。検索タイプは次のいずれかです。

"Part": パート検索。

"Face": フェース検索。

"Edge": エッジ検索。

"Vertex": 頂点検索。

"3D Element": 3D要素検索。

"2D Element": 2D要素検索。

"1D Element": 1D要素検索。

"Node": 節点検索。

"Group": グループ検索。

"Force": 力検索。

"Pressure": 圧力検索。

"Constraint": 制約検索。

"DoF Set": DoFセット検索。

"Centrifugal Force": 遠心力検索。

"Gravity": 重力検索。

"Weld": 溶接検索。

"Connection": 接続検索。

"Contact": 接触検索。

"Coordinate": 座標検索。

"Local Mesh Settings": ローカルメッシュ設定検索。

"Property": プロパティ検索。

デフォルト値は "Part" です。

bFindMatch​

Boolean 型で、検索一致オプションを有効/無効にします。このオプションがオンになっている場合、strSearch は完全に一致する必要があります。

デフォルト値は False です。

戻り値​

すべての検出されたエンティティを指定する Cursor のリスト。

サンプルコード​

Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.01,
                             0.0,
                             0.0],
                   strName="Cube_2",
                   iPartColor=6409934)

find_name = Home.Find(strSearch="cube")
find_name_match = Home.Find(strSearch="cube_2",
                            bFindMatch=True)
find_id = Home.Find(strSearch="1")

JPT.Debugger(find_name)

JPT.Debugger(find_name_match)

JPT.Debugger(find_id)
