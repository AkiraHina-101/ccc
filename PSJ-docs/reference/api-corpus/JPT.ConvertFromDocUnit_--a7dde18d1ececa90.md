# JPT.ConvertFromDocUnit()

JPT.ConvertFromDocUnit()

Description​

Convert the inputted value from the current using Jupiter unit system to SI[m] unit (Jupiter macro unit).
The return value will be the value after the conversion.

Syntax​

JPT.ConvertFromDocUnit(inputValue, unitType)

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

# Convert the value = 1 from the current Jupiter Unit system to Jupiter macro unit system
convertFromDoc = JPT.ConvertFromDocUnit(1, JPT.UnitType.Unit_Length)
JPT.Debugger(convertFromDoc)
