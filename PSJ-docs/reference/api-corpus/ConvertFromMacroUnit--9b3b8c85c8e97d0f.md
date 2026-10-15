# ConvertFromMacroUnit

ConvertFromMacroUnit ConvertFromMacroUnit Description Convert unit system from user input unit to macro SI unit Syntax ConvertFromMacroUnit(float inputValue, enum UnitType, string strUnit) Inputs Float Conversion source value Enum Unit system conversion type String Unit abbreviation Return Code Python Output float Converted value Sample Code Input: convFromMacr = JPT.ConvertFromMacroUnit(1, JPT.UnitType.Unit_Length, 'mm') print(str(convFromMacr)) Output: > 0.001
