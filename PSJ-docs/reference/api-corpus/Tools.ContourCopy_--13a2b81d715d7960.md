# Tools.ContourCopy()

Tools.ContourCopy()

説明​

現在のポストドキュメントの輪郭を指定されたプリドキュメントに表示します。

構文​

Tools.ContourCopy(...)

マクロ: ContourCopy

リボン: Tools » ContourCopy

入力​

strPostDocName​

輪郭をコピーするポストドキュメント名を指定する String です。

この入力は必須です。

strPreDocName​

輪郭をコピーするプリドキュメント名を指定する String です。

この入力は必須です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean 型です：

True: プロセスは正常に実行されました。

False: 関数を実行できません。

サンプルコード​

# ポストモデルを準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
Home.ImportResults.Nastran(strPath= samplePath, dFaceAngle=60.16, dEdgeAngle=60.16, bReadLoadAndConstraint=True, 
                            bReadConnection=True, bCreateResultsAtMidNode=True)

# プリモデルを準備
Tools.ToPre(strName="101_solid", ilOptions=[0, 1, 2, 3, 4])
# 結果をプロット
JPT.SetActiveDocumentByName("101_solid",1)
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
Post.EnableMiddleNodes()

# 輪郭をコピー
dataCopy = Tools.ContourCopy(strPostDocName="101_solid", strPreDocName="101_solid_Converted_Pre")
JPT.Debugger(dataCopy)
