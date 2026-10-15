# JPT.GetCurrentDiagram()

JPT.GetCurrentDiagram()

説明​

ダイアグラムのすべての現在の設定を取得します。

構文​

JPT.GetCurrentDiagram()

入力​

このユーティリティ関数には入力値は必要ありません。

戻り値​

現在表示されているダイアグラムのすべての設定を指定する Dictionary。

サンプルコード​

# ダイアグラムのすべての現在の設定を取得
diagramDict = JPT.GetCurrentDiagram()

# 結果をダンプ
pprint(diagramDict)

# ポジティブカラーを出力
colorRGB = JPT.ConvertJPTColorToRGB(diagramDict["PositiveColor"])
print("Positive Color: " + colorRGB)
