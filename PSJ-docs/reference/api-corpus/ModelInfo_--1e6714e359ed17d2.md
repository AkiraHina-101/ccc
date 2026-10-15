# ModelInfo()

ModelInfo()

説明​

ターゲット文字列からモデル情報を取得します。

構文​

ModelInfo(Target String)または ModelInfo(Target String, Name String)

入力​

1. String​

ターゲット文字列（bodyNum、faceNum、edgeNum、vertexNum、surfaceNodeNum、solidNodeNum、surfaceElemNum、solidElemNum、tri3ElemNum、tri6ElemNum、quad4ElemNum、quad8ElemNum、tet4ElemNum、tet10ElemNum、hex8ElemNum、hex20ElemNum、penta5ElemNum、penta6ElemNum、penta15ElemNum、pyramid13ElemNumまたはcoordinateByName、loadCaseByName、materialByName、bodyByName、LBCByName、AbaqusStepByName、PropertyByName、GroupByName）

2. String​

名前

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

ModelInfo("surfaceElemNum")

または

ModelInfo("coordinateByName", "aaaa")
