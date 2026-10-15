# Home.AddResults.Actran()

Home.AddResults.Actran()

説明​

現在のJupiterデータベースにActran Op2の結果を追加します。JupiterドキュメントはPost文書である必要があります。

構文​

Home.AddResults.Actran(...)

マクロ: AddResultsActran

リボン: Home » AddResults » Actran

入力​

strlPaths​

インポートに使用されるActranファイル（*.op2ファイル）のリストを指定する String のリストです。

これは必須の入力です。

bMergeTree​

既存のドキュメントに含まれていない違いを追加するかどうかを指定する Boolean です。

デフォルト値は True です。

戻り値​

関数が正常に実行されたかどうかを指定する Boolean です：

True: Actranの結果がドキュメントに正常に追加されました。

False: Actranの結果がドキュメントに追加されませんでした。

サンプルコード​

# メッシュおよびActranファイルを以下のパスに配置してください
meshfile='C:/Sample/mesh.bdf'
actrandatafile= 'C:/Sample/actran.op2'

Home.ImportResults.ImportMesh.Nastran(meshfile, bReadLoadAndConstraint=True, bReadConnection=True)
Home.AddResults.Actran(strlPaths=[actrandatafile], bMergeTree=False)
