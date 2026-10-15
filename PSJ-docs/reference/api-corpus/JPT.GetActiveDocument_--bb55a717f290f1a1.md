# JPT.GetActiveDocument()

JPT.GetActiveDocument()

説明​

アクティブなドキュメントの情報を取得します。

構文​

JPT.GetActiveDocument()

入力​

このユーティリティ関数には入力値は不要です。

戻り値​

ドキュメントの情報を指定する Document オブジェクトです。

サンプルコード​

# モデルの準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
Home.ImportResults.Nastran(strPath=samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)
# アクティブなドキュメントの情報を取得
doc = JPT.GetActiveDocument()
JPT.Debugger(doc)
