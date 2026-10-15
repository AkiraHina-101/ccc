# dlg.add_checkbox()

dlg.add_checkbox()

Description​

Add a CheckBox to the creating dialog.

Syntax​

dlg.add_checkbox(...)

Inputs​

name​

A String specifying the name of the created component.

This is a required input.

layout​

A String specifying the created Layout name.
The created Layout can be a GroupBox component, Layout component, etc.

This is a required input.

text​

A String specifying text which will be displayed next to the CheckBox.

The default value is "".

checked​

A Boolean specifying the default state of this component:

True: the default state of this component is checked.

False: the default state of this component is unchecked.

The default value is False.

lefttext​

A Boolean specifying the text is on left side of CheckBox:

True: the text is on left side of the CheckBox.

False: the text is on right side of the CheckBox.

The default value is False.

width​

An Integer specifying the width of the CheckBox.

The default value is 0.

height​

An Integer specifying the height of the CheckBox.

The default value is 0.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_checkbox(name="CheckBox2",text="CheckBox",lefttext=True,checked=True,layout="Window")
    dlg.add_checkbox(name="CheckBox3",text="CheckBox",lefttext=False,checked=True,layout="Window")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()

if __name__=='__main__':
    main()
