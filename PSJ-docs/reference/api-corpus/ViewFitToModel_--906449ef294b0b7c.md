# ViewFitToModel()

ViewFitToModel()

説明​

現在の画面にモデルをフィットさせます。

構文​

View Fit To Model()

入力​

この関数には入力値は必要ありません。

戻り値​

このユーティリティ関数には出力値がありません。

注意​

このコマンドをPSJコード内で使用すると、アニメーションのために画面更新関数によって想定と異なる状態になる場合があります。そのような場合は、アニメーションを停止し、最後のフレームのみを表示するために DisableScreenAnimation() を使用してください。

サンプルコード​

# 無効化された画面アニメーションを使用したpsjの使用法
Geometry.Part.Cube()
JPT.DisableScreenAnimation()
JPT.Exec("View Fit To Model()")
JPT.Exec("ViewPoint(4)")
