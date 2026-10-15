# JPT.GetAllSubGroups()

JPT.GetAllSubGroups()

Description​

Get all the sub groups information.

Syntax​

JPT.GetAllSubGroups()

Inputs​

This utility function does not require any input value.

Return Code​

A SubGroupVector object or List of DSubGroup objects containing all the information of all the existing elements.

Sample Code​

# Prepare model
Geometry.Part.Cube(iPartColor=6409934)
Tools.Group.CreateGroup(
    strGroupName="Group1", 
    crlTargets=[Face(26, 22)])
Groups.RightClick.AddSubGroup()
Groups.RightClick.AddSubGroup()
Groups.RightClick.CopyGroup(
    crlGroups=[Group(1)], 
    strlNames=["Group1(1)"], 
    crSubGroup=SubGroup(1), bKeepOriginalGroup=True)
Groups.RightClick.CopyGroup(
    crlGroups=[Group(1)], 
    strlNames=["Group1(2)"], 
    crSubGroup=SubGroup(2), bKeepOriginalGroup=True)

# Get all Sub-groups
listSubGroups = JPT.GetAllSubGroups()
JPT.Debugger(listSubGroups)

# Iterate all sub groups of model
for subGroup in listSubGroups:
    JPT.Debugger(subGroup)    
    # Access id of sub-group
    id = subGroup.id
    JPT.Debugger(id)
    # Access typeID of sub-group
    typeid = subGroup.typeID
    JPT.Debugger(typeid)
    # Access name of sub-group
    name = subGroup.name
    JPT.Debugger(name)
    # Access parent of sub-group
    parent = subGroup.parent
    JPT.Debugger(parent)
    # Access children of sub-group
    children = subGroup.children
    JPT.Debugger(children)
    # Iterate all the children
    for child in children:
        JPT.Debugger(child)
