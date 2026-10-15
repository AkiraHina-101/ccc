# ConvertValueToMacroUnit

ConvertValueToMacroUnit ConvertValueToMacroUnit Description Convert unit system from macro SI unit to user input unit Syntax ConvertValueToMacroUnit(float inputValue, enum UnitType, string strUnit) Inputs Float Conversion source value Enum Unit system conversion type String Unit abbreviation Return Code Python Output float Converted value Sample Code Input: convToMacr = JPT.ConvertValueToMacroUnit(1, JPT.UnitType.Unit_Length, 'mm') print(str(convToMacr)) Output: > 1000.0
