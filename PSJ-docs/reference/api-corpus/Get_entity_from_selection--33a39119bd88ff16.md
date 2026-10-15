# Get entity from selection

Get entity from selection

🎯 Introduction​

In this tutorial, you'll learn how to get entity from selection:

Select some specified entities (Part/Face/Edge/Element/Node/Group).

Get information of selection.

📖 Tutorial​

# Clear the log message in Python API window
JPT.ClearLog()

# Prepare model
path = JPT.GetAppPathInfo(JPT.PathType.PROGRAM_PATH)
FileMenu.LoadJTDB(path + "/SampleData/PSJ/PSJ-Utility/JtdbSample/Get_Infor_Part_Sample.jtdb")
JPT.ViewFitToModel()

############ Select and get information of some specified entities ##############
# Select Parts
Home.Find(strSearch="2 6 9")
# Get list of all selected 'Part' entity
listParts = JPT.GetSelectedParts()
JPT.Debugger(listParts) # list Body, size = 3
JPT.ClearAllSelection()

# Select Faces
Home.Find(strSearch="5 74 148", strSelectedType="Face")
# Get list of all selected 'Face' entity
listFaces = JPT.GetSelectedFaces()
JPT.Debugger(listFaces) # list Face, size = 3
JPT.ClearAllSelection()

# Select Edges
Home.Find(strSearch="119 183 249", strSelectedType="Edge")
# Get list of all selected 'Edge' entity
listEdges = JPT.GetSelectedEdges()
JPT.Debugger(listEdges) # list Edge, size = 3
JPT.ClearAllSelection()

# Select Elems
Home.Find(strSearch="40152 44529 48924", strSelectedType="3D Element")
# Get list of all selected '3D Element' entity
listElems = JPT.GetSelectedElems()
JPT.Debugger(listElems) # list Element, size = 3
JPT.ClearAllSelection()

# Select Nodes
Home.Find(strSearch="436 6235 6515", strSelectedType="Node")
# Get list of all selected 'Node' entity
listNodes = JPT.GetSelectedNodes()
JPT.Debugger(listNodes) # list Node, size = 3
JPT.ClearAllSelection()

# Create Groups
Tools.Group.CreateGroup(strGroupName="Group11", crlTargets=[Part(2, 6, 9)])
Tools.Group.CreateGroup(strGroupName="Group12", crlTargets=[Face(139, 78, 8)])
Tools.Group.CreateGroup(strGroupName="Group13", crlTargets=[Elem(48915, 41806, 44650)])
# Select Groups
Home.Find(strSearch="11 12 13", strSelectedType="Group")
# Get list of all selected 'Group' entity
listGroups = JPT.GetSelectedGroups()
JPT.Debugger(listGroups) # list Group, size = 3
JPT.ClearAllSelection()
