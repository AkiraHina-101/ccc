# Home.ExportGeometrySurface()

Home.ExportGeometrySurface()

説明​

ジオメトリ表面をPost形式（*.stl）でファイルにエクスポートします。

構文​

Home.ExportGeometrySurface(...)

マクロ: PostExportGeom

リボン: Home » ExportGeometrySurface

入力​

strFolderName​

フォルダのパスを指定する String です。

これは必須の入力です。

bUseUnit​

エクスポート時に単位を使用するかどうかを指定する Boolean です。

デフォルト値は True です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean です。

True: プロセスが正常に実行されました。

False: 関数を実行できません。

サンプルコード​

# 結果モデルを準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16) 

# Post用のジオメトリ表面をエクスポート
exportFile = Home.ExportGeometrySurface(strFolderName="C:\\temp")
JPT.Debugger(exportFile)
