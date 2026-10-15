# Home.ExportPV()

Home.ExportPV()

説明​

3種類の要素、または材料、またはプロパティに応じて、PVファイルに結果を出力します。

構文​

Home.ExportPV(...)

マクロ: Export_Post_Viewer_File

リボン: Home » ExportPV

入力​

iGroupType​

出力グループのタイプを指定する Integer です。

0: なし

1: グループ内で作成された要素を指定します

2: グループ内で作成された材料を指定します

3: グループ内で作成されたプロパティを指定します

デフォルト値は0です。

strFileName​

出力するファイルのパスを指定する String です。

デフォルト値は "" です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean です。

True: プロセスが正常に実行されました。

False: 関数を実行できません。

サンプルコード​

# 結果モデルの準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16) 
Post.ShowContour(crPostJob=TSVPostJob(1), 
                lContourSettings=[PostContourSetting(
                    postResultKey=PostResultKey(
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
Tools.Group.CreateGroup(strGroupName="Element3DGroup", crlTargets=[ROElem(479, 477, 480, 478)])

# PVのエクスポート
exportFile = Home.ExportPV(iGroupType=1, strFileName="C:/temp/ExportPV.tsv")
JPT.Debugger(exportFile)
