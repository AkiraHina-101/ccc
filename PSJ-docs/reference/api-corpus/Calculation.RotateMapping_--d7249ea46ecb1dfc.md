# Calculation.RotateMapping()

Calculation.RotateMapping()

説明​

回転方向に連続した応力データを作成するために、ストレス（応力）をマッピングしてコピーします。

構文​

Calculation.RotateMapping(...)

マクロ: PostRotateMapping

リボン: Calculation » RotateMapping

入力​

dAngleInterval​

角度を度で指定する Double です。

デフォルト値は 7.5 です。

iRotateAxis​

回転軸の選択を指定する Integer です。

デフォルト値は 3 です。

iCoordinate​

座標参照を指定する Integer です。

デフォルト値は 0 です。

iInterpolateType​

マッピング時の補間タイプを指定する Integer です。

0: 最も近い節点補間

1: 要素内補間

デフォルト値は 1 です。

dAreaTolerance​

面積許容値を指定する Double です。

デフォルト値は 1 です。

dMeshTolerance​

メッシュ許容値の値を指定する Double です。

デフォルト値は 0.05 です。

iRegionType​

結果をマッピングする領域タイプを指定する Integer です。

0: パートごとに

1: グループごとに

デフォルト値は 0 です。

crTarget​

結果をマッピングする対象を指定する Cursor です。 RegionType = パートごとの場合はパート、RegionType = グループの場合はソリッド要素が対象となります。

この入力は必須です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean です：

True: プロセスが正常に実行されました。

False: 関数を実行できません。

サンプルコード​

# サンプルユニバーサルファイルとエクスポートファイルへのパスを設定してください。
filePath="C:/Temp/Sample.unv"
exportPath = "C:/Temp/Unv_Export.unv"

# 結果ファイルのインポート
Home.ImportResults.Universal(filePath)

# 回転マッピング
Calculation.RotateMapping(dAngleInterval=90.0, iRotateAxis=1, crTarget=Part(1))
# Unv ファイルのエクスポート
Calculation.RotateMappingExportUnv(strPath=exportPath, 
                                    veclResultSet=[[105, 1001, 0], [105, 1001, 1], [105, 1001, 2], [105, 1001, 3]], 
                                    ilComponentUnv=[0, 2, 5, 1, 4, 3])
