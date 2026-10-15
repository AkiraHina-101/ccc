# Get Jupiter path information

Get Jupiter path information

🎯 Introduction​

In this tutorial, you'll learn how to get related Jupiter path information:

Get Jupiter Internal Path: Get related Jupiter internal path information, such as: Jupiter installation folder path, material library path, temp folder path, etc.

Get Loaded Module or File Path: Get loaded module or file path information that Jupiter uses.

Get Jupiter Internal Path

Get Loaded Module or File Path

List all Jupiter paths information at Python API window.

List all path types at Python API window.

Get related Jupiter paths: installation path, current opening .jtdb file path, material library path, IDE database path, etc.

🧮 Usability​

In order to get the full path of the loaded file, using JPT.PATHTYPE.FILE_PATH will solve the problem.

🪁 Usage Environment​

In IDE, use the Open (File » Open) option to load script from file.

In File Launcher, use the register button S to load a file. For details, see the File Launcher.

In Customized Function, put the script in PSJ-Command custom folder, Jupiter will return the path of itself.

📖 Tutorial​

Get Jupiter Internal Path

Get Loaded Module or File Path

# Clear the log message in Python API window
JPT.ClearLog()

# List all Jupiter paths information at Python API window
JPT.PrintAppPathInfo()

# List all path types at Python API window
JPT.Debugger(JPT.PathType.values)

# Get Jupiter installation path
programPath = JPT.GetAppPathInfo(JPT.PathType.PROGRAM_PATH)
print(programPath)

# Get Jupiter temp path
tempPath = JPT.GetAppPathInfo(JPT.PathType.TEMP_PATH)
print(tempPath)

# Get Jupiter app data path
appdataPath = JPT.GetAppPathInfo(JPT.PathType.APPDATA_PATH)
print(appdataPath)

# Get current opening document file path
docPath = JPT.GetAppPathInfo(JPT.PathType.DOC_PATH)
print(docPath)

# Get default material library path
materialLibPath = JPT.GetAppPathInfo(JPT.PathType.MATERIAL_LIB_FILE_PATH)
print(materialLibPath)

# Get user-defined material library path
materialUserPath = JPT.GetAppPathInfo(JPT.PathType.MATERIAL_USER_FILE_PATH)
print(materialUserPath)

# Get Jupiter database path
databasePath = JPT.GetAppPathInfo(JPT.PathType.DATABASE_PATH)
print(databasePath)

# Get Sunshine path
sunshinePath = JPT.GetAppPathInfo(JPT.PathType.SUNSHINE_PATH)
print(sunshinePath)

# Get IDE database path
ideDataPath = JPT.GetAppPathInfo(JPT.PathType.IDE_DATA_PATH)
print(ideDataPath)

# Get folder path for custom ribbon by PSJ
psjRibbonPath = JPT.GetAppPathInfo(JPT.PathType.PSJ_COMMAND_PATH)
print(psjRibbonPath)

"""
Sample script for putting on the loaded file
"""

# Clear the log message in Python API window
JPT.ClearLog()

# Get loaded file path
filePath = JPT.GetAppPathInfo(JPT.PathType.FILE_PATH)
print(filePath)
