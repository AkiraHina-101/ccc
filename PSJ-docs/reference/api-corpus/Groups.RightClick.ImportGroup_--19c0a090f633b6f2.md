# Groups.RightClick.ImportGroup()

Groups.RightClick.ImportGroup()

Description​

Create a group to the Group tree in the Group Window by importing a *CSV file.

Syntax​

Groups.RightClick.ImportGroup(...)

Macro:

Ribbon: Groups » RightClick » ImportGroup

Inputs​

strlPaths​

A List of String specifying the path to *CSV files.

This is a required input.

crParentGroup​

A Cursor specifying the parent sub group (SUP_GROUP) to import.

The default value is None.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: Import the group successfully.

False: Cannot import the group.

Sample Code​

import os 

# Prepare model
Geometry.Part.Cube(iPartColor=6409934)
Tools.Group.CreateGroup(
    strGroupName="Group1", 
    crlTargets=[Face(26, 24)])
JPT.ViewFitToModel()

Tools.Group.CreateGroup(
    strGroupName="Group2", 
    crlTargets=[Node(45, 46, 100, 101, 102, 145, 146, 153, 154)])

temp_path=JPT.GetAppPathInfo(JPT.PathType.TEMP_PATH)

groups=JPT.GetAllGroups()

max_group_num=len(groups)
for i, group in enumerate(groups):
    # Export groups
    Groups.RightClick.ExportGroup(
        crlTargets=[Group(group.id)], 
        strlPaths=[os.path.join(temp_path,f"Group_{i}.csv")],
        iEncode=1,
        bWithBOM=True)
    # Delete the group
    Groups.RightClick.DeleteGroup(crlGroups=[Group(group.id)])

# Re-import groups
for i in range(max_group_num):
    Groups.RightClick.ImportGroup(
        strlPaths=[os.path.join(temp_path,f"Group_{i}.csv")])
