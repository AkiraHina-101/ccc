# JPT.ConvertFromDocUnit()

JPT.ConvertFromDocUnit()

説明​

入力された値を、現在のJupiterユニットシステムからSI[m]ユニット（Jupiterマクロユニット）に変換します。
変換後の値が返されます。

構文​

JPT.ConvertFromDocUnit(inputValue, unitType)

入力​

inputValue​

変換に使用される Double 型の値です。

この入力は必須です。

unitType​

変換の参照として使用される Unit Types を指定する Enum です。

ユニットのタイプはJupiterのHome » Preference » Unitで見つけることができます。

この入力は必須です。

戻り値​

変換された値を指定する Double です。

サンプルコード​

# 現在のJupiterユニットシステムからJupiterマクロユニットシステムに値 = 1 を変換する
convertFromDoc = JPT.ConvertFromDocUnit(1, JPT.UnitType.Unit_Length)
JPT.Debugger(convertFromDoc)
