# ConvertFromDocUnit

ConvertFromDocUnit ConvertFromDocUnit Description Converts units in the document to SI[m] units (Jupiter macro units). The return value will be the value after conversion. Syntax ConvertFromDocUnit(float inputValue, enum UnitType) Inputs Float Conversion source value Enum Unit system conversion type Return Code Python Output float Converted Value Sample Code Input: convFromDoc = JPT.ConvertFromDocUnit(1, JPT.UnitType.Unit_Length) print(str(convFromDoc)) Output: > 0.001
