# Home.AddResults.Nastran()

Home.AddResults.Nastran()

説明​

現在のJupiterデータベースにNastran Op2の結果を追加します。Jupiter文書はポスト文書である必要があります。

構文​

Home.AddResults.Nastran(...)

マクロ: AddResultsNastran

リボン: Home » AddResults » Nastran

入力​

strlPaths​

Nastranファイル（*.op2ファイル）のリストを指定する String のリストで、これをインポートする際に使用します。

この入力は必須です。

bMergeTree​

既存の文書に含まれない差異を追加するかどうかを指定する Boolean です。

デフォルト値は True です。

bCreateResultAtMidNode​

Mid Nodesで結果を作成するかどうかを指定する Boolean です。

デフォルト値は True です。

戻り値​

関数が正常に実行されたかどうかを指定する Boolean 型です：

True: Nastranの結果が正常に文書に追加されました。

False: Nastranの結果が文書に追加されませんでした。

サンプルコード​

# サンプルファイルを配置します
Mesh = "C:/Temp/mesh.bdf"
Result = "C:/Temp/result.op2"

# メッシュファイルをインポートします
Home.ImportResults.ImportMesh.Nastran(Mesh, bReadLoadAndConstraint=True, bReadConnection=True)
# メッシュファイルに結果を追加します。
Home.AddResults.Nastran(strlPaths=[Result], bMergeTree=False)
