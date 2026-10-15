# Home.ImportResults.Marc()

Home.ImportResults.Marc()

説明​

Marc 結果ファイルをインポートします。

構文​

Home.ImportResults.Marc(...)

マクロ: ImportMarc

リボン: Home » ImportResults » Marc

入力​

strPath​

Marc 結果ファイルへのパスを指定する String です。

これは必須の入力です。

iImportType​

インポートタイプを指定する Integer です：

デフォルト値は 1 です。

dFaceAngle​

フェースの分割を決定するための角度許容度を指定する Double 型です（指定された値より小さい角度の隣接要素間にエッジを作成します）。

デフォルト値は 60.0（度）です。

dEdgeAngle​

エッジの分割を決定するための角度許容度を指定する Double 型です（指定された値より大きい角度の隣接エッジ要素に頂点を作成します）。

デフォルト値は 60.0（度）です。

戻り値​

関数が正常に実行されたかどうかを指定する Boolean 型です：

True: Marc 結果が正常にインポートされました。

False: Marc 結果をインポートできません。

サンプルコード​

#サンプル marc ファイルへのパスを設定してください。
filepath="C:/Temp/Sample.t16"

Home.ImportResults.Marc(filepath)
