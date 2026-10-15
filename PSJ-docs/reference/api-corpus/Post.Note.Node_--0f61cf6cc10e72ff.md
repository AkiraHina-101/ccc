# Post.Note.Node()

Post.Note.Node()

説明​

メインウィンドウで選択した節点にノート指示を追加し、Watch DataウィンドウのNodeタブのデータテーブルに入力します。

構文​

Post.Note.Node(...)

マクロ: CmdMarkupNode

リボン: Post » Note » Node

入力​

crlTargets​

マークアップされたノートを指定する選択した節点の Cursor リスト。

これは必須の入力です。

戻り値コード​

プロセスが正常に実行されたかどうかを指定する Boolean 型。

True: プロセスが正常に実行されました。

False: 関数を実行できません。

サンプルコード​

# ポストモデルを準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\103_solid.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)
# 結果をプロット
Post.ShowContour(crPostJob=TSVPostJob(1), 
                lContourSettings=[PostContourSetting(postResultKey=PostResultKey(
                iAnalysisType=2, 
                iResultSet=1, 
                iTimeStep=1, 
                strResultName="Displacement", 
                strResultCompName="Translational", 
                iResultPos=1), 
                postDataOp=PostDataOp(
                iResultLocation=1, 
                iOptionCoord=4))])
Post.ShowDeformation(crPostJob=TSVPostJob(1), 
                    postResultKey=PostResultKey(
                    iAnalysisType=2, 
                    iResultSet=1, 
                    iTimeStep=1, 
                    strResultName="Displacement", 
                    strResultCompName="Translational"))

# 選択した節点にノートを表示
Post.Note.Node(crlTargets=[RONode(129,133)])
