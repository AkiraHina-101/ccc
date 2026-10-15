# Home.AddResults.ADVC()

Home.AddResults.ADVC()

説明​

現在のJupiterデータベースにADVCの結果を追加します。

構文​

Home.AddResults.ADVC(...)

マクロ：AddResultsADVC

リボン：Home » AddResults » ADVC

入力​

strlPaths​

インポートに使用されるADVCファイルのリストを指定する Stringのリスト です。

これは必須の入力です。

bMergeTree​

既存ドキュメントに含まれない差分を追加するかどうかを指定する Boolean です。

デフォルト値は True です。

bADVCProcessNameRule​

ADVC側で定義されたADVCプロセスIDが表示されるかどうかを指定する Boolean です。

デフォルト値は False です。

bDisplayNAResult​

"NA Result Display" オプションがADVCで有効になっているかどうかを指定する Boolean です。 trueに設定すると、欠損データに対しては "Data: ---" が表示され、観測データのメモには "No data available" が表示されます。偏心出力結果にのみ適用されます。 falseに設定すると、標準データ表示ルールが適用されます。

デフォルト値は False です。

strPathSelectResultFile​

指定された String です

デフォルト値は "" です。

戻り値​

関数が正常に実行されたかどうかを指定する Boolean です：

True：ADVCの結果がドキュメントに正常に追加されました。

False：ADVCの結果がドキュメントに追加されませんでした。

サンプルコード​

#サンプルADVCフォルダへのパスを設定してください。
meshfile='C:/Sample/mesh.adx'
folderpath="C:/Temp/SampleADVC"

Home.ImportResults.ImportMesh.ADVC(folderpath)
Home.AddResults.ADVC(strlPaths=[folderpath], bMergeTree=False, bADVCProcessNameRule=False, bDisplayNAResult=False)
