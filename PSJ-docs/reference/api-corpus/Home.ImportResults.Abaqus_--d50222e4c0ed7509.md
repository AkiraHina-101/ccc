# Home.ImportResults.Abaqus()

Home.ImportResults.Abaqus()

説明​

Abaqusの結果ファイルをインポートします。

構文​

Home.ImportResults.Abaqus(...)

マクロ: ImportAbaqus

リボン: Home » ImportResults » Abaqus

入力​

strPath​

Abaqus結果ファイルへのパスを指定する String です。

この入力は必須です。

iVersion​

インポートするAbaqusファイルのバージョンを指定する Integer です。

この入力は必須です。

iImportType​

インポートタイプを指定する Integer です：

デフォルト値は1です。

dFaceAngle​

フェース分割を決定するための角度許容度を指定する Double 型です（指定された値より小さい角度で隣接要素間にエッジを作成します）。

デフォルト値は60.0（度）です。

dEdgeAngle​

エッジ分割を決定するための角度許容度を指定する Double 型です（指定された値より大きい角度で隣接エッジ要素上に頂点を作成します）。

デフォルト値は60.0（度）です。

戻り値​

関数の実行が成功したかどうかを指定する Boolean 型です：

True: Abaqusファイル（*.odbファイル）が正常にインポートされました。

False: Abaqusファイル（*.odbファイル）をインポートできませんでした。

サンプルコード​

#サンプルAbaqusファイルへのパスを設定してください。
filepath="C:/Temp/Sample.odb"

Home.ImportResults.Abaqus(filepath, iVersion=2023)
