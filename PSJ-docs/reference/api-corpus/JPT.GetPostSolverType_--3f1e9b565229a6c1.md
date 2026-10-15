# JPT.GetPostSolverType()

JPT.GetPostSolverType()

説明​

現在のインポート結果ファイルの結果タイプを取得します。

構文​

JPT.GetPostSolverType()

入力​

このユーティリティ関数には入力値は必要ありません。

戻り値​

インポート結果の ポストジョブタイプ を指定する Enum。

サンプルコード​

# ポストモデルの準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\103_solid.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)

# ポストソルバータイプを取得
type = JPT.GetPostSolverType()
print(type)
