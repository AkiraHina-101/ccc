# Calculation.StrainGauge.TangentProjection()

Calculation.StrainGauge.TangentProjection()

説明​

各節点での接線ひずみを表示します。

構文​

Calculation.StrainGauge.TangentProjection(...)

マクロ: CmdAddStrainGaugeTangentProject

リボン: Calculation » StrainGauge » TangentProjection

入力​

ilNodeIDs​

選択された節点のIDを指定する Integer のリスト。

デフォルト値は[]です。

dWidth​

節点が選択された際の選択幅を指定する Double 。

デフォルト値は0.0です。

dLength​

節点が選択された際の選択長さを指定する Double 。

デフォルト値は0.0です。

iOriginalDirection​

最大主応力、最小主応力、X軸、Y軸、Z軸から選択された元の方向を指定する Integer 。

デフォルト値は0です。

dAngle​

回転角の値を指定する Double 。

デフォルト値は0.0です。

dVectorSize​

ベクトルサイズを指定する Double 。

デフォルト値は1.0です。

dAmendFactor​

ひずみ解析結果の補正に使用される補正係数を指定する Double 。

デフォルト値は1.0です。

strGaugeName​

ゲージ名を指定する String 。

デフォルト値は""です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean 型:

True: プロセスが正常に実行されました。

False: 関数を実行できません。

サンプルコード​

# 結果モデルを準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\103_solid.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)
# 結果をプロット
Post.ShowContour(crPostJob=TSVPostJob(1), 
                lContourSettings=[PostContourSetting(postResultKey=PostResultKey(
                iAnalysisType=2,
                iResultSet=1,
                iTimeStep=2,
                strResultName="Strain",
                strResultCompName="Solid Max Principal Strain",
                iResultPos=4),
                postDataOp=PostDataOp(iResultLocation=1,
                iOptionCoord=1,
                iOptionConversion=1,
                iOptionContinuous=8))])
Post.ShowDeformation(crPostJob=TSVPostJob(1), 
                    postResultKey=PostResultKey(
                    iAnalysisType=2,
                    iResultSet=1,
                    iTimeStep=2,
                    strResultName="Strain",
                    strResultCompName="Solid Max Principal Strain"))

# StrainGauge > AxisWithAngle
Calculation.StrainGauge.TangentProjection(ilNodeIDs=[110], dWidth=0.005, dLength=0.01,
                                        iOriginalDirection=2, dAmendFactor=2.0)
