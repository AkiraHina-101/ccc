# Report.LinearStatic()

Report.LinearStatic()

説明​

パートや素材の設定された静的解析結果の閾値外に表示されるパート（コンポーネント）を検索し、画像をキャプチャして自動的に Microsoft Office PowerPoint に貼り付けます。

構文​

Report.LinearStatic(...)

マクロ：CmdGeneralReportLinearStatic

リボン：Report » LinearStatic

入力​

iCalculateValue​

評価値を指定する Integer です。

0: Mises。

1: 最大主応力。

2: 最小主応力。

3: 変位。

デフォルト値は 0 です。

iEvaluationValue​

評価式を指定する Integer です。

0: A が評価値で B が基準値の場合。

1: B が評価値で A が基準値の場合。

デフォルト値は 0 です。

listPartInformation​

コンポーネントの属性を指定する List of GENERAL_REPORT_LINEAR_STATIC_DATA です。

デフォルト値は GENERAL_REPORT_LINEAR_STATIC_DATA() です。

bUseCurrentView​

現在のビューを透視図として使用するかどうかを指定する Boolean です。

デフォルト値は False です。

bExportPPT​

結果画像を PowerPoint にエクスポートするかどうかを指定する Boolean です。

デフォルト値は True です。

bExportImage​

結果画像をファイルに保存するかどうかを指定する Boolean です。

デフォルト値は False です。

strImagePath​

指定された形式で保存される画像ファイルのパスを指定する String です。

デフォルト値は "" です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean 型です：

True: プロセスは正常に実行されました。

False: 関数を実行できません。

サンプルコード​

# ポストモデルの準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
Home.ImportResults.Nastran(strPath= samplePath, dFaceAngle=60.16, dEdgeAngle=60.16, bReadLoadAndConstraint=True, 
                            bReadConnection=True, bCreateResultsAtMidNode=True)

# 線形静解析レポート作成
reportLinearStatic = Report.LinearStatic(iCalculateValue=1, 
                                        listPartInformation=[
                                        General_Report_LinearStatic_Data(
                                            strPartName="全体", 
                                            strPropName="-", 
                                            strMatName="-", 
                                            dValue=0.000000), 
                                        General_Report_LinearStatic_Data(
                                            strPartName="パート - PSOLID (1)", 
                                            strPropName="PSOLID (1)", 
                                            strMatName="MAT (1)", 
                                            dValue=0.000000), 
                                        General_Report_LinearStatic_Data(
                                            strPartName="パート - PSOLID (2)", 
                                            strPropName="PSOLID (2)", 
                                            strMatName="MAT (1)", 
                                            dValue=0.000000), 
                                        General_Report_LinearStatic_Data(
                                            strPartName="パート - PSOLID (3)", 
                                            strPropName="PSOLID (3)", 
                                            strMatName="MAT (1)", 
                                            dValue=0.000000), 
                                        General_Report_LinearStatic_Data(
                                            strPartName="パート - PSOLID (4)", 
                                            strPropName="PSOLID (4)", 
                                            strMatName="MAT (1)", 
                                            dValue=0.000000), 
                                        General_Report_LinearStatic_Data(
                                            strPartName="パート - PSOLID (5)", 
                                            strPropName="PSOLID (5)", 
                                            strMatName="MAT (1)", 
                                            dValue=0.000000), 
                                        General_Report_LinearStatic_Data(
                                            strPartName="パート - PSOLID (6)", 
                                            strPropName="PSOLID (6)", 
                                            strMatName="MAT (1)", 
                                            dValue=0.000000)], 
                                            bExportPPT=True)
JPT.Debugger(reportLinearStatic)
