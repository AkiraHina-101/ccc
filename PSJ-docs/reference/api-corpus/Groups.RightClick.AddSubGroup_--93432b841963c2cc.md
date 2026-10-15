# Groups.RightClick.AddSubGroup()

Groups.RightClick.AddSubGroup()

Description​

Create a sub group to the Group tree in the Group Window.

Syntax​

Groups.RightClick.AddSubGroup(...)

Ribbon: Groups » RightClick » AddSubGroup

Inputs​

crSubGroupSelected​

A Cursor specifying the master subgroup to add a sub group onto.

The default value is None.

Return Code​

A Cursor specifying the created sub group.

Sample Code​

# Prepare model
Geometry.Part.Cube()

# Create groups
Tools.Group.CreateGroup(strGroupName="Group1", crlTargets=[Face(26)])
Tools.Group.CreateGroup(strGroupName="Group2", crlTargets=[Face(24)])

# Add subgroups
created_sub_group = Groups.RightClick.AddSubGroup()
Assembly.RightClick.Rename(strNewName="SubGroup - 1", crItem=SubGroup(1))
JPT.Debugger(created_sub_group)
