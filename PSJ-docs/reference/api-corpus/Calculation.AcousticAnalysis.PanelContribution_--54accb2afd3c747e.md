# Calculation.AcousticAnalysis.PanelContribution()

Calculation.AcousticAnalysis.PanelContribution()

説明​

Actranの要素寄与結果に基づいて、各パネルのプロットラインを作成します。

構文​

Calculation.AcousticAnalysis.PanelContribution(...)

マクロ: PostToolAcousticPanelContribution

リボン: Calculation » AcousticAnalysis » PanelContribution

入力​

ilLoadCases​

選択した要素寄与プロットラインのための Integer のリストを指定します。

デフォルト値は [] です。

crlProperties​

要素寄与プロットラインのためのプロパティパネルを指定する Cursor のリストです。

デフォルト値は [] です。

iAreaUnit​

面積単位を指定する Integer です。

デフォルト値は 0 です。

bSum​

要素寄与を合計するかどうかを指定する Boolean です。

デフォルト値は True です。

戻り値​

作成されたパネル寄与を指定する Cursor のリストです。

サンプルコード​

# サンプルNastran Vibro-Acousticファイルへのパスを設定してください。
filePath="C:/Temp/Sample.op2"

# 結果モデルの準備
Home.ImportResults.Nastran(strPath=filePath, dFaceAngle=60.16, dEdgeAngle=60.16, bIsVibro=True)

# AcousticAnalysis.PanelContribution
Calculation.AcousticAnalysis.PanelContribution(ilLoadCases=[201], 
                                                crlProperties=[Property2DShell(50000), 
                                                Property3DSolid(20000, 40000)], 
                                                iAreaUnit=0)
Calculation.AcousticAnalysis.PanelContributionCreateGraph(crlLoadCases=[PostActranLoadCase(1, 2, 3, 4)])
