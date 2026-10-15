# Get macro and Python log

Get macro and Python log

🎯 Introduction​

In this tutorial, you'll learn how to get log from Macro window and Python API window:

Get log content at Macro window.
Then create a macro file .jpl to save Macro log content.

Get log content at Python API window.
Then create a file .log to save Python API log content.

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
