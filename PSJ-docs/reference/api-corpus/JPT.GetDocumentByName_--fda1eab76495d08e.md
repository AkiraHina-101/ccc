# JPT.GetDocumentByName()

JPT.GetDocumentByName()

説明​

指定した文書の情報を取得します。

構文​

JPT.GetDocumentByName(docName)

入力​

docName​

文書の名前を指定する String です。

これは必須の入力です。

戻り値​

文書の情報を指定する Document オブジェクト。

サンプルコード​

samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
Home.ImportResults.Nastran(strPath=samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)
docInfor = JPT.GetDocumentByName("101_solid")
JPT.Debugger(docInfor)
