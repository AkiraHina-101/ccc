# Get info from part

Get info from part

🎯 Introduction​

In this tutorial, you'll learn how to get database information from part:

Load sample model at installed Jupiter path into Jupiter.

Get information of first part in all parts list, assign to part. Display name, id of part at Python API window.

Change Name / Color / Mesh Color/ Transparency of part.

Get entities (Face/Edge/Vertex/Element/Node) of part.

Get Material and Property of part.

Get Load and BC / Connection / Local Mesh Setting / Contact related to part.

Get Area / Volume / Mass / Center of Gravity / Moment of Inertia of part.

📖 Tutorial​

# Clear the log message in Python API window
JPT.ClearLog()

# Get installed jupiter, sample path
# Then load sample model into Jupiter
jupiterPath = JPT.GetAppPathInfo(JPT.PathType.PROGRAM_PATH)
samplePath = jupiterPath + '/SampleData/PSJ/PSJ-Utility/JtdbSample/Get_Infor_Part_Sample.jtdb'
FileMenu.LoadJTDB(strFileName=samplePath)

# Fit view of model on display view
JPT.ViewFitToModel()

# Get list of all parts in current model
listpart = JPT.GetAllParts()

# Get information of first part in all parts list, assign to 'part'
# Then display name, id of first part at Python API window
part = listpart[0]
JPT.Debugger(part)
print (part.id)
print (part.name)

# Change name of 'part'
part.name = "change_name_of_first_part"

# Change color of 'part' with random color
part.color = JPT.GetRandomJPTColor()

# Change color of 'part' with with RGB color
part.color = JPT.ConvertRGBToJPTColor(255,0,0)

# Change mesh line color of 'part' with RGB color
part.colorMesh = JPT.ConvertRGBToJPTColor(255,255,255)

# Set transparency of 'part' as 50%
part.transparency = 50

# Get all faces from 'part'
listFaces = part.faces
JPT.Debugger(listFaces)

# Get all elements from 'part'
listElems = part.elems
JPT.Debugger(listElems)

# Get all nodes from 'part'
listNodes = part.nodes
JPT.Debugger(listNodes)

# Get all edges from 'part'
listEdges = part.edges
JPT.Debugger(listEdges)

# Get all vertex from 'part'
listVertex = part.vertex
JPT.Debugger(listVertex)

# Get material from 'part'
# Then display ID, name of material at Python API window
listMaterials = part.materials
if len(listMaterials) == 0:
    print ("This part has no material assignment.")
else:
    for material in listMaterials:
        print ("material id of 'part': " + str(material.id))
        print ("material name of 'part': " + str(material.name))

# Get properties from 'part'
# Then display ID, name of properties at Python API window
listProperties = part.properties
if len(listProperties) == 0:
    print ("This part has no properties assignment.")
else:
    for property in listProperties:
        print ("property id of 'part': " + str(property.id))
        print ("property name of 'part': " + str(property.name))

# Get all Load and BCs related to 'part'
# Then display ID, name of Load and BCs at Python API window
listLoadAndBCs = part.loadAndBCs
if len(listLoadAndBCs) == 0:
    print ("This part has no related Load and Boundary Condition.")
else:
    for loadAndBC in listLoadAndBCs:
        print ("loadAndBC id related to 'part': " + str(loadAndBC.id))
        print ("loadAndBC name related to 'part': " + str(loadAndBC.name))

# Get all connections related to 'part'
# Then display ID, name of connections at Python API window
listConnections = part.connections
if len(listConnections) == 0:
    print ("This part has no related connection(MPC/RBE2).")
else:
    for connection in listConnections:
        print ("connection id related to 'part':  " + str(connection.id))
        print ("connection name related to 'part': " + str(connection.name))

# Get all localMeshSettings from 'part'
# Then display ID, name of localMeshSettings at Python API window
listLocalMeshSettings = part.localMeshSettings
if len(listLocalMeshSettings) == 0:
    print ("This part has no local mesh setting.")
else:
    for localMeshSetting in listLocalMeshSettings:
        print ("localMeshSetting id of 'part': " + str(localMeshSetting.id))
        print ("localMeshSetting name of 'part': " + str(localMeshSetting.name))

# Get all contacts related to 'part'
# Then display ID, name of contacts at Python API window
listContacts = part.contacts
if len(listContacts) == 0:
    print ("This part has no related contact.")
else:
    for contact in listContacts:
        print ("contact id related to 'part': " + str(contact.id))
        print ("contact name related to 'part': " + str(contact.name))

# Get and display area value of 'part' at Python API window
print("Area of 'part': " + str(part.area))

# Get and display volume value of 'part' at Python API window
print("Volume of 'part': " + str(part.volume))

# Get and display mass value of 'part' at Python API window
print("Mass of 'part': " + str(part.mass))

# Get and display center of gravity value of 'part' at Python API window
print("Center of Gravity of 'part': [%s %s %s] " % \
    (str(part.gravityCenter.x) , str(part.gravityCenter.x),  str(part.gravityCenter.x)))

# Get and display moment of inertia value of 'part' at Python API window
print("Moment of Inertia of 'part': " )
JPT.Debugger(part.momentInertia)
