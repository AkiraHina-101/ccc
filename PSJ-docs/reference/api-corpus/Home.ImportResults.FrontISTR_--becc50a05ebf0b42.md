# Home.ImportResults.FrontISTR()

Home.ImportResults.FrontISTR()

説明​

FrontISTR 結果ファイルをインポートします。

構文​

Home.ImportResults.FrontISTR(...)

マクロ: ImportFrontISTR

リボン: Home » ImportResults » FrontISTR

入力​

strPath​

FrontISTR 結果フォルダーのパスを指定する String です。

この入力は必須です。

iImportType​

インポートタイプを指定する Integer です。

デフォルト値は 1 です。

dFaceAngle​

フェース分割を決定するための角度許容度を指定する Double 型です（指定値よりも小さい角度の隣接要素間にエッジを作成することにより）。

デフォルト値は 60.0 度です。

dEdgeAngle​

エッジ分割を決定するための角度許容度を指定する Double 型です（指定値よりも大きい角度の隣接エッジ要素に頂点を作成することにより）。

デフォルト値は 60.0 度です。

戻り値​

関数の実行が成功したかどうかを指定する Boolean 型です：

True: FrontISTR ファイルが正常にインポートされました。

False: FrontISTR ファイルをインポートできません。

サンプルコード​

#サンプル FrontISTR フォルダーへのパスを設定してください。
folderpath="C:/Temp/SampleFrontISTR"

Home.ImportResults.FrontISTR(folderpath)
