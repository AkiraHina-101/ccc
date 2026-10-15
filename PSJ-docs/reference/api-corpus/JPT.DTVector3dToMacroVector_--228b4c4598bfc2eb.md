# JPT.DTVector3dToMacroVector()

JPT.DTVector3dToMacroVector()

説明​

TVector3d オブジェクトを DTVector3d（マクロ文字列型）に変換します。

構文​

JPT.DTVector3dToMacroVector(DTVector3d)

入力​

DTVector3d​

変換する_TVector3d_ オブジェクト。

この入力は必須です。

戻り値​

変換されたアイテムをすべて含む String。

サンプルコード​

# モデルの準備
Geometry.Part.Cube()
Geometry.Part.Cube(strName="Cube_2")
Geometry.Part.Cube(strName="Cube_3")
JPT.ViewFitToModel()

# 既存のすべての節点を取得し、そのうちの1つを DTVector3D（マクロ文字列型）に変換します
## モデルからすべての節点を取得します
listNodes = JPT.GetAllNodes() # DNode オブジェクトのリスト
## リスト内の1つの節点の位置（DTVector3D）を取得します
posNode1 = listNodes[0].pos # DTVector3D オブジェクト
# DTVector3D オブジェクトを文字列オブジェクトに戻します。例：return value = [0,0.00777778,0.00444444]
JPT.Debugger(JPT.DTVector3dToMacroVector(posNode1))
