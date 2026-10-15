# Post.SetNote.ElementNodeID()

Post.SetNote.ElementNodeID()

説明​

要素のメモウィンドウに節点IDの表示を設定します。

構文​

Post.SetNote.ElementNodeID(...)

マクロ: SetNoteElementNodeID

リボン: Post » SetNote » ElementNodeID

入力​

bNoteElemNodeID​

要素のメモウィンドウに節点IDを表示するかどうかを指定する Boolean です。

デフォルト値は True です。

iNoteElemNodeID​

節点IDのタイトルの表示方法をデフォルトまたはユーザー定義名で指定する Integer です。

0: デフォルト

1: ユーザー定義

デフォルト値は 0 です。

strNoteElemNodeID​

節点IDのタイトルの任意のユーザー定義名を指定する String です。このオプションは iNoteElemNodeID= 1 の場合に使用されます。

デフォルト値は "" です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean です。

True: プロセスが正常に実行されました。

False: 関数を実行できません。

サンプルコード​

# ポスト モデルの準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\103_solid.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)
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

# 節点IDの情報を非表示にします
Post.SetNote.ElementNodeID(bNoteElemNodeID=False)
# ユーザーが節点IDのタイトルを定義します
Post.SetNote.ElementNodeID(iNoteElemNodeID=1, strNoteElemNodeID="Node IDs")
