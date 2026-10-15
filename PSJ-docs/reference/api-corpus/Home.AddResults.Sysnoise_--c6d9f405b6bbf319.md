# Home.AddResults.Sysnoise()

Home.AddResults.Sysnoise()

説明​

現在のJupiterデータベースにsysnoiseの結果を追加します。

構文​

Home.AddResults.Sysnoise(...)

マクロ: AddResultsSysnoise

リボン: Home » AddResults » Sysnoise

入力​

strlPaths​

sysnoiseの結果ファイルを指定する String のリストです。

この入力は必須です。

bMergeTree​

既存のドキュメントに含まれていない差異を追加するかどうかを指定する Boolean です。

デフォルト値は True です。

戻り値​

関数の実行が成功したかどうかを指定する Boolean です：

True: sysnoiseの結果がドキュメントに追加されました。

False: sysnoiseの結果がドキュメントに追加されませんでした。

サンプルコード​

# サンプルファイルを配置します
Mesh = "C:/Temp/mesh.bdf"
Result = "C:/Temp/result"

# メッシュファイルをインポートします
Home.ImportResults.ImportMesh.Nastran(Mesh, bReadLoadAndConstraint=True, bReadConnection=True)
# メッシュファイルに結果を追加します。
Home.AddResults.Sysnoise(strlPaths=[Result], bMergeTree=False)
