# Home.ImportResults.Universal()

Home.ImportResults.Universal()

説明​

ユニバーサル結果ファイルをインポートします。

構文​

Home.ImportResults.Universal(...)

マクロ: ImportUniversal

リボン: Home » ImportResults » Universal

入力​

strPath​

ユニバーサル結果ファイルのパスを指定する String です。

これは必須入力です。

iImportType​

インポートタイプを指定する Integer です。ユニバーサルファイルの場合、常に1に設定されています。

デフォルト値は1です。

dFaceAngle​

フェースの分割を決定するための角度許容度を指定する Double 型です（指定値より小さい角度を持つ隣接要素間にエッジを作成することで）。

デフォルト値は60.0（度）です。

dEdgeAngle​

エッジの分割を決定するための角度許容度を指定する Double 型です（指定値より大きい角度を持つ隣接エッジ要素に頂点を作成することで）。

デフォルト値は60.0（度）です。

戻り値​

関数が正常に実行されたかどうかを指定する Boolean 型です：

True: ユニバーサルファイル（*.unv ファイル）が正常にインポートされました。

False: ユニバーサルファイル（*.unv ファイル）をインポートできません。

サンプルコード​

#サンプルユニバーサルファイルへのパスを設定してください。
filepath="C:/Temp/Sample.unv"

Home.ImportResults.Universal(filepath)
