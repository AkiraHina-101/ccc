# Calculation.StrainGauge.ExistingResult()

Calculation.StrainGauge.ExistingResult()

説明​

既存の結果のベクトル方向の歪みを取得します。

構文​

Calculation.StrainGauge.ExistingResult(...)

マクロ：CmdAddStrainGaugeExistingResult

リボン：Calculation » StrainGauge » ExistingResult

入力​

ilNodeIDs​

選択された節点のIDを指定する Integer のリストです。

デフォルト値は[]です。

iAnalysisType​

分析タイプを指定する Integer です。

デフォルト値は0です。

iResultSet​

結果セットを指定する Integer です。

デフォルト値は1です。

iTimeStep​

タイムステップを指定する Integer です。

デフォルト値は1です。

iResultType​

結果タイプを指定する Integer です。

デフォルト値は1です。

dWidth​

節点が選択されたときの選択幅を指定する Double です。

デフォルト値は0.0です。

dLength​

節点が選択されたときの選択長さを指定する Double です。

デフォルト値は0.0です。

dAmendFactor​

歪み解析結果用に使用される補正係数を指定する Double です。

デフォルト値は1.0です。

strGaugeName​

ゲージ名を指定する String です。

デフォルト値は""です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean です：

True: プロセスは正常に実行されました。

False: 関数を実行できません。

サンプルコード​

# 結果モデルの準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\103_solid.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)
# 結果のプロット
Post.ShowContour(crPostJob=TSVPostJob(1), 
                lContourSettings=[PostContourSetting(postResultKey=PostResultKey(
                iAnalysisType=2,
                iResultSet=1, 
                iTimeStep=2, 
                strResultName="Stress", 
                strResultCompName="XY", 
                iResultPos=4), 
                postDataOp=PostDataOp(
                iResultLocation=1, 
                iOptionCoord=1, 
                iOptionConversion=1, 
                iOptionContinuous=8))])
Post.ShowDeformation(crPostJob=TSVPostJob(1), 
                    postResultKey=PostResultKey(
                    iAnalysisType=2, 
                    iResultSet=1, 
                    iTimeStep=2, 
                    strResultName="Stress", 
                    strResultCompName="XY"))

# StrainGauge > ExistingResult
Calculation.StrainGauge.ExistingResult(ilNodeIDs=[109], iAnalysisType=2, iResultType=6, dWidth=0.005, dLength=0.01)
