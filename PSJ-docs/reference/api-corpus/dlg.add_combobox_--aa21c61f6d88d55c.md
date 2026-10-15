# dlg.add_combobox()

dlg.add_combobox()

Description​

Add a ComboBox component to the dialog.

Syntax​

dlg.add_combobox(...)

Inputs​

name​

A String specifying the name of the ComboBox component.

This is a required input.

layout​

A String specifying the Layout name.
The created Layout can be a GroupBox component, Layout component, etc.

This is a required input.

index​

An Integer specifying the default option to be displayed of the ComboBox.

The starting value is 0 (first option -> index=0).

This is a required input.

options​

A List of String specifying the options of the ComboBox.

The default value is [].

width​

An Integer specifying the width of the ComboBox.

The default value is 0.

height​

An Integer specifying the height of the ComboBox.

The default value is 0.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def main():
    dlg=JDGCreator(title="TechnoStar",resizable=True,validation=True)
    dlg.add_layout(name="Layout1",orientation=orientation.horizontal,layout="Window")
    dlg.add_combobox(name="ComboBox2",options=["item1","item2","item3","item4"],index=1,layout="Layout1")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()

if __name__=='__main__':
    main()
