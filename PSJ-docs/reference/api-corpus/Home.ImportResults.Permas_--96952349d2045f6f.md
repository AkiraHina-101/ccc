# Home.ImportResults.Permas()

Home.ImportResults.Permas()

説明​

Permasの結果ファイルをインポートします。

構文​

Home.ImportResults.Permas(...)

マクロ: ImportPermas

リボン: Home » ImportResults » Permas

入力​

strPath​

nastranの結果ファイルパスを指定する String の入力です。

この入力は必須です。

iImportType​

インポートタイプを指定する Integer の入力です。

デフォルト値は1です。

dFaceAngle​

フェース分割を決定するための角度許容度を指定する Double 型の入力です（指定値よりも小さい角度を持つ隣接要素間にエッジを作成することで）。

デフォルト値は60.0（度）です。

dEdgeAngle​

エッジ分割を決定するための角度許容度を指定する Double 型の入力です（指定値よりも大きい角度を持つ隣接エッジ要素に頂点を作成することで）。

デフォルト値は60.0（度）です。

戻り値​

関数が正常に実行されたかどうかを指定する Boolean 型の戻り値です：

True: Permasファイルが正常にインポートされました。

False: Permasファイルをインポートできませんでした。

サンプルコード​

# サンプル汎用ファイルへのパスを設定してください。
filepath="C:/Temp/result.post.gz"

Home.ImportResults.Permas(filepath)
