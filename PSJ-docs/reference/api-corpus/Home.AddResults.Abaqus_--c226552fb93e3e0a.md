# Home.AddResults.Abaqus()

Home.AddResults.Abaqus()

説明​

現在のJupiterデータベースにAbaqus .odbの結果を追加します。

構文​

Home.AddResults.Abaqus(...)

マクロ：AddResultsAbaqus

リボン：Home » AddResults » Abaqus

入力​

strlPaths​

インポートに使用されるAbaqusファイル（*.odbファイル）のリストを指定する String のリストです。

この入力は必須です。

bMergeTree​

既存のドキュメントに含まれていない差異を追加するかどうかを指定する Boolean です。

デフォルト値は True です。

iVersion​

Abaqusファイルのバージョンを指定する Integer です。

デフォルト値は2019です。

戻り値​

関数が正常に実行されたかどうかを表す Boolean です：

True：Abaqusの結果がドキュメントに正常に追加されました。

False：Abaqusの結果がドキュメントに追加されませんでした。

サンプルコード​

# サンプルファイルを追加してください
Mesh = "C:/Temp/mesh.inp"
Result = "C:/Temp/result.odb"

# メッシュファイルをインポート
Home.ImportResults.ImportMesh.Abaqus(Mesh, bReadLoadAndConstraint=True, bReadConnection=True)
# 結果をメッシュファイルに追加する
Home.AddResults.Abaqus(strlPaths=[Result], bMergeTree=False)
