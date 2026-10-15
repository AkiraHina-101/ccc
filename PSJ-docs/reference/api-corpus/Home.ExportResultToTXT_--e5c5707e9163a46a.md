# Home.ExportResultToTXT()

Home.ExportResultToTXT()

説明​

選択した結果ファイルをテキスト形式（*.txt）でエクスポートします。

構文​

Home.ExportResultToTXT(...)

マクロ: PostExportToTxt

リボン: Home » ExportResultToTXT

入力​

strFileName​

エクスポートするファイルのパスを指定する String です。

これは必須の入力項目です。

iSpliterType​

出力値を区切る方法を指定する Integer です。

0: スペース（ ）

1: カンマ（,）

2: セミコロン（;）

デフォルト値は 0 です。

bAppend​

結果を指定されたファイルに追加するかどうかを指定する Boolean です。

デフォルト値は False です。

crlJobs​

ポストジョブを指定する Cursor リストです。

デフォルト値は [] です。

ilAnalysisTypes​

解析タイプを指定する Integer リストです。

デフォルト値は [] です。

ilResultSets​

結果セットを指定する Integer リストです。

デフォルト値は [] です。

ilTimeSteps​

タイムステップを指定する Integer リストです。

デフォルト値は [] です。

ilResultTypes​

結果タイプを指定する Integer リストです。

デフォルト値は [] です。

ilResultPos​

結果の位置を指定する Integer リストです。

デフォルト値は [] です。

strlResultNames​

結果名を指定する String リストです。

デフォルト値は [] です。

strlCompNames​

コンポーネント名を指定する String リストです。

デフォルト値は [] です。

strlNames​

結果名を指定する String リストです。

デフォルト値は [] です。

strlTypes​

結果タイプを指定する String リストです。

デフォルト値は [] です。

crlEdit​

編集対象を指定する Cursor リストです。

デフォルト値は [] です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean です。

True: プロセスは正常に実行されました。

False: 関数を実行できません。

サンプルコード​

# 結果モデルの準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16) 

# 結果をtxt形式でエクスポート
exportFile = Home.ExportResultToTXT(strFileName="C:/temp/ExportTXT.txt", 
                                    iSpliterType=1, 
                                    crlJobs=[TSVPostJob(1, 1)], 
                                    ilAnalysisTypes=[1, 1], 
                                    ilResultSets=[1, 1], 
                                    ilTimeSteps=[1, 1], 
                                    ilResultTypes=[3, 4], 
                                    ilResultPos=[1, 1], 
                                    strlResultNames=["", ""], 
                                    strlCompNames=["", ""], 
                                    strlNames=["RX", "RY"], 
                                    strlTypes=["TYPE_VIRTUAL_RESULT_ITEM", "TYPE_VIRTUAL_RESULT_ITEM"], 
                                    crlEdit=[Unknown(0, 0)])
JPT.Debugger(exportFile )
