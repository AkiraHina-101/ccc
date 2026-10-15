# JPT.GetCurrentContour()

JPT.GetCurrentContour()

説明​

現在のContourのすべての設定を取得します。

構文​

JPT.GetCurrentContour()

入力​

このユーティリティ関数には入力値は必要ありません。

戻り値​

現在表示されているContourのすべての設定を指定する Dictionary。

サンプルコード​

# 現在のContourのすべての設定を取得
contourDict = JPT.GetCurrentContour()

# 結果を表示
pprint(contourDict)

# 上側の色を表示
colorRGB = JPT.ConvertJPTColorToRGB(contourDict["UpperColor"])
print("上側の色：" + colorRGB)
