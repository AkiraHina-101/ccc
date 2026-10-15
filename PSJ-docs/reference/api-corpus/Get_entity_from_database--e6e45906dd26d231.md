# Get entity from database

Get entity from database

🎯 Introduction​

In this tutorial, you'll learn how to get entity from database:

Get list of specific entity (Part/Face/Edge/Element/Node/Group/Connection/Coordinate/LBC).

Get list of entity has table type (Loadcases/LocalSetting).

Get list of entity by entity's type (Edge/1D Element).

Get material by property's ID.

Get list of all faces associated with part by part's ID.

Get list of entity by entity's type and entity's properties (name, ID).

Get Node entity by x,y,z position.

📖 Tutorial​

# Clear the log message in Python API window
JPT.ClearLog()

# Prepare model
path = JPT.GetAppPathInfo(JPT.PathType.PROGRAM_PATH)
FileMenu.LoadJTDB(path + "/SampleData/PSJ/PSJ-Utility/JtdbSample/Get_Infor_Part_Sample.jtdb")
JPT.ViewFitToModel()

############ Get list of specific entity from database ##############
# Get list of all 'Part' entity
listParts = JPT.GetAllParts()
JPT.Debugger(listParts) # list Body, size = 3

# Get list of all 'Face' entity
listFaces = JPT.GetAllFaces()
JPT.Debugger(listFaces) # list Face, size = 26

# Get list of all 'Edge' entity
listEdges = JPT.GetAllEdges()
JPT.Debugger(listEdges) # list Edge, size = 173

# Get list of all 'Element' entity
listElems = JPT.GetAllElems()
JPT.Debugger(listElems) # list Elem, size = 12595

# Get list of all 'Node' entity
listNodes = JPT.GetAllNodes()
JPT.Debugger(listNodes) # list Node, size = 15401

# Get list of all 'Group' entity
listGroups = JPT.GetAllGroups()
JPT.Debugger(listGroups) # list Group, size = 10

# Get list of all 'Connection' entity: MPC/RBE2/..
listConnections = JPT.GetAllConnections()
JPT.Debugger(listConnections) # list Connect, size = 2

# Get list of all 'Coordinate' entity
listCoordinates = JPT.GetAllCoordinates()
JPT.Debugger(listCoordinates) # list Coord, size = 1

# Get list of all 'Loads and Boundary Conditions' entity
listLBCs = JPT.GetAllLoadBoundaryConditions()
JPT.Debugger(listLBCs) # list LBC, size = 5

# Get list of all 'Loads and Boundary Conditions' entity under DItem format
listEntity = JPT.GetAllLoadsBCs()
JPT.Debugger(listEntity) # list DItem, size = 5

############  Get list of entity has table type ##############
# Get list of all 'LoadCases' entity which has table type in database
listEntityLoadCases = JPT.GetAllByTableTypeID(JPT.DTableType.DTABLE_LOADCASE)
JPT.Debugger(listEntityLoadCases) # list DItem, size = 0

# Get list of all 'LocalSetting' entity which has table type in database
listEntityLocalSettings = JPT.GetAllByTableTypeID(JPT.DTableType.DTABLE_LOCAL_SETTING)
JPT.Debugger(listEntityLocalSettings) # list DItem, size = 1

############  Get list of entity by DItem/Elem type (Edge/1D Element)  ##############
# Get list of all 'Edge' entity by DItem type
listEntityEdges = JPT.GetAllByType(JPT.DItemType.EDGE)
JPT.Debugger(listEntityEdges) # list DItem, size = 173

# Get list of all '1D element' by Element kind
list1DElems = JPT.GetElemsByKind(JPT.ElemKind.ELEMKIND_1D)
JPT.Debugger(list1DElems) # list Elem, size = 383

# Get material by property ID. Example: property ID is 1
idProperty = 1
material = JPT.GetMaterialFromProperty(idProperty)
JPT.Debugger(material) # DItem, name = Stainless_Steel

# Get list of all faces associated with part by part's ID. Example: part ID is 2
idPart = 2
listAssociatedFaces = JPT.GetEntitiesByAssociation(JPT.DItemType.BODY, JPT.AssociateType.AS_FACE, idPart)
JPT.Debugger(listAssociatedFaces) # list DItemVector, size = 10

############  Get list of entity by entity table's type and entity's properties (name, ID) ##############
# Get list of entity object by DItem type and entity ID. Example: Element ID is 39869
idElem = 39869
listEntityByID = JPT.GetEntitiesByID(JPT.DItemType.ELEM, idElem)
JPT.Debugger(listEntityByID) # list DItem, size = 1

# Get list of entity objects by 'Body' DTabel type and entity name starting with "Block"
isMatch = JPT.BoolType.TRUE_VAL
entityName = "Block"
listEntityByName = JPT.GetEntitiesByName(JPT.DTableType.DTABLE_BODY, entityName, isMatch)
JPT.Debugger(listEntityByName) # list DItem, size = 1

# Get 'Node' entity at x,y,z position
x = 0
y = 0
z = 10
listNodeByPos = JPT.GetEntitiesByPosition(JPT.AssociateType.AS_NODE, x, y, z)
JPT.Debugger(listNodeByPos) # list DItem, size = 1
