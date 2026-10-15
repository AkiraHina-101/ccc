# Post.SetNote.ResultSubID()

Post.SetNote.ResultSubID()

説明​

ノートウィンドウにサブケースIDの表示を設定します。

構文​

Post.SetNote.ResultSubID(...)

マクロ：SetNoteResultSubID

リボン：Post » SetNote » ResultSubID

入力​

bNoteResultSubID​

ノートウィンドウにサブケースIDを表示するかどうかを指定する Boolean です。

デフォルト値は True です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean です。

True： プロセスが正常に実行されます。

False： 関数を実行できません。

サンプルコード​

# Post モデルの準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\103_solid.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60, dEdgeAngle=60)

# 結果をプロット
Post.ShowContour(crPostJob=TSVPostJob(1), 
                lContourSettings=[PostContourSetting(postResultKey=PostResultKey(
                iAnalysisType=2, 
                iResultSet=1, 
                iTimeStep=1, 
                strResultName="Stress", 
                strResultCompName="Mises", 
                iResultPos=2), 
                postDataOp=PostDataOp(iResultLocation=2))])
Post.ShowDeformation(crPostJob=TSVPostJob(1), 
                    postResultKey=PostResultKey(
                    iAnalysisType=2, 
                    iResultSet=1, 
                    iTimeStep=1, 
                    strResultName="Stress", 
                    strResultCompName="Mises"))
Post.Note.Element(crlTargets=[ROElem(448)])

# サブケースIDを非表示にする
Post.SetNote.ResultSubID(bNoteResultSubID=False)
