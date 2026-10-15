# Convert unit

Convert unit

🎯 Introduction​

In this tutorial, you'll learn how to convert unit between user GUI and PSJ-Command/macro:

Use JPT.ConvertFromDocUnit() to convert the inputted value from the current Jupiter unit system to SI[m] unit (Jupiter macro unit)).

Use JPT.ConvertFromMacroUnit() to convert the inputted value from the specified unit to the SI[m] unit (Jupiter macro unit).

Use JPT.ConvertValueToDocUnit() to convert the inputted value from SI[m] units (Jupiter macro units) to the current Jupiter unit system.

Use JPT.ConvertValueToMacroUnit() to convert the inputted value from the SI[m] unit (Jupiter macro unit) to the specified unit.

📖 Tutorial​

# Clear the log message in Python API window
JPT.ClearLog()

# Set input value
inputValue = 1

# Convert input value from the current Jupiter unit to Jupiter macro unit (SI[m] unit)
# To check current Jupiter unit, refer Home -> Preferences -> Unit -> Current Unit
frDoc_toMacro  = JPT.ConvertFromDocUnit(inputValue, JPT.UnitType.Unit_Length)
print("From current Jupiter unit system: {} -> To Jupiter macro unit (SI[m]): {}"
    .format(inputValue, frDoc_toMacro))

# Convert input value from the specified unit to Jupiter macro unit (SI[m] unit)
frSpeci_toMacro = JPT.ConvertFromMacroUnit(inputValue, JPT.UnitType.Unit_Length, "mm")
print("From specified unit 'mm': {} -> To Jupiter macro unit (SI[m]): {}"
    .format(inputValue, frSpeci_toMacro))

# Convert input value from Jupiter macro unit (SI[m] unit) to the current Jupiter unit
frMacro_toDoc = JPT.ConvertValueToDocUnit(inputValue, JPT.UnitType.Unit_Length)
print("From Jupiter macro unit (SI[m]): {} -> To current Jupiter unit: {}"
    .format(inputValue, frMacro_toDoc))

# Convert input value from Jupiter macro unit (SI[m] unit) to the specified unit 'mm'
frMacro_toSpeci = JPT.ConvertValueToMacroUnit(inputValue, JPT.UnitType.Unit_Length, "mm")
print("From Jupiter macro unit (SI[m]): {} -> To specified unit 'mm': {}"
    .format(inputValue, frMacro_toSpeci))
