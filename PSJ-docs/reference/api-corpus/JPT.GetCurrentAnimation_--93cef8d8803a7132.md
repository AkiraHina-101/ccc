# JPT.GetCurrentAnimation()

JPT.GetCurrentAnimation()

説明​

アニメーションのすべての現在の設定を取得します。

構文​

JPT.GetCurrentAnimation()

入力​

このユーティリティ関数には入力値は必要ありません。

戻り値​

アニメーションのすべての現在の設定を指定する Dictionary です。

サンプルコード​

# アニメーションの現在のすべての設定を取得
animationDict = JPT.GetCurrentAnimation()

# 結果を出力
pprint(animationDict)

# フレーム番号を表示
print("フレーム番号: " + str(animationDict["FrameNumber"]))
