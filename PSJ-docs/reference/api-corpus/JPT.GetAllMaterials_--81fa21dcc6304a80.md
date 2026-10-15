# JPT.GetAllMaterials()

JPT.GetAllMaterials()

説明​

既存のすべてのユーザー材料の情報を取得します。

構文​

JPT.GetAllMaterials()

入力​

このユーティリティ機能には入力値は必要ありません。

戻り値​

すべての既存のユーザー材料の情報を含む MaterialVector オブジェクトまたは リスト内の DMaterial オブジェクト。

サンプルコード​

# ポストモデルの準備
samplePath = JPT.GetProgramPath() + "SampleData\\Post\\Static_Renkon.op2"
Home.ImportResults.Nastran(strPath= samplePath, dFaceAngle=60.16, dEdgeAngle=60.16, bReadLoadAndConstraint=True, 
                            bReadConnection=True, bCreateResultsAtMidNode=True)
# Preに変換
data = Tools.ToPre(strName="Static_Renkon", ilOptions=[0, 1, 2, 3, 4])
JPT.SetActiveDocumentByName("Static_Renkon_Converted_Pre",1)
# すべてのユーザー材料を取得
userMat = JPT.GetAllMaterials()
JPT.Debugger(userMat)
JPT.Debugger(userMat[0])
