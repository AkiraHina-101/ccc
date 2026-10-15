# JPT.ConvertFromMacroUnit()

JPT.ConvertFromMacroUnit()

Description​

Convert the inputted value with the specified unit to the SI[m] unit (Jupiter macro unit).
The return value will be the value after the conversion.

Syntax​

JPT.ConvertFromMacroUnit(inputValue, unitType, outputValueType)

Inputs​

inputValue​

A Double which will be used for converting.

This is a required input.

unitType​

An Enum specifying the Unit Types which will be used as the reference for converting.

The type of unit can be found at: Home » Preference » Unit in Jupiter.

This is a required input.

outputValueType​

A String specifying the indicated unit of the inputted value which will be used for converting to Jupiter macro unit.

This is a required input.

Return Code​

A Double specifying the converted value.

Sample Code​

# Convert 1mm to the Jupiter macro unit system
convertFromMacro = JPT.ConvertFromMacroUnit(1, JPT.UnitType.Unit_Length, 'mm') # mm -> m
JPT.Debugger(convertFromMacro) # 0.001 m
