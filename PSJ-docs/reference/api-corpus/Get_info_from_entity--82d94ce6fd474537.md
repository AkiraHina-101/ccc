# Get info from entity

Get info from entity

🎯 Introduction​

In this tutorial, you'll learn how to get database info from entity:

Load sample model at installed Jupiter path into Jupiter.

Get list of entity (local face setting / pressure / group) from model database, then display name, id, entity type and target ID of each entity.

Get list of entity (element / face) by target entity ID from model database, then change color of each target entity.

📖 Tutorial​

# Clear the log message in Python API window
JPT.ClearLog()

# Get installed jupiter, sample path. Load sample model into Jupiter
jupiterPath = JPT.GetAppPathInfo(JPT.PathType.PROGRAM_PATH)
samplePath = jupiterPath + '/SampleData/PSJ/PSJ-Utility/JtdbSample/EntityModel.jtdb'
FileMenu.LoadJTDB(samplePath)
JPT.ViewFitToModel()

# Get list of 'local face setting' entity from model database
# Then display name, id, entity type and all faces ID of local setting
listLocalSetting = JPT.GetAllByType(JPT.DItemType.LOCAL_SETTING)
if listLocalSetting.sizeVec() > 0:
    for ls in listLocalSetting:
        print ("local setting name: " + ls.name)
        print ("local setting ID: " + str(ls.id))
        print ("entity type: " + str(ls.type))
        listTargetFaces = ls.targets
        print ("target face ID of local face setting list:")
        for face in listTargetFaces:
            print(face.id)

# Get list of 'general pressure' entity from model database
# Then display name, id, entity type and all faces ID of general pressure
listGeneralPressure = JPT.GetAllByType(JPT.DItemType.LBC_G_PRESSURE)
if listGeneralPressure.sizeVec() > 0:
    for pressure in listGeneralPressure:
        print ("pressure name: " + pressure.name)
        print ("pressure ID: " + str(pressure.id))
        print ("entity type: " + str(pressure.type))
        listTargetFaces = pressure.targets
        print ("target face ID of general pressure list:")
        for face in listTargetFaces:
            print(face.id)

# Get list of 'group' entity from model database
# Then display name, id, entity type and all element ID of group
listGroup = JPT.GetAllByType(JPT.DItemType.GROUP)
if listGroup.sizeVec() > 0:
    for group in listGroup:
        print ("group name: " + group.name)
        print ("group id: " + str(group.id))
        print ("entity type: " + str(group.type))
        listTargetElems = group.targets
        print ("target element ID of element group entity list:")
        for elem in listTargetElems:
            print(elem.id)

# Get list of 'element' entity with ID 239 from model database
# Then change color of element ID 239 to white
listElemEntityObject = JPT.GetEntitiesByID(JPT.DItemType.ELEM, 239)
if listElemEntityObject.sizeVec() == 1:
    elemObject = JPT.CastDItemToDFace(listElemEntityObject[0])
    elemObject.color = JPT.ConvertRGBToJPTColor(255, 255, 255)

# Get list of 'face' entity with ID 23 from model database
# Then change color of face ID 23 to green
listFaceEntityObject = JPT.GetEntitiesByID(JPT.DItemType.FACE, 23)
if listFaceEntityObject.sizeVec() == 1:
    faceObject = JPT.CastDItemToDFace(listFaceEntityObject[0])
    faceObject.color = JPT.ConvertRGBToJPTColor(0, 255, 0)
