# JPT.GetAllGroups()

JPT.GetAllGroups()

Description​

Get all the information of all existing groups.

Syntax​

JPT.GetAllGroups()

Inputs​

This utility function does not require any input value.

Return Code​

A GroupVector object or List of DGroup objects containing all the information of all the existing groups.

Sample Code​

# Prepare model
Geometry.Part.Cube()
Geometry.Part.Cube(strName="Cube_2")
Geometry.Part.Cube(strName="Cube_3")
Tools.Group.CreateGroup(strGroupName="Group1", crlTargets=[Part(1)])
Tools.Group.CreateGroup(strGroupName="Group2", crlTargets=[Face(47, 48, 49, 50, 51, 52)])
Tools.Group.CreateGroup(strGroupName="Group3", crlTargets=[Elem(2784, 2296, 2677, 2295, 3144, 2977)])
JPT.ViewFitToModel()

# Get the information of all existing groups
listDGroups = JPT.GetAllGroups()
JPT.Debugger(listDGroups)

# Print all the related information of each existing group in list
for group in listDGroups:
    JPT.Debugger(group)
