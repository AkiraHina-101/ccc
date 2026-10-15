# Groups.RightClick.ExportSubGroup()

Groups.RightClick.ExportSubGroup()

Description​

Export specified subgroup to folder and *CSV file.

Syntax​

Groups.RightClick.ExportSubGroup(...)

Macro:

Ribbon: Groups » RightClick » ExportSubGroup

Inputs​

strFolderPath​

A String specifying the path of folder to save files.

The default value is "".

crlSubGroups​

A List of Cursor specifying the subgroup to be exported.

The default value is [].

crlGroups​

A List of Cursor specifying the groups to be exported.

The default value is [].

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

# Prepare model
Geometry.Part.Cube(iPartColor=6409934)

Groups.RightClick.AddSubGroup()

Assembly.RightClick.Rename(strNewName="SubGroup1", crItem=SubGroup(1))

Tools.Group.CreateGroup(
    strGroupName="Group1", 
    crlTargets=[Face(26, 24)])
JPT.ViewFitToModel()

Tools.Group.CreateGroup(
    strGroupName="Group2", 
    crlTargets=[Node(45, 46, 100, 101, 102, 145, 146, 153, 154)])

Groups.RightClick.CopyGroup(crlGroups=[Group(1, 2)], crSubGroup=SubGroup(1))

temp_path=JPT.GetAppPathInfo(JPT.PathType.TEMP_PATH)

subgroups=JPT.GetAllSubGroups()
for subgroup in subgroups:
    # Export subgroups
    Groups.RightClick.ExportSubGroup(
        strFolderPath=temp_path,
        crlSubGroups=[SubGroup(1)],
        iEncode=1,
        bWithBOM=True)
