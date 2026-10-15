# JPT.SetActiveDocumentByName()

JPT.SetActiveDocumentByName()

説明​

指定されたドキュメントをその名前を使ってアクティブに設定します。

構文​

JPT.SetActiveDocumentByName(docName, BoolType)

入力​

docName​

アクティブにするドキュメントの名前を指定する String です。

この入力は必須です。

BoolType​

選択モードを説明する BoolType を指定する Enum 型です：

True: 指定されたドキュメントをアクティブにします。

False: 指定されたドキュメントをアクティブにしません。

この入力は必須です。

戻り値​

このユーティリティ関数には出力値がありません。

サンプルコード​

doc1 = JPT.CreateNewDocument()
doc2 = JPT.CreateNewDocument()
doc3 = JPT.CreateNewDocument()
JPT.SetActiveDocumentByName(doc2.docName,1)
Geometry.Part.Cube()
JPT.ViewFitToModel()
print("Created a Cube in " + str(doc2.docName) + " document")
