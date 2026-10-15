# JPT.GetDocumentByID()

JPT.GetDocumentByID()

説明​

指定されたドキュメントの情報を取得します。

構文​

JPT.GetDocumentByID(docID)

入力​

docID​

ドキュメントの情報を取得するためのIDを指定する Document 型の表示。

これは必須の入力です。

戻り値​

ドキュメントの情報を指定する Document オブジェクト。

サンプルコード​

doc = JPT.CreateNewDocument()
docInfor = JPT.GetDocumentByID(doc.docID)
JPT.Debugger(docInfor)
