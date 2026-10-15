# GetSelectedFaces

GetSelectedFaces GetSelectedFaces Description Get selected face information Syntax GetSelectedFaces() Inputs None No input value Return Code Python Output FaceVector Selected face information (typeID, id, key) Sample Code Input: faces = JPT.GetSelectedFaces() for f in faces: print(str(f.id)+' '+str(f.key)+' '+str(f.typeID)) Output: > 22 22 6 > 26 26 6 > 31 31 6
