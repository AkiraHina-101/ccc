# Groups.RightClick.CopyGroup()

Groups.RightClick.CopyGroup()

Description​

Copy the inputted groups in the Group tree and paste them to a specified sub group.

Syntax​

Groups.RightClick.CopyGroup(...)

Ribbon: Groups » RightClick » CopyGroup

Inputs​

crlGroups​

A List of Cursor specifying the list of group items uses for copying.

This is a required input.

strlNames​

A List of String specifying the list of new group names for the copied groups.

The default value is [].

crSubGroup​

A Cursor specifying the supper group destination if any.

The default value is None.

bKeepOriginalGroup​

A Boolean enable/disable the keeping original group.

The default value is False.

Return Code​

A List of Cursor specifying all the pasted groups.

Sample Code​

Geometry.Part.Cube()

Tools.Group.CreateGroup(strGroupName="Group1", 
                        crlTargets=[Face(22)])
Tools.Group.CreateGroup(strGroupName="Group2", 
                        crlTargets=[Face(24)])
Tools.Group.CreateGroup(strGroupName="Group3",
                        crlTargets=[Face(26)])

Groups.RightClick.AddSubGroup()

pasted_groups = Groups.RightClick.CopyGroup(crlGroups=[Group(1, 2, 3)], 
                                            crSubGroup=SubGroup(1))

JPT.Debugger(pasted_groups)
