# JPT.GetOpnList()

JPT.GetOpnList()

Description​

Get a List of String stores name of functions having their own GUI.

Syntax​

JPT.GetOpnList()

Inputs​

This utility function does not require any input value.

Return Code​

A StringVector specifying the functions having their own GUI.

Sample Code​

# Get all the functions having their own GUI
allFuncsWithGUI = JPT.GetOpnList()
JPT.Debugger(allFuncsWithGUI)
JPT.Debugger(allFuncsWithGUI[3])
