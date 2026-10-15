# JPT.GetDocumentList()

JPT.GetDocumentList()

説明​

表示されているすべてのドキュメントの情報を取得します。

構文​

JPT.GetDocumentList()

入力​

このユーティリティ関数には入力値は必要ありません。

戻り値​

すべての表示されているドキュメントの情報を指定する Document オブジェクトのリストです。

サンプルコード​

# モデルを準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
Home.ImportResults.Nastran(strPath=samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)
JPT.CreateNewDocument()
# すべての表示されているドキュメントの情報を取得
docList = JPT.GetDocumentList()
for doc in docList:
    JPT.Debugger(doc)
