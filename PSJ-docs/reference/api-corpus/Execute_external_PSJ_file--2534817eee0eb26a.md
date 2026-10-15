# Execute external PSJ file

Execute external PSJ file

🎯 Introduction​

In this tutorial, you'll learn how to execute an external PSJ script file:

Get installed Jupiter path. Set path for external Python files.

Execute external Python files.

📖 Tutorial​

# Clear the log message in Python API window
JPT.ClearLog()

# Get installed Jupiter path. Set path for external Python files
jupiterPath = JPT.GetAppPathInfo(JPT.PathType.PROGRAM_PATH)
External_Create_Cube = str(jupiterPath) + '/SampleData/PSJ/PSJ-Utility/Utils/External_Create_Cube.py'
External_Meshing = str(jupiterPath) + '/SampleData/PSJ/PSJ-Utility/Utils/External_Meshing.py'

# Execute external Python file 'External_Create_Cube.py'
exec(open(External_Create_Cube).read())
JPT.ViewFitToModel()
JPT.Exec('ViewShowMesh(1)')

# Execute external Python file 'External_Meshing.py'
exec(open(External_Meshing).read())
