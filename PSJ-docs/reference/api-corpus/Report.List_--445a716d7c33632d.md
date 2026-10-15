# Report.List()

Report.List()

説明​

選択した結果をCSVファイルまたはユニバーサルフォーマットにエクスポートします。

構文​

Report.List(...)

マクロ: ResultOutputList

リボン: Report » List

入力​

strPath​

エクスポートするファイルのパスを指定する String 。

これは必須入力です。

crlTargets​

エクスポートされるデータの選択された部分を指定する Cursor リスト。

デフォルト値は [] です。

iResultType​

エクスポートする結果の種類を指定する Integer 。

0: 変位

1: 温度

2: エネルギー

3: SPC Force

4: MPC Force

5: 応力

6: ひずみ

7: その他

デフォルト値は 0 です。

iOutput​

すべての選択されたサブケースを1つのファイルに出力するか、各選択されたサブケースごとに個別のファイルに出力するかを指定する Integer 。

0: 単一。

1: 複数。

デフォルト値は 0 です。

iOutPutType​

出力ファイルの形式を指定する Integer 。

0: CSV

1: Unv

デフォルト値は 0 です。

iResultPosition​

結果の出力位置を指定する Integer 。

0: 節点

1: 要素

デフォルト値は 0 です。

bMidNode​

エクスポートされた結果に中間節点を有効/無効にするかを指定する Boolean 型。

デフォルト値は False です。

listPostResultKey​

選択された結果の属性を指定する POST_RESULT_KEY のリスト。

デフォルト値は POST_RESULT_KEY() です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean 型：

True: プロセスが正常に実行されました。

False: 関数を実行できません。

サンプルコード​

# Postモデルを準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\103_solid.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)
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
                iOptionCoord=1))])
Post.ShowDeformation(crPostJob=TSVPostJob(1), 
                    postResultKey=PostResultKey(
                    iAnalysisType=2, 
                    iResultSet=1, 
                    iTimeStep=1, 
                    strResultName="Displacement", 
                    strResultCompName="Translational"))
Post.EnableMiddleNodes()

# リストレポートを作成
reportList = Report.List(strPath="C:/temp/ReportList.csv", 
                        crlTargets=[Part(3)], 
                        iOutput=1, 
                        bMidNode=True, 
                        listPostResultKey=[[2, 1, 1, 0], [2, 1, 2, 0], [2, 1, 3, 0], [2, 1, 4, 0], [2, 1, 5, 0]])
JPT.Debugger(reportList)
