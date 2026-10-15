# JPT.CloseDocumentByID()

JPT.CloseDocumentByID()

説明​

ドキュメントのIDを指定してドキュメントを閉じます。

構文​

JPT.CloseDocumentByID(docID)

入力​

docID​

ドキュメントのIDを指定する String 。

これは必須の入力です。

戻り値​

このユーティリティ関数には出力値がありません。

サンプルコード​

samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
Home.ImportResults.Nastran(strPath=samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)
JPT.CreateNewDocument()
for doc in JPT.GetDocumentList():
    if doc.docName == "101_solid":
        JPT.CloseDocumentByID(doc.docID)
