# JPT.GetCurrentCrossSection()

JPT.GetCurrentCrossSection()

説明​

クロスセクションの現在のすべての設定を取得します。

構文​

JPT.GetCurrentCrossSection()

入力​

このユーティリティ関数には入力値は必要ありません。

戻り値​

現在表示されているクロスセクションのすべての設定を指定する Dictionary。

サンプルコード​

# 現在のクロスセクションのすべての設定を取得
crossDict = JPT.GetCurrentCrossSection()

# 結果を出力
pprint(crossDict)

# 現在の位置を出力
print("現在の位置：" + str(crossDict["CurrentPosition"]))
