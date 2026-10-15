# JPT.SetSelectMethod()

JPT.SetSelectMethod()

説明​

Jupiterの選択方法を指定されたものに変更します。

構文​

JPT.SetSelectMethod(selectMethodType)

入力​

selectMethodType​

選択方法を記述する SelectMethodType を指定する Enum。

この入力は必須です。

戻り値​

このユーティリティ関数には出力値がありません。

サンプルコード​

#  パート選択への選択方法
JPT.SetSelectMethod(JPT.SelectMethodType.SELMTD_BODY)

# フェース選択への選択方法
JPT.SetSelectMethod(JPT.SelectMethodType.SELMTD_FACE)

# エッジ選択への選択方法
JPT.SetSelectMethod(JPT.SelectMethodType.SELMTD_EDGE)

# 節点選択への選択方法
JPT.SetSelectMethod(JPT.SelectMethodType.SELMTD_NODE)
