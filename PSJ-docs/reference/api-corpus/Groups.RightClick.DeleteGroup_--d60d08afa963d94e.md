# Groups.RightClick.DeleteGroup()

Groups.RightClick.DeleteGroup()

Description​

Delete specified groups from the Group tree in the Group Window.

Syntax​

Groups.RightClick.DeleteGroup(...)

Ribbon: Groups » RightClick » DeleteGroup

Inputs​

crlGroups​

A List of Cursor specifying the list of group items uses for deleting.

This is a required input.

bRemoveAll​

A Boolean enable/disable all group deletion.

The default value is False.

Return Code​

A Boolean specifying the status of the deleting process:

True: The inputted groups have been deleted successfully.

False: The inputted groups cannot be deleted.

Sample Code​

Geometry.Part.Cube()

Tools.Group.CreateGroup(strGroupName="Group1",
                        crlTargets=[Face(26)])
Tools.Group.CreateGroup(strGroupName="Group2",
                        crlTargets=[Face(24)])

deleted_groups = Groups.RightClick.DeleteGroup(crlGroups=[Group(1,
                                                                2)])

JPT.Debugger(deleted_groups)
