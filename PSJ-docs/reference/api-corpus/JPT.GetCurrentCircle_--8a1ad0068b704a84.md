# JPT.GetCurrentCircle()

JPT.GetCurrentCircle()

説明​

円の現在のすべての設定を取得します。

構文​

JPT.GetCurrentCircle()

入力​

このユーティリティ関数には入力値は必要ありません。

戻り値​

現在表示されている円のすべての設定を指定する Dictionary。

サンプルコード​

# 現在の円のすべての設定を取得
circleDict = JPT.GetCurrentCircle()

# 結果を出力
pprint(circleDict)

# ハイライトカラーを表示
colorRGB = JPT.ConvertJPTColorToRGB(circleDict["HighlightColor"])
print("ハイライトカラー: " + colorRGB)
