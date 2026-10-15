# GetSelectedGroups

GetSelectedGroups GetSelectedGroups Description Get selected group information (Entity information inside group) Syntax GetSelectedGroups() Inputs None No input value Return Code Python Output GroupVector Selected group information ( id, key, name, targets, typeID) Sample Code Input: groups=JPT.GetSelectedGroups() for g in groups: for e in g.targets: print(str(e.typeID)+' '+str(e.id)+' '+str(e.key)+' '+str(e.name)) Output: > 3 2 2 Cylinder_1 > 3 1 1 Cube_1
