# Home.ImportResults.OptishapeTS()

Home.ImportResults.OptishapeTS()

説明​

Optishape-TS の結果ファイルをインポートします。

構文​

Home.ImportResults.OptishapeTS(...)

マクロ: ImportOptishapeTS

リボン: Home » ImportResults » OptishapeTS

入力​

strlPaths​

Optishape-TS の結果ファイルパスを指定する String のリストです。

この入力は必須です。

iImportType​

インポートタイプを指定する Integer です。Optishape-TS の場合、常に1に設定されます。

デフォルト値は1です。

dFaceAngle​

フェースの分割を決定するための角度許容度を指定する Double 型です（指定された値よりも小さい角度で隣接要素の間にエッジを作成することによって）。

デフォルト値は60.0 度です。

dEdgeAngle​

エッジの分割を決定するための角度許容度を指定する Double 型です（指定された値よりも大きい角度で隣接エッジ要素に頂点を作成することによって）。

デフォルト値は60.0 度です。

戻り値​

関数が正常に実行されたかどうかを指定する Boolean 型です：

True: Optishape ファイルが正常にインポートされました。

False: Optishape ファイルをインポートできませんでした。

サンプルコード​

import os
#結果のデータを入力してください
result_data='C:/Temp/OptiShapeResult'

Home.ImportResults.OptishapeTS(
    strlPaths=[os.path.join(result_data,"sample.op2")])
