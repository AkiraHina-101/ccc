# Calculation.StrainGauge.MaxMinPrincipal()

Calculation.StrainGauge.MaxMinPrincipal()

説明​

最大または最小主応力方向の応力またはひずみを表示します。

構文​

Calculation.StrainGauge.MaxMinPrincipal(...)

マクロ：
CmdAddStrainGaugeMaxPrincipal
CmdAddStrainGaugeMinPrincipal

リボン： Calculation » StrainGauge » MaxMinPrincipal

入力​

ilNodeIDs​

選択した節点のIDを指定する Integer のリスト。

デフォルト値は[]です。

dWidth​

節点が選択されたときの選択幅を指定する Double 型の値。

デフォルト値は0.0です。

dLength​

節点が選択されたときの選択長を指定する Double 型の値です。

デフォルト値は0.0です。

dAmendFactor​

ひずみ解析結果の修正係数を指定する Double 型の値です。

デフォルト値は1.0です。

strGaugeName​

ゲージ名を指定する String の値です。

デフォルト値は "" です。

bMaxMin​

最大方向または最小方向を使用するかどうかを指定する Boolean 型の値です。

デフォルト値は True です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean 型の値:

True: プロセスは正常に実行されました。

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
                    strResultName="Strain", 
                    strResultCompName="Solid Max Principal Strain"))

# StrainGauge > MaxMinPrincipal
Calculation.StrainGauge.MaxMinPrincipal(ilNodeIDs=[129,110], dWidth=0.005, dLength=0.01, bMaxMin=True)
