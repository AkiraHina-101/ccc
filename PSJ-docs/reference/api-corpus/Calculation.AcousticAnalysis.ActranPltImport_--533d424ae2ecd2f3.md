# Calculation.AcousticAnalysis.ActranPltImport()

Calculation.AcousticAnalysis.ActranPltImport()

説明​

音圧と粒子速度の結果から強度を作成します。

構文​

Calculation.AcousticAnalysis.ActranPltImport(...)

マクロ: PostImportActranPlt

リボン: Calculation » AcousticAnalysis » ActranPltImport

入力​

strPath​

インポートする Actran (*.plt) ファイルを指定する String 。

この入力は必須です。

戻り値​

処理が正常に実行されたかどうかを指定する Boolean 型。

True: 処理が正常に実行されました。

False: 関数を実行できません。

サンプルコード​

#サンプル actran ファイルへのパスを設定してください。
filePath="C:/Temp/Sample.plt"

Calculation.AcousticAnalysis.ActranPltImport(strPath=filePath)
