# JPT.ConvertValueToDocUnit()

JPT.ConvertValueToDocUnit()

説明​

SI[m] 単位（Jupiter マクロ単位）から現在の Jupiter ユニットシステムに入力された値を変換します。

構文​

JPT.ConvertValueToDocUnit(inputValue, unitType)

入力​

inputValue​

変換に使用される Double です。

この入力は必須です。

unitType​

変換の参照として使用される Unit Types を指定する Enum です。

ユニットの種類は Jupiter の Home » Preference » Unit で確認できます。

この入力は必須です。

戻り値​

変換された値を指定する Double です。

サンプルコード​

# 1m を Jupiter マクロ単位系から現在の Jupiter ユニットシステムに変換
convertToDoc = JPT.ConvertValueToDocUnit(1, JPT.UnitType.Unit_Length)
JPT.Debugger(convertToDoc)
