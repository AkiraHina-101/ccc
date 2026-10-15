# Home.ImportResults.Ansys()

Home.ImportResults.Ansys()

説明​

Ansysの結果ファイルをインポートします。

構文​

Home.ImportResults.Ansys(...)

マクロ: ImportAnsysResult

リボン: Home » ImportResults » Ansys

入力​

strPath​

Ansysの結果ファイルのパスを指定する String です。

この入力は必須です。

iImportType​

インポートタイプを指定する Integer です。

デフォルト値は1です。

dFaceAngle​

フェース分割を決定するための角度許容度を指定する Double 型です（指定された値より小さい角度の隣接要素の間にエッジを作成します）。

デフォルト値は60.0度です。

dEdgeAngle​

エッジ分割を決定するための角度許容度を指定する Double 型です（指定された値より大きい角度の隣接エッジ要素に頂点を作成します）。

デフォルト値は60.0度です。

戻り値​

関数が正常に実行されたかどうかを指定する Boolean 型です：

True: Abaqusファイル（*.rstファイル）が正常にインポートされました。

False: Abaqusファイル（*.rstファイル）をインポートできません。

サンプルコード​

#サンプルのAbaqusファイルへのパスを設定してください。
filepath="C:/Temp/Sample.rst"

Home.ImportResults.Ansys(filepath)
