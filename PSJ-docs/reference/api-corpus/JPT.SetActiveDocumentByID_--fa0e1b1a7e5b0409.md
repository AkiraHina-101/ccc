# JPT.SetActiveDocumentByID()

JPT.SetActiveDocumentByID()

説明​

指定された文書をそのIDを使用してアクティブにします。

構文​

JPT.SetActiveDocumentByID(docID, BoolType)

入力​

docID​

アクティブにする文書のIDを指定する String です。

これは必須の入力です。

BoolType​

選択モードを説明する BoolType を指定する Enum 型です：

True: 指定された文書をアクティブにします。

False: 指定された文書をアクティブにしません。

これは必須の入力です。

戻り値コード​

このユーティリティ関数には出力値はありません。

サンプルコード​

doc1 = JPT.CreateNewDocument()
doc2 = JPT.CreateNewDocument()
JPT.SetActiveDocumentByID(doc1.docID, 1)
Geometry.Part.Cube()
JPT.ViewFitToModel()
