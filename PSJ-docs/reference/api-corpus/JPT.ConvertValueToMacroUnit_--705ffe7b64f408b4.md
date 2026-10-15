# JPT.ConvertValueToMacroUnit()

JPT.ConvertValueToMacroUnit()

Description​

Convert the inputted value from the SI[m] unit (Jupiter macro unit) to the specified unit.
The return value will be the value after conversion.

Syntax​

JPT.ConvertValueToMacroUnit(inputValue, unitType, outputValueType)

Inputs​

inputValue​

A Double which will be used for converting.

This is a required input.

unitType​

An Enum specifying the Unit Types which will be used as the reference for converting.

The type of unit can be found at: Home » Preference » Unit in Jupiter.

This is a required input.

outputValueType​

A String specifying the desired unit of the inputted value which will be got after converting from Jupiter macro unit.

This is a required input.

Return Code​

A Double specifying the converted value.

Sample Code​

# Convert 1m from Jupiter macro unit system to mm
convertToMacro = JPT.ConvertValueToMacroUnit(1, JPT.UnitType.Unit_Length, 'mm') # 1m -> mm
JPT.Debugger(convertToMacro) # 1000
