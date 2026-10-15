# JPT.GetMacroLog()

JPT.GetMacroLog()

Description​

Get the current text existing on the Macro window.

Syntax​

JPT.GetMacroLog()

Inputs​

This utility function does not require any input value.

Return Code​

A String containing all the existing text on the Macro window.

Sample Code​

# Do some operations, such as open a dialog of a function or
# creating something to store its macro to the Macro window
# In case the Macro dialog is blanked, its returning value is ""
# Get the stored macro on the Macro window
storedMacro = JPT.GetMacroLog()
JPT.Debugger(storedMacro)
