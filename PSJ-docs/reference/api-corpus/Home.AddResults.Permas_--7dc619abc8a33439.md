# Home.AddResults.Permas()

Home.AddResults.Permas()

説明​

現在のJupiterデータベースにPermas結果を追加します。

構文​

Home.AddResults.Permas(...)

マクロ：AddResultsPermas

リボン：Home » AddResults » Permas

入力​

strlPaths​

Permas結果ファイルを指定する String のリストです。

この入力は必須です。

bMergeTree​

既存のドキュメントに含まれない違いを追加するかどうかを指定する Boolean です。

デフォルト値は True です。

戻り値​

関数が正常に実行されたかどうかを指定する Boolean です：

True：Permas結果がドキュメントに正常に追加されました。

False：Permas結果がドキュメントに追加されませんでした。

サンプルコード​

# サンプルファイルを入れる
mesh = "C:/Temp/mesh.dat"
result = "C:/Temp/result.post.gz"

# メッシュファイルをインポート
Home.ImportResults.Permas(mesh)
# 結果をメッシュファイルに追加します
Home.AddResults.Permas(strlPaths=[result], bMergeTree=False)
