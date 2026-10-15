# JPT.ListDoubleToMacroVector()

JPT.ListDoubleToMacroVector()

説明​

3つの Double 値の List をVector3Dに変換します（マクロ文字列型）。

構文​

JPT.ListDoubleToMacroVector(doubleValue1, doubleValue2, doubleValue3)

入力​

doubleValue1​

変換に使用される最初の値を指定する Double です。

これは必須入力です。

doubleValue2​

変換に使用される2番目の値を指定する Double です。

これは必須入力です。

doubleValue3​

変換に使用される3番目の値を指定する Double です。

これは必須入力です。

戻り値​

変換されたVector3D（マクロ文字列型）を指定する String です。

サンプルコード​

# 3つの double 値のリストを vector3d（マクロ文字列型）に変換
inputValue1 = 0.001
inputValue2 = 2.1
inputValue3 = 5.5
# 値 = [0.001,2.1,5.5] で文字列オブジェクトを返す
JPT.Debugger(JPT.ListDoubleToMacroVector(inputValue1, inputValue2, inputValue3))
