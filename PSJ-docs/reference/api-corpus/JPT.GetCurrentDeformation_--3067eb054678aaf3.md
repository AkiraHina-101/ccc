# JPT.GetCurrentDeformation()

JPT.GetCurrentDeformation()

説明​

変形の現在のすべての設定を取得します。

構文​

JPT.GetCurrentDeformation()

入力​

このユーティリティ関数には入力値は必要ありません。

戻り値​

現在表示されている変形のすべての設定を指定する Dictionary です。

サンプルコード​

# 変形のすべての現在の設定を取得する
deformDict = JPT.GetCurrentDeformation()

# 結果を表示する
pprint(deformDict)

# エッジの色を表示する
colorRGB = JPT.ConvertJPTColorToRGB(deformDict["EdgeColor"])
print("エッジの色: " + colorRGB)
