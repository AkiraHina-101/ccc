# Convert object types

Convert object types

🎯 Introduction​

In this tutorial, you'll learn how to convert betweens object types (Base <--> Child):

Get list of all parts in current model.

Check information of DBody object.

Convert DBody object to DItem entity object (base class) which contains more information.

Convert DItem entity object (base class) back to DBody object.

Base class: Entity

Child class: Body, Face, Edge, Group, Node, Elem, etc.

In this tutorial, Body object is used, but other objects can be used as the same way.

📖 Tutorial​

# Clear the log message in Python API window
JPT.ClearLog()

# Create a cube
Geometry.Part.Cube(strName="Cube_1")

# Fit view of model on display view
JPT.ViewFitToModel()

# Get list of all parts in current model
# This function returns list of parts (Body). Object type: DBody
# Check information of DBody object
listParts = JPT.GetAllParts()
cubePart = listParts[0]
JPT.Debugger(cubePart)

# Convert DBody object to DItem entity object (base class)
# Check information of DItem entity object
cubeDItem = JPT.CastToDItem(cubePart)
JPT.Debugger(cubeDItem)

# Convert back DItem entity object (base class) to DBody object
# Check information of DBody object
new_cubePart = JPT.CastDItemToDBody(cubeDItem)
JPT.Debugger(new_cubePart)
