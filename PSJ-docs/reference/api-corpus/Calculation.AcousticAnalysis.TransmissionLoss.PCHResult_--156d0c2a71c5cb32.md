# Calculation.AcousticAnalysis.TransmissionLoss.PCHResult()

Calculation.AcousticAnalysis.TransmissionLoss.PCHResult()

説明​

Nastran構造音響連成計算から出力された結合面の情報を含む Punch ファイル（*.pch）を読み込み、音響モデルに節点グループを作成します。

構文​

Calculation.AcousticAnalysis.TransmissionLoss.PCHResult(...)

マクロ: AcousticTLPCHResult

リボン: Calculation » AcousticAnalysis » TransmissionLoss » PCHResult

入力​

strPath​

(*.pch) ファイルのパスを指定する String 。

これは必須入力です。

戻り値​

作成された PHC 結果を指定する Cursor です。

サンプルコード​

# サンプル Nastran Vibro-Acoustic ファイルと Punch ファイルのパスを設定してください。
ResultFile="C:/Temp/Sample.op2"
PunchFile="C:/Temp/PunchSample.pch"

# 結果モデルの準備
Home.ImportResults.Nastran(strPath=ResultFile, dFaceAngle=60.16, dEdgeAngle=60.16, bIsVibro=True)

# PCH 結果
PCHResult = Calculation.AcousticAnalysis.TransmissionLoss.PCHResult(strPath=PunchFile)
JPT.Debugger(PCHResult)
