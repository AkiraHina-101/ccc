# JPT.ConvertFromMacroUnit()

JPT.ConvertFromMacroUnit()

説明​

指定された単位の入力値をSI[m]単位（Jupiter マクロ単位）に変換します。
戻り値は変換後の値です。

構文​

JPT.ConvertFromMacroUnit(inputValue, unitType, outputValueType)

入力​

inputValue​

変換に使用される Double。

これは必須入力です。

unitType​

変換の参照として使用される Unit Types を指定する Enum。

単位の種類は Jupiter の Home » Preference » Unit で見つけることができます。

これは必須入力です。

outputValueType​

変換対象の入力値の単位を Jupiter マクロ単位に変換する際に指定する String。

これは必須入力です。

戻り値​

変換された値を指定する Double。

サンプルコード​

# 1mm を Jupiter マクロ単位系に変換
convertFromMacro = JPT.ConvertFromMacroUnit(1, JPT.UnitType.Unit_Length, 'mm') # mm -> m
JPT.Debugger(convertFromMacro) # 0.001 m
