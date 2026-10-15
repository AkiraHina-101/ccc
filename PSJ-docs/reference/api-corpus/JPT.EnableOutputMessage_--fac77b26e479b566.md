# JPT.EnableOutputMessage()

JPT.EnableOutputMessage()

説明​

Python APIウィンドウに書き込まれる出力メッセージを有効にします。

このユーティリティは、JPT.DisableOutputMessage() ユーティリティを使用した後にPython APIウィンドウで出力メッセージを有効にするために使用されます。

構文​

JPT.EnableOutputMessage()

入力​

このユーティリティ関数には入力値は必要ありません。

戻り値​

このユーティリティ関数には出力値はありません。

サンプルコード​

# 画面アニメーションを無効にする
JPT.DisableOutputMessage()

# 出力メッセージのテストのために文字列を表示
# Python APIウィンドウ上に
# この文字列はPython APIウィンドウ上に表示されません
print("テスト")

# JPT.DisableOutputMessage() を使用した後に
# Python APIウィンドウで出力メッセージを有効にする
JPT.EnableOutputMessage()

# 出力メッセージのテストのために文字列を表示
# Python APIウィンドウ上に
# この文字列はPython APIウィンドウ上に表示されます
print("テスト")
