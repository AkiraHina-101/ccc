# Home.ImportResults.STDFile()

Home.ImportResults.STDFile()

説明​

stdリザルトファイルをインポートします。

構文​

Home.ImportResults.STDFile(...)

マクロ: ImportSTDFile

リボン: Home » ImportResults » STDFile

入力​

strPath​

stdリザルトファイルパスを指定する String です。

この入力は必須です。

iImportType​

インポートタイプを指定する Integer です。STDFileの場合、常に1に設定されています。

デフォルト値は1です。

dFaceAngle​

フェース分割を決定するための角度許容差を指定する Double 型です（指定値より小さい角度を持つ隣接要素間にエッジを作成します）。

デフォルト値は60.0度です。

dEdgeAngle​

エッジ分割を決定するための角度許容差を指定する Double 型です（指定値より大きい角度を持つ隣接エッジ要素に頂点を作成します）。

デフォルト値は60.0度です。

戻り値​

関数が正常に実行されたかどうかを指定する Boolean 型です：

True: STDファイル（*.stdファイル）が正常にインポートされました。

False: STDファイル（*.stdファイル）をインポートできませんでした。

サンプルコード​

#サンプルstdファイルへのパスを設定してください。
filepath="C:/Temp/Sample.std"

Home.ImportResults.STDFile(filepath)
