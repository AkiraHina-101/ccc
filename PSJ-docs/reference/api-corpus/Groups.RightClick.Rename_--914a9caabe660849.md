# Groups.RightClick.Rename()

Groups.RightClick.Rename()

Description​

Rename the specified group in the Group tree of the Group Window.

Syntax​

Groups.RightClick.Rename(...)

Ribbon: Groups » RightClick » Rename

Inputs​

strNewName​

A String specifying the new name of the group to be renamed.

This is a required input.

crItem​

A Cursor specifying the current group to be renamed.

This is a required input.

Return Code​

A Boolean specifying the status of the deleting process:

True: The name of the inputted group has been changed successfully.

False: The name of the inputted group cannot be changed.

Sample Code​

Geometry.Part.Cube()

Tools.Group.CreateGroup(strGroupName="Group1", crlTargets=[Part(1)])

rename_status = Groups.RightClick.Rename(strNewName = "new name", crItem = Group(1))

JPT.Debugger(rename_status)
