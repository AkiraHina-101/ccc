# dlg.add_browser()

dlg.add_browser()

Description​

Add a file/folder Browser component to the creating dialog.

Syntax​

dlg.add_browser(...)

Inputs​

name​

A String specifying the name of the created component.

This is a required input.

layout​

A String specifying the created Layout name.
The created Layout can be a GroupBox component, Layout component, etc.

This is a required input.

mode​

A String specifying the Browser type:
"file": allowing user to select a file/files.

"folder": allowing user to select a folder/folders.

The default value is "file".

file_filter​

A String specifying the format of the selectable file/files with type (*.extension).
For example: All Files (*.*), Abaqus (*.inp)

The default value is "".

default​

A String specifying the default text which will be shown on the textbox of this component.

The default value is "".

multisel​

A Boolean specifying the possibility of the multiple selection:
True: allow user to select multiple files/folders at the same time.

False: allow user to select only one file/folder at a time.

The default value is False.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def main():
    dlg=JDGCreator(title="TechnoStar",resizable=True,validation=True)
    dlg.add_layout(name="Layout1",orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label3",text="Open",layout="Layout1")
    dlg.add_browser(name="Open File/Folder2",mode="file",file_filter="All Files(*.*)",
      default="C:\\temp",multisel=True,layout="Layout1")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()

if __name__=='__main__':
    main()
