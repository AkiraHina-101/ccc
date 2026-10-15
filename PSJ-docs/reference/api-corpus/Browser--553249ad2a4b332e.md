# Browser

Browser

Create a open file/folder selection.

Preview dialog:

Parameters​

Name​

Enter name of the Open File/Folder.

Enable​

Specify whether to enable it or not.

Check On : Available

Check Off : Unavailable (grayed out)

Mode​

Specify the selection mode.

File : Only the file type can be selected.

Folder : Only the folder type can be selected.

Default​

The default (File/Folder) link to display.

Filter​

Enter the file type user can select.

Filter format:

Description 1 (Extension 1, Extension 2, ...), Description 2 (Extension 1, Extension 2, ...), ...

Allow Multiple Selection​

Choose if multiple files can be selected or not.

Check On : Allowed

Check Off : Not allowed

Visible​

Specify whether to show/hide the created Browser.

Check On : Show

Check Off : Hide

API associated with​

dlg.add_browser : Add a file/folder Browser component to the creating dialog.

dlg.on_browse : Bind a created function to a file/folder Browser component.
