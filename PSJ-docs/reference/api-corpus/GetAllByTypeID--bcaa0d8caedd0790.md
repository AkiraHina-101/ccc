# GetAllByTypeID

GetAllByTypeID GetAllByTypeID Description Get information of entities by inputing their typeIDs Syntax GetAllByTypeID(int iTypeID) Inputs Int Type ID of entities Return Code Python Output DItemVector Information of entities: id, name, info, isValid, key, masters, slaves, target, type, type ID, parent, children Sample Code Input: typeid = JPT.GetAllByTypeID(3) for t in typeid: print('Name: "{0}"; ID = {1}'.format(t.name, t.id)) Output: > Name: "Pin"; ID = 1 > Name: "plunger"; ID = 2 > Name: "Base"; ID = 3
