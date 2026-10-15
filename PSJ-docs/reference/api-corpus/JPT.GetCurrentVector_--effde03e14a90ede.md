# JPT.GetCurrentVector()

JPT.GetCurrentVector()

説明​

Vectorのすべての現在の設定を取得します。

構文​

JPT.GetCurrentVector()

入力​

このユーティリティ関数には入力値は必要ありません。

戻り値​

現在表示されているVectorのすべての設定を指定する Dictionary です。

サンプルコード​

# 現在のVectorのすべての設定を取得
vectorDict = JPT.GetCurrentVector()

# 結果の表示
pprint(vectorDict)

# Positiveカラーの表示
colorRGB = JPT.ConvertJPTColorToRGB(vectorDict["PositiveColor"])
print("Positive Color: " + colorRGB)
