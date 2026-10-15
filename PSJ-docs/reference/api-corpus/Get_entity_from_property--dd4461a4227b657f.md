# Get entity from property

Get entity from property

🎯 Introduction​

In this tutorial, you'll learn how to get entity's information (1D/2D element) from Property type:

Get list of all Face and Edge entities in model.

Get list of Shell and Beam Property in model.

Define function to check whether Face has Shell Property or not by Face's ID.

Define function to get total 2D elements having Shell Property.

Define function to check whether Edge has Beam Property or not by Edge's ID.

Define function to get total 1D elements having Beam Property.

Get and display total 2D elements having Shell Property at Python API window.

Get and display total 1D elements having Beam Property at Python API window.

Please prepare analysis model having 1D/2D elements in advance, below script in this tutorial didn't include analysis model.

Target entity of 2D property in analysis model should be 'Face' entity.

📖 Tutorial​

# Clear the log message in Python API window
JPT.ClearLog()

# Get list of all 'Face' and 'Edge' entities in model
listFace = JPT.GetAllFaces()
listEdge = JPT.GetAllEdges()

# Get list of 'Shell' and 'Beam' Property in model
listShellProp = JPT.GetAllByType(JPT.DItemType.PROPERTY_2D_SHELL)
listBeamProp = JPT.GetAllByType(JPT.DItemType.PROPERTY_1D_BEAM)

# Define function to check whether face has 'Shell' Property or not by face's ID
def CheckFaceHasShellProperty(faceID):
    for prop in listShellProp:
        targetFace = prop.targets
        for face in targetFace:
            if face.id == faceID:
                return faceID

# Define function to get total 2D elements having 'Shell' Property
def Get2DElemFromShellProperty():
    list2DElem = []
    for face in listFace:
        if CheckFaceHasShellProperty(face.id) != None:
            dItemFaces = JPT.GetEntitiesByID(JPT.DItemType.FACE, face.id)
            for item in dItemFaces:
                FaceElems = JPT.CastDItemToDFace(item).elems
                print("{} elements are extracted from Face ID {} having Shell Property ".\
                format(len(FaceElems),face.id))
                for elem in FaceElems:
                    list2DElem.append(elem)
    return list2DElem

# Define function to check whether edge has 'Beam' Property or not by edge's ID
def CheckEdgeHasBeamProperty(edgeID):
    for prop in listBeamProp:
        targetEdge = prop.targets
        for edge in targetEdge:
            if edge.id == edgeID:
                return edgeID

# Define function to get total 1D elements having 'Beam' Property
def Get1DElemFromBeamProperty():
    list1DElem = []
    for edge in listEdge:
        if CheckEdgeHasBeamProperty(edge.id) != None:
            dItemEdges = JPT.GetEntitiesByID(JPT.DItemType.EDGE, edge.id)
            for item in dItemEdges:
                BeamElems = JPT.CastDItemToDEdge(item).elems
                print("{} elements are extracted from Edge ID {} having Beam Property ".\
                format(len(BeamElems),edge.id))
                for elem in BeamElems:
                    list1DElem.append(elem)
    return list1DElem

# Get and display total 2D elements having 'Shell' Property at Python API window
listElem2D = Get2DElemFromShellProperty()
print("Total 2D elements have Shell Property: {}".format(len(listElem2D)))
JPT.Debugger(listElem2D)

# Get and display total 1D elements having 'Beam' Property at Python API window
listElem1D = Get1DElemFromBeamProperty()
print("Total 1D elements have Beam Property: {}".format(len(listElem1D)))
JPT.Debugger(listElem1D)
