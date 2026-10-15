# Get output, macro and Python log

Get output, macro and Python log

🎯 Introduction​

In this tutorial, you'll learn how to get log from Output window, Macro window and Python API window:

Get log content at Macro window.
Then create a macro file .jpl to save Macro log content.

Get log content at Python API window.
Then create a file .log to save Python API log content.

Get log content at Output window.
Then create a file .log to save Output log content.

📖 Tutorial​

# Get log content at Macro window
# Create a macro file .jpl to save Macro log content
logMacro = JPT.GetMacroLog()
print(logMacro)
fileMacro = open("D:/Macro.jpl", "w")
for line in logMacro:
    fileMacro.write(line)
fileMacro.close()

# Get log content at Python API window
# Create a file .log to save Python API log content
logAPI = JPT.GetPythonAPILog()
print(logAPI)
fileAPI = open("D:/PythonAPI.log", "w")
for line in logAPI:
    fileAPI.write(line)
fileAPI.close()

# Get log content at Output window
# Create a file .log to save Output log content
logOutput = JPT.GetOutputLog()
print(logOutput)
fileOutput = open("D:/Output.log", "w")
for line in logOutput:
    fileOutput.write(line)
fileOutput.close()
