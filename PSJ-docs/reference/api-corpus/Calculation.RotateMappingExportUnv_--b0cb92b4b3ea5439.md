# Calculation.RotateMappingExportUnv()

Calculation.RotateMappingExportUnv()

説明​

マッピングされた結果をファイルに保存します（*unv）。

構文​

Calculation.RotateMappingExportUnv(...)

マクロ：

リボン：Calculation » RotateMappingExportUnv

入力​

strPath​

保存する*unvファイルのパスを指定する String です。

これは必須の入力です。

veclResultSet​

エクスポートする結果の属性を指定する Vector のリストです。

これは必須の入力です。

ilComponentUnv​

ユニバーサルコンポーネントを指定する Integer のリストです。

デフォルト値は [0, 2, 5, 1, 4, 3] です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean です：

True: プロセスが正常に実行されました。

False: 関数を実行できません。

サンプルコード​

# サンプルのユニバーサルファイルとエクスポートファイルのパスを設定してください。
filePath="C:/Temp/Sample.unv"
exportPath = "C:/Temp/Unv_Export.unv"

# 結果ファイルをインポート
Home.ImportResults.Universal(filePath)

# マッピングを回転
Calculation.RotateMapping(dAngleInterval=90.0, iRotateAxis=1, crTarget=Part(1))
# Unvファイルをエクスポート
Calculation.RotateMappingExportUnv(strPath=exportPath, 
                                    veclResultSet=[[105, 1001, 0], [105, 1001, 1], [105, 1001, 2], [105, 1001, 3]], 
                                    ilComponentUnv=[0, 2, 5, 1, 4, 3])
