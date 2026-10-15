# Tools.RenumberByFile()

Tools.RenumberByFile()

説明​

モデルをCSVファイルで再番号付けします。再番号付けの対象は、節点、2D要素、3D要素です。

構文​

Tools.RenumberByFile(...)

リボン: Tools » RenumberByFile

入力​

strCSVPath​

CSVファイルのパスを指定する String です。CSVファイルはモデルと正確に対応しており、異なるモデルに異なるCSVを使用することはできません。

この入力は必須です。

iConflictStrategy​

衝突解決戦略を指定する Integer です。このパラメータは、共有フェイス/節点の場合に適用され、再番号付け時にフェイス/節点のIDがどの部分に属するかを選択するために使用されます。

もし iConflictStrategy=0 なら: IDが小さい方(<）メソッド。モデルに共有フェイス/節点が存在する場合、再番号付け時のそれらのIDは、IDがより小さい部分に属します。

もし iConflictStrategy=1 なら: IDが大きい方(<）メソッド。モデルに共有フェイス/節点が存在する場合、再番号付け時のそれらのIDは、IDがより大きい部分に属します。

デフォルト値は0です。

bNeedToUpdateCount​

各コンポーネント（節点、2D、3D）ごとのカウンター更新を有効にするオプションを指定する Boolean です。カウンターは、各コンポーネントの合計量を表す値です。

もし True なら: カウンターが更新されます

もし False なら: カウンターは更新されません

デフォルト値は False です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean 型です:

True: プロセスが正常に実行されました。

False: 関数が実行できません。

サンプルコード​

jpt_path = JPT.GetAppPathInfo((JPT.PathType.PROGRAM_PATH))

sample_model = jpt_path + 'SampleData\\PSJ\\PSJ-Utility\\JtdbSample\\RenumberByFile.jth5'
sample_csv = jpt_path + 'SampleData\\PSJ\\PSJ-Utility\\Utils\\RenumberByFile.csv'

#モデルをインポート
FileMenu.LoadJTH5(sample_model)
JPT.ViewFitToModel()

result = Tools.RenumberByFile(strCSVPath = sample_csv)
JPT.Debugger(result)
