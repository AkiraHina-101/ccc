# Home.ImportResults.Radioss()

Home.ImportResults.Radioss()

説明​

Open Radioss 結果ファイルをインポートします。

構文​

Home.ImportResults.Radioss(...)

マクロ：ImportRadioss

リボン：Home » ImportResults » Radioss

入力​

strlPaths​

Open Radioss 結果ファイルのパスを指定する String のリスト。

これは必須の入力です。

iImportType​

インポートタイプを指定する Integer です。

デフォルト値は 1 です。

dFaceAngle​

フェース分割を決定するための角度許容度を指定する Double。

（指定された値よりも小さい角度で隣接する要素間にエッジを作成することで）

デフォルト値は 60.0（度）です。

dEdgeAngle​

エッジ分割を決定するための角度許容度を指定する Double。

（指定された値よりも大きい角度で隣接するエッジ要素に頂点を作成することで）

デフォルト値は 60.0（度）です。

bReadLoadAndConstraint​

読み込むかどうかを指定する Boolean。

デフォルト値は False です。

bReadConnection​

読み込むかどうかを指定する Boolean。

デフォルト値は False です。

bCreateResultsAtMidNode​

Mid Node で結果を作成するかどうかを指定する Boolean。

デフォルト値は False です。

戻り値​

関数が正常に実行されたかどうかを指定する Boolean:

True: Open Radioss ファイルが正常にインポートされました。

False: Open Radioss をインポートできませんでした。

サンプルコード​

<Type here>
