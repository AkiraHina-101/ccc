# Post.NStepsPlotForStrainGauge.AxisWithAngle()

Post.NStepsPlotForStrainGauge.AxisWithAngle()

説明​

2 軸平面上の最初の定義された軸から入力された回転角度の応力/ひずみのグラフを表示します。

構文​

Post.NStepsPlotForStrainGauge.AxisWithAngle(...)

マクロ: CmdPlotStrainGaugeAxisAngle

リボン: Post » NStepsPlotForStrainGauge » AxisWithAngle

入力​

crPostJob​

処理のポストジョブを指定する Cursor です。

これは必須の入力です。

listPostStepItem​

各 Post Step アイテムの属性を指定する List of POST_STEP_ITEM です。

デフォルト値は POST_STEP_ITEM() です。

crlTargets​

結果を取得してチャートをプロットする選択された節点を指定する Cursor のリストです。

これは必須の入力です。

strXAxisType​

X軸にプロットする結果のタイプを指定する String です。

これは必須の入力です。

strYAxisType​

Y軸にプロットする結果のタイプを指定する String です。

これは必須の入力です。

iFirstAxis​

最大主応力、最小主応力、中間主応力から最初の軸を指定する Integer です。

デフォルト値は 0 です。

iSecondAxis​

最小主応力および中間主応力から 2 番目の軸を指定する Integer です。

デフォルト値は 0 です。

dAngle​

回転角度の値を指定する Double です。

デフォルト値は 0.0 です。

dLength​

節点が選択されたときの選択の長さを指定する Double です。

デフォルト値は 0.0 です。

dWidth​

節点が選択されたときの選択の幅を指定する Double です。

デフォルト値は 0.0 です。

dAmendFactor​

ひずみ解析結果に使用される補正用係数を指定する Double です。

デフォルト値は 1.0 です。

iPhaseType​

指定された方向でひずみ(応力)を取得する際に位相情報を取得する方法を指定する Integer です。

0: ユーザー定義

1: ピーク (最大)

2: ピーク (最小)

デフォルト値は 0 です。

dPhaseAngle​

位相角の値を指定する Double です。

デフォルト値は 0.0 です。

bCreateMarkup​

グラフをプロットする際に選択された節点にラベルを付けるかどうかを指定する Boolean です。

デフォルト値は True です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean です:

True: プロセスが正常に実行されました。

False: 関数を実行できません。

サンプルコード​

# Post モデルの準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\111_solid.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)

# NStepsPlotForStrainGauge > MaxMinPrincipal
plot = Post.NStepsPlotForStrainGauge.MaxMinPrincipal(crPostJob=TSVPostJob(1), 
                                            listPostStepItem=[
                                            PostStepItem(iAnalysisType=4, iResultSet=1, iTimeStep=1), 
                                            PostStepItem(iAnalysisType=4, iResultSet=1, iTimeStep=2), 
                                            PostStepItem(iAnalysisType=4, iResultSet=1, iTimeStep=3), 
                                            PostStepItem(iAnalysisType=4, iResultSet=1, iTimeStep=4), 
                                            PostStepItem(iAnalysisType=4, iResultSet=1, iTimeStep=5), 
                                            PostStepItem(iAnalysisType=4, iResultSet=1, iTimeStep=6), 
                                            PostStepItem(iAnalysisType=4, iResultSet=1, iTimeStep=7), 
                                            PostStepItem(iAnalysisType=4, iResultSet=1, iTimeStep=8), 
                                            PostStepItem(iAnalysisType=4, iResultSet=1, iTimeStep=9), 
                                            PostStepItem(iAnalysisType=4, iResultSet=1, iTimeStep=10)], 
                                            crlTargets=[Node(133, 132)], 
                                            strXAxisType="Time/Freq(Default)", 
                                            strYAxisType="Stress(Node)")
JPT.Debugger(plot)
