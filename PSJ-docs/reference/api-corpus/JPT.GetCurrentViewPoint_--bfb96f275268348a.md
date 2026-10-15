# JPT.GetCurrentViewPoint()

JPT.GetCurrentViewPoint()

説明​

ビューポイントのすべての現在の設定を取得します。

構文​

JPT.GetCurrentViewPoint()

入力​

このユーティリティ関数には入力値は必要ありません。

戻り値​

現在表示されているビューポイントのすべての設定を指定する Dictionary。

サンプルコード​

# ビューポイントの現在のすべての設定を取得
viewDict = JPT.GetCurrentViewPoint()

# 結果をダンプ
pprint(viewDict)

# スケールファクターを出力
print("スケールファクター: " + str(viewDict["ScaleFactor"]))
