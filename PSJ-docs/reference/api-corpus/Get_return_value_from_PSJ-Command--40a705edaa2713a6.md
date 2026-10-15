# Get return value from PSJ-Command

Get return value from PSJ-Command

🎯 Introduction​

In this tutorial, you'll learn how to access information from PSJ Command return value and passing argument to other commands:

Get return value from a single entity.

Get return value from a list of entities.

Get return value from a list of double values.

📖 Tutorial​

# Clear the log message in Python API window
JPT.ClearLog()

############ CASE 1 : return value from a single entity ############
# Get return value when create new cube part, Geometry.Part.Cube() will return a single object with two attributes:
# typeId (int)
# ids = (tuple)
newCube = Geometry.Part.Cube()
JPT.Debugger(newCube)

# Access two attributes
listBodies = JPT.GetEntitiesByID(JPT.DItemType.BODY, newCube.ids[0])
listAllEntities = JPT.GetAllByType(newCube.typeId)

# Pass PSJ command return value to other commands
#Geometry.DeleteEntity.Part(crlPart=[newCube])

############ CASE 2 : return value from a list of entities ############
# Get return value when transform part by translation, Geometry.Transform.Translation() will return a list objects
newPartList = Geometry.Transform.Translation(crlParts=[newCube],
    dlTranslationVector=[[0.01, 0.01, 0.01]], bCreateNewPart=True, iCopyCount=2)
JPT.Debugger(newPartList)

# Access two attributes, note that now newPartList is a list, then to access first element
listBodies2 = JPT.GetEntitiesByID(JPT.DItemType.BODY, newPartList[0].ids[0])
listAllEntities2 = JPT.GetAllByType(newPartList[0].typeId)

# Pass PSJ command return value to other commands, note that now newPartList is a list so do not need [] any more
Geometry.DeleteEntity.Part(crlParts=newPartList)

############ CASE 3 : return value from a list of double values ############
# Get return value when measure distance between two nodes, Tools.Measure.Distance.TwoNodes() will return a list double
distance = Tools.Measure.Distance.TwoNodes(crNode1=Node(80), crNode2=Node(74))

# Access list double
print(distance[0])
print(distance[1])
print(distance[2])
print(distance[3])

############ EXTRA NOTES ############
# In case return value is string (not yet converted), you can use below API to convert it
str1 = getCursorValueByStr('3:1') #Part(1)
print(str1)

str2 = getListCursorValueByStr('[3:1, 3:2]') #Part(1, 2)
print(str2)

str3 = getListDoubleValueByStr('[0.006667,0.006667,0.0,0.0]') #[0.006667,0.006667,0.0,0.0]
print(str3)
