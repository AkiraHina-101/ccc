# Manipulate PSJ data type

Manipulate PSJ data type

Introduction​

In this tutorial, you'll learn how to manipulate PSJ data type:

Create a cube.

Get the Face entity by ID (26, 22, 24) under DItemVector format from the cube database.

Create a list of DItemVector containing Face entity by ID (26, 22, 24).

Get the Node entity by ID 259 under DItemVector format from the cube database.

Set Local Settings Face for target face ID in Face entity list.

Introduce PSJ Utility supports obtaining the desired requirement when converting PSJ data type into macro string.

Introduce how to convert back to PSJ data type from returned string value of macro.

Tutorial​

# Clear the log message in Python API window
JPT.ClearLog()

# Create a cube
Geometry.Part.Cube(strName="Cube_1", iPartColor=12999622)
JPT.ViewFitToModel()

# Get the 'Face' entity (DItemVector) by ID 26, 22, 24 from cube database
listFaceID_26 = JPT.GetEntitiesByID(JPT.DItemType.FACE, 26) #DItemVector
listFaceID_22 = JPT.GetEntitiesByID(JPT.DItemType.FACE, 22) #DItemVector
listFaceID_24 = JPT.GetEntitiesByID(JPT.DItemType.FACE, 24) #DItemVector

# Create a list of DItemVector containing 'Face' entity by ID 26, 22, 24
LocalSettingFaces = []
LocalSettingFaces.append(listFaceID_26)
LocalSettingFaces.append(listFaceID_22)
LocalSettingFaces.append(listFaceID_24)
print(LocalSettingFaces) #List of DItemVector

# Get the 'Node' entity (DItemVector) by ID 259 from cube database
listNodeID_259 = JPT.GetEntitiesByID(JPT.DItemType.NODE, 259) #DItemVector

# Set Local Settings Face for each target face ID in LocalSettingFaces list
# Convert list of 'Face' entity to List of Cursor to specify target face of the Local Settings Face
if len(LocalSettingFaces) == 3:
    for DItemVectorFaceID in LocalSettingFaces:
        strListTCursorFace = JPT.DItemListToMacroListTCursor(DItemVectorFaceID)
        Meshing.LocalSettings.Face(strName="Local Setting {}".format(LocalSettingFaces.index(DItemVectorFaceID)+1),
            localMesh=LOCAL_MESH(iEntityType=2, bEnableSizeParams=True,
            dAvgElemSize=0.005, dMaxElemSize=0.01, dMinElemSize=0.001,
            bEnableMeshPattern=True, iMeshPatternType=1), crlTargets=strListTCursorFace)

# Convert PSJ data type into macro string
MacroListTCursor = JPT.DItemToMacroListTCursor(listFaceID_26[0])
print(MacroListTCursor)

MacroTCursor = JPT.DItemToMacroTCursor(listFaceID_26[0])
print(MacroTCursor)

MacroTCursorPair = JPT.DItemToMacroTCursorPair(listFaceID_26[0], listFaceID_22[0])
print(MacroTCursorPair)

MacroVector = JPT.ListDoubleToMacroVector(1.0, 2.0, 3.0)
print(MacroVector)

# Get position of node ID 259 as macro string value
nodeEntity = JPT.CastDItemToDNode(listNodeID_259[0])
MacroVector = JPT.DTVector3dToMacroVector(nodeEntity.pos)
print(MacroVector)

# Convert back to PSJ data type from returned string value of macro
ListEntity = JPT.MacroListTCursorToListDItem('[6:26, 6:22, 6:24]')
JPT.Debugger(ListEntity)

Entity = JPT.MacroTCursorToDItem('6:26')
JPT.Debugger(Entity)
