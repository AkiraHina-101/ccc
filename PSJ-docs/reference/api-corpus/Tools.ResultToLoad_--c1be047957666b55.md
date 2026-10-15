# Tools.ResultToLoad()

Tools.ResultToLoad()

説明​

選択した結果名を、選択したエンティティのソルバー情報（ソルバーキーワードカードとして）にエクスポートします。変換ロードタイプの選択に応じて、解析結果がそれぞれソルバーカード情報にエクスポートされます。

構文​

Tools.ResultToLoad(...)

マクロ: CmdExportLoad

リボン: Tools » ResultToLoad

入力​

crlTargets​

選択されたエンティティを指定する Cursor のリスト。エンティティはPart、Face、Node、Element、またはGroupになります。

これは必須の入力です。

listPostStepItem​

各Post Step Item の属性を指定する POST_STEP_ITEMのリスト。

デフォルト値はPOST_STEP_ITEM() です。

vecResultLoad​

選択した結果のコンポーネントを指定する RESULT_LOADのVector。

デフォルト値はRESULT_LOAD() です。

strExportPath​

エクスポートするファイルのパスを指定する String。

これは必須の入力です。

iSolverType​

ソルバータイプを指定する Integer。

デフォルト値は 2 (Nastran) です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean:

True: プロセスが正常に実行されました。

False: 関数を実行できません。

サンプルコード​

# ポストモデルの準備
samplePath = JPT.GetProgramPath() + "SampleData\\Post\\Static_Renkon.op2"
Home.ImportResults.Nastran(strPath= samplePath, dFaceAngle=60.16, dEdgeAngle=60.16, bReadLoadAndConstraint=True, 
                            bReadConnection=True, bCreateResultsAtMidNode=True)
Post.ShowContour(crPostJob=TSVPostJob(1), 
                lContourSettings=[PostContourSetting(postResultKey=PostResultKey(
                iAnalysisType=1, 
                iResultSet=1, 
                iTimeStep=1, 
                strResultName="Displacement", 
                strResultCompName="Translational", 
                iResultPos=1), 
                postDataOp=PostDataOp(
                iResultLocation=1, 
                iOptionCoord=1))])
Post.ShowDeformation(crPostJob=TSVPostJob(1), 
                    postResultKey=PostResultKey(
                    iAnalysisType=1, 
                    iResultSet=1, 
                    iTimeStep=1, 
                    strResultName="Displacement", 
                    strResultCompName="Translational"))

# 結果をロード
sampleFile = Tools.ResultToLoad(crlTargets=[Face(10)], 
                                postStepItem=PostStepItem(iAnalysisType=1, iResultSet=1, iTimeStep=1), 
                                vecResultLoad=[ResultLoad(iVrType=6, strResultName="Displacement", strLoadName="Enforced Displacement")], 
                                strExportPath="C:/temp/ResultToLoadFile")
JPT.Debugger(sampleFile)
