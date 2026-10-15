# dlg.add_space()

dlg.add_space()

Description​

Add a space between the created components.

Syntax​

dlg.add_space(...)

Inputs​

layout​

A String specifying the created Layout name.
The created Layout can be a GroupBox component, Layout component, etc.

This is a required input.

name​

A String specifying the name of the created component.

The default value is "".

orientation​

A String specifying the direction to add a space component between 2 components:

"horizontal": Add a space component on the horizontal direction.

"vertical": Add a space component on the vertical direction.

The default value is "".

size​

An Integer specifying the size of space.

The default value is 0.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_layout(name="Layout1",orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label2",text="Field 1",layout="Layout1")
    dlg.add_textbox(name="TextBox3",layout="Layout1")
    dlg.add_space(orientation="vertical",size=2,layout="Window")
    dlg.add_layout(name="Layout5",orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label6",text="Field 2",layout="Layout5")
    dlg.add_textbox(name="TextBox7",layout="Layout5")
    dlg.add_layout(name="Layout8",orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label9",text="Field 3",layout="Layout8")
    dlg.add_textbox(name="TextBox10",layout="Layout8")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()

if __name__=='__main__':
    main()
