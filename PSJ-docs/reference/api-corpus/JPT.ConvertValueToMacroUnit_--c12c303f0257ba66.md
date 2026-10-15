# JPT.ConvertValueToMacroUnit()

JPT.ConvertValueToMacroUnit()

説明​

SI[m]単位（Jupiterマクロ単位）から指定された単位への値を変換します。
変換後の値が返されます。

構文​

JPT.ConvertValueToMacroUnit(inputValue, unitType, outputValueType)

入力​

inputValue​

変換に使用される Double 型の値です。

これは必須の入力です。

unitType​

変換の参照として使用される Unit Types を指定する Enum です。

JupiterのHome » Preference » Unitに単位の種類があります。

これは必須の入力です。

outputValueType​

Jupiterマクロ単位から変換後に取得される入力値の希望単位を指定する String です。

これは必須の入力です。

戻り値​

変換された値を指定する Double です。

サンプルコード​

# Jupiterマクロ単位システムから1mをmmに変換
convertToMacro = JPT.ConvertValueToMacroUnit(1, JPT.UnitType.Unit_Length, 'mm') # 1m -> mm
JPT.Debugger(convertToMacro) # 1000
