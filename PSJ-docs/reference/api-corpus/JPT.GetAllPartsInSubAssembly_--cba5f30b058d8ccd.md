# JPT.GetAllPartsInSubAssembly()

JPT.GetAllPartsInSubAssembly()

説明​

入力されたサブアセンブリ内のすべてのパートの情報を取得します。

構文​

JPT.GetAllPartsInSubAssembly(subAssem)

入力​

subAssem​

入力されたサブアセンブリを指定する DItem オブジェクトです。

これは必須の入力です。

戻り値​

入力されたサブアセンブリに属するパートを指定する DItemVector オブジェクトまたは List of DItem オブジェクトです。

サンプルコード​

# モデルの準備
Geometry.Part.Cube(iPartColor=15426917)
Geometry.Part.Cube(strName="Cube_2", iPartColor=13390932)
Geometry.Part.Cube(strName="Cube_3", iPartColor=16448103)
Geometry.Part.Cube(strName="Cube_4", iPartColor=13619046)
Geometry.Part.Cube(strName="Cube_5", iPartColor=7861111)
JPT.ViewFitToModel()
Assembly.RightClick.AddSubAssembly()

# すべてのパートを作成されたサブアセンブリにコピー
currentDoc = JPT.GetActiveDocument()
Assembly.RightClick.TransferDocumentData(strSourceDocTitle=currentDoc.docName, 
                                        strDestDocTitle=currentDoc.docName, 
                                        crlParts=[Part(part.id) for part in JPT.GetAllParts()], 
                                        strlNewPartName=[], 
                                        crDestAssemblyInstance=Inst(1))

# 入力されたサブアセンブリに属するすべてのパートの情報を取得
listPartsInSubAssembly = JPT.GetAllPartsInSubAssembly(JPT.FindSubAssemblyByID(1))
JPT.Debugger(listPartsInSubAssembly)
