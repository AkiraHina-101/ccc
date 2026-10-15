# Assembly.RightClick.Rename()

Assembly.RightClick.Rename()

Description​

Rename a specified entity.

Syntax​

Assembly.RightClick.Rename(...)

Macro: RenameItem

Ribbon: Assembly » RightClick » Rename

Inputs​

strNewName​

A String specifying the new name for item.

The default value is "New name".

crItem​

A Cursor specifying the item which name will be changed.

This is a required input.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

Geometry.Part.Cube()

rename_status = Assembly.RightClick.Rename(strNewName="Box", 
                                           crItem=Part(1))

JPT.Debugger(rename_status)
