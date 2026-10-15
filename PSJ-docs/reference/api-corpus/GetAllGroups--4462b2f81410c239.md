# GetAllGroups

GetAllGroups GetAllGroups Description Get all entities' information inside groups Syntax GetAllGroups() Inputs None No input value Return Code Python Output GroupVector Group information (id, key, name, targets, typeID) Sample Code Input: groups=JPT.GetAllGroups() for g in groups: for e in g.targets: print(str(e.typeID)+' '+str(e.id)+' '+str(e.key)+' '+str(e.name)) Output: > 6 26 26 > 6 22 22 > 6 24 24 > 3 2 2 Cylinder_1 > 3 1 1 Cube_1
