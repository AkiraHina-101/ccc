# Post.NStepsPlotForStrainGauge.DirectionCosine()

Post.NStepsPlotForStrainGauge.DirectionCosine()

説明​

入力された方向ベクトルの方向余弦における応力/ひずみのグラフを表示します。

構文​

Post.NStepsPlotForStrainGauge.DirectionCosine(...)

マクロ: CmdPlotStrainGaugeDirCos

リボン: Post » NStepsPlotForStrainGauge » DirectionCosine

入力​

crPostJob​

処理後のジョブを指定する Cursor です。

これは必須の入力項目です。

crlTargets​

結果とチャートを取得してプロットする選択した節点を指定する Cursor のリストです。

これは必須の入力項目です。

listPostStepItem​

各Post Step Item の属性を指定する List of POST_STEP_ITEM です。

デフォルト値は POST_STEP_ITEM() です。

strXAxisType​

X軸にプロットする結果タイプを指定する String です。

これは必須の入力項目です。

strYAxisType​

Y軸にプロットする結果タイプを指定する String です。

これは必須の入力項目です。

dLength​

節点を選択したときの選択の長さを指定する Double です。

デフォルト値は 0.0 です。

dWidth​

節点を選択したときの選択の幅を指定する Double です。

デフォルト値は 0.0 です。

dAmendFactor​

ひずみ解析結果に使用される補正係数を指定する Double です。

デフォルト値は 1.0 です。

dlDirection​

(X, Y, Z) フォーマットで方向ベクトルを指定する Double 型のリスト です。

デフォルト値は [1,0,0] です。

iPhaseType​

指定方向のひずみ（応力）を取得する際の位相情報の取得方法を指定する Integer です。

0: ユーザー定義

1: ピーク（最大値）

2: ピーク（最小値）

デフォルト値は 0 です。

dPhaseAngle​

位相角の値を指定する Double です。

デフォルト値は 0.0 です。

bCreateMarkup​

グラフをプロットする際に選択された節点にマークアップラベルを付けるかどうかを指定する Boolean です。

デフォルト値は True です。

戻り値コード​

プロセスが正常に実行されたかどうかを指定する Boolean です：

True: プロセスが正常に実行されました。

False: 関数を実行できません。

サンプルコード​

# Postモデルの準備
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
