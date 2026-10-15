# dlg.add_listbox()

dlg.add_listbox()

Description​

Add a ListBox to the creating dialog.

Syntax​

dlg.add_listbox(...)

Inputs​

name​

A String specifying the name of the created component.

This is a required input.

layout​

A String specifying the created Layout name.
The created Layout can be a GroupBox component, Layout component, etc.

This is a required input.

multisel​

A Boolean specifying the permission that allow user to select multiple values at the same time:
True: user can select multiple values.

False: user can select only one value per time.

The default value is False.

options​

A List of String specifying all the options of the ListBox component.

The default value is [].

width​

An Integer specifying the width of the ListBox.

The default value is 0.

height​

An Integer specifying the height of the ListBox.

The default value is 0.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_listbox(name="ListBox3",multisel=True,
      options=["item1","item2","item3"],width=100,height=150,layout="Window")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")

    dlg.generate_window()
if __name__=='__main__':
    main()
