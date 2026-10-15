# Groups.RightClick.AddSupGroup()

Groups.RightClick.AddSupGroup()

Description​

Create a sub group to the Group tree in the Group Window.

Syntax​

Groups.RightClick.AddSupGroup(...)

Ribbon: Groups » RightClick » AddSupGroup

Inputs​

crSupGroupSelected​

A Cursor specifying the group to add a sub group onto.

The default value is None.

Return Code​

A Cursor specifying the created sub group.

Sample Code​

created_sub_group = Groups.RightClick.AddSupGroup()

JPT.Debugger(created_sub_group)
