# Execute and get return value from macro

Execute and get return value from macro

🎯 Introduction​

In this tutorial, you'll learn how to execute macro and get return value from macro:

Execute a macro to check Stretch quality of triangle element of cube by JPT.Exec('macro').

Check return value from macro (return value of macro is a String).

Create a String Vector (List of String) containing parser pattern (refer Parse macro result for more information).

Parse return value from macro to obtain each data value as List of String.

📖 Tutorial​

# Clear the log message in Python API window
JPT.ClearLog()

# Create a cube
Geometry.Part.Cube(strName="Cube_1", iPartColor=12999622)

# Execute a macro to check Stretch quality metric of triangle element by JPT.Exec('macro')
# Get string return value from macro. Assign to variable 'resultMacro'
resultMacro = JPT.Exec('MC_Mesh_Quality_Manual_Check_Tri([3:1], 0, 0, 0.1)')

# Check string return value from macro
print(resultMacro)

# Create a String Vector containing parser pattern. Example: "number", "list_cursor"
# Refer tutorial 'Macro result parser' to learn more about string data rules of parser pattern
ArgPatterns = JPT.StringVector()
ArgPatterns.append("number")
ArgPatterns.append("number")
ArgPatterns.append("number")
ArgPatterns.append("number")
ArgPatterns.append("number")
ArgPatterns.append("number")
ArgPatterns.append("list_cursor")
ArgPatterns.append("list_cursor")

# Parse string return value from macro to obtain each data value as List of String
listArgs = JPT.MacroResultParser(resultMacro, ArgPatterns)
JPT.Debugger(listArgs)

macroResult = listArgs[0]
MinValue = listArgs[1]
MaxValue = listArgs[2]
AvgValue = listArgs[3]
TotalEntities = listArgs[4]
NumberFailedElements = listArgs[5]
ListFailedElems = listArgs[6]
ListFailedElemEdges = listArgs[7]
