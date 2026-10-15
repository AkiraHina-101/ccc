# ConvertValueToDocUnit

ConvertValueToDocUnit ConvertValueToDocUnit Description Convert value from SI unit system to JPT user setup unit Syntax ConvertValueToDocUnit(float inputValue, enum UnitTypeunit) Inputs Float Conversion source value Enum Unit system conversion type Return Code Python Output float Converted value Sample Code Input: convToDoc = JPT.ConvertValueToDocUnit(1, JPT.UnitType.Unit_Length) print(str(convToDoc)) Output: > 1000.0
