# Calculation.AcousticAnalysis.TransmissionLoss.TransmissionLossCondition()

Calculation.AcousticAnalysis.TransmissionLoss.TransmissionLossCondition()

説明​

PCHファイルの入力サイドとアウトプットサイドで作成された選択された節点グループからAC電力と透過率を計算します。

構文​

Calculation.AcousticAnalysis.TransmissionLoss.TransmissionLossCondition(...)

マクロ: AcousticTLCondition

リボン: Calculation » AcousticAnalysis » TransmissionLoss » TransmissionLossCondition

入力​

crGroupIn​

入力データの節点グループを指定する Cursor です。

デフォルト値は None です。

crGroupOut​

アウトプットデータの節点グループを指定する Cursor です。

デフォルト値は None です。

crEdit​

既存の伝達損失条件を指定する Cursor です

このパラメータを使用すると、指定された伝達損失条件が変更されます。

None のままにしておくと、新しい伝達損失条件が作成されます。

デフォルト値は None です。

戻り値​

作成された伝達損失条件を指定する Cursor です。

サンプルコード​

# サンプルNastran Vibro-AcousticファイルとPunchファイルのパスを設定してください。
ResultFile="C:/Temp/Sample.op2"
PunchFile="C:/Temp/PunchSample.pch"

# 結果モデルを準備する
Home.ImportResults.Nastran(strPath=ResultFile, dFaceAngle=60.16, dEdgeAngle=60.16, bIsVibro=True)

# 伝達損失条件
Calculation.AcousticAnalysis.TransmissionLoss.PCHResult(strPath=PunchFile)
condition = Calculation.AcousticAnalysis.TransmissionLoss.TransmissionLossCondition(crGroupIn=Group(1), 
                                                                                    crGroupOut=Group(2))
JPT.Debugger(condition)
