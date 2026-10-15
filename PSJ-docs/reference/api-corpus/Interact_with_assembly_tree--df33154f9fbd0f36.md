# Interact with assembly tree

Interact with assembly tree

🎯 Introduction​

In this tutorial, you'll learn how to interact with assembly tree (in Assembly window):

Create a new sub assembly node.

Find and delete a sub assembly node by name.

Find a sub assembly node by ID then print out a part ID inside that assembly node.

Delete sub assembly and all of its children.

Collapse/Expand the assembly tree.

📖 Tutorial​

# Clear the log message in Python API window
JPT.ClearLog()

# Get jupiter installation path
jupiterPath = JPT.GetAppPathInfo(JPT.PathType.PROGRAM_PATH)
samplePath = jupiterPath + '/SampleData/PSJ/PSJ-Utility/JtdbSample/AssemblySample.jtdb'
FileMenu.LoadJTDB(samplePath)

# Create a new sub assembly node
JPT.CreateSubAssembly("NewSubNode", JPT.DItem())

# Get sub assembly node by name
subObjects = JPT.FindSubAssemblyByName("NewSubNode")

# Delete sub assembly node
JPT.DeleteSubAssembly(subObjects[0])

# Get a sub assembly node by ID
subObject = JPT.FindSubAssemblyByID(1)

# Get all parts from a sub assembly node
listParts = JPT.GetAllPartsInSubAssembly(subObject)
print("part id from sub assembly: " + str(listParts[0].id))

# Delete a sub assembly and all children
JPT.DeleteSubAssembly(subObject)

# Collapse assembly tree
JPT.CollapseAssemblyTree()

# Expand assembly tree
JPT.ExpandAssemblyTree()
