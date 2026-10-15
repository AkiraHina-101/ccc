# ViewFindEntities()

ViewFindEntities()

説明​

エンティティを検索します

構文​

ViewFindEntities(string strID/PartName/Coordinate, string strEntityType, bool bMatch)

入力​

1. String​

ID、Coordinate、またはPart名

Part、Face、Edge、Vertex、3D要素、2D要素、1D要素、Node、Group、Force、Pressure、Constraint、DoF Set、Centrifugal Force、Gravity、Connection、Contact、またはCoordinateのエンティティID

Coordinate: "X座標の位置、Y座標の位置、Z座標の位置"

Part名: パート名の文字列

2. String​

ターゲットエンティティ名（ID/Coordinate/Part名）

エンティティID名: Part、Face、Edge、Vertex、3D要素、2D要素、1D要素、Node、Group、Force、Pressure、Constraint、DoF Set、Centrifugal Force、Gravity、Connection、Contact、またはCoordinate

Coordinate: Part、Face、Edge、3D要素、2D要素、1D要素、Node

Part名: Part

3. Bool​

一致するかどうかのフラグ True = 1、False = 0

戻り値​

"1": 関数は実行可能です

"0": 関数は実行できません

サンプルコード​

ViewFindEntities("Cube_1","Part",0) 或いは ViewFindEntities("1","Part",0)

または

ViewFindEntities("0.00555,0.01,0.005555","Part",0)
