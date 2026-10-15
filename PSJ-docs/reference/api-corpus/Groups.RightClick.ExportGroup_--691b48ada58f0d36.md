# Groups.RightClick.ExportGroup()

Groups.RightClick.ExportGroup()

Description​

Export specified group to *CSV file.

Syntax​

Groups.RightClick.ExportGroup(...)

Macro:

Ribbon: Groups » RightClick » ExportGroup

Inputs​

crlTargets​

A List of Cursor specifying the groups to be exported.

This is a required input.

strlPaths​

A List of String specifying the paths of *CSV files.

This is a required input.

iEncode​

An Integer specifying encoding type.

-1: None

0: UTF-8

1: SHIFT-JIS

The default value is -1.

bWithBOM​

A Boolean specifying whether or not include BOM for UTF-8 format.

The default value is False.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: Export the group successfully.

False: Cannot export the group.

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
for group in groups:
    # Export groups
    Groups.RightClick.ExportGroup(
        crlTargets=[Group(group.id)], 
        strlPaths=[os.path.join(temp_path,f"Group_{group.id}.csv")],
        iEncode=1,
        bWithBOM=True)
