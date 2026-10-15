# JPT.ConvertValueToDocUnit()

JPT.ConvertValueToDocUnit()

Description​

Convert the inputted value from SI[m] units (Jupiter macro units) to the current Jupiter unit system.

Syntax​

JPT.ConvertValueToDocUnit(inputValue, unitType)

Inputs​

inputValue​

A Double which will be used for converting.

This is a required input.

unitType​

An Enum specifying the Unit Types which will be used as the reference for converting.

The type of unit can be found at: Home » Preference » Unit in Jupiter.

This is a required input.

Return Code​

A Double specifying the converted value.

Sample Code​

# Convert 1m in Jupiter macro unit system to the current unit system of Jupiter
convertToDoc = JPT.ConvertValueToDocUnit(1, JPT.UnitType.Unit_Length)
JPT.Debugger(convertToDoc)
