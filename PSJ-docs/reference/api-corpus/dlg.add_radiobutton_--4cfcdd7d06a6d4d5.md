# dlg.add_radiobutton()

dlg.add_radiobutton()

Description​

Add a RadioButton to the creating dialog.

Syntax​

dlg.add_radiobutton(...)

Inputs​

name​

A String specifying the name of the created component.

This is a required input.

layout​

A String specifying the created Layout name.
The created Layout can be a GroupBox component, Layout component, etc.

This is a required input.

text​

A String specifying text which will be displayed.

The default value is "".

width​

An Integer specifying the width of the RadioButton.

The default value is 0.

height​

An Integer specifying the height of the RadioButton.

The default value is 0.

checked​

A Boolean specifying the default state of this component:

True: the default state of this component is checked.

False: the default state of this component is unchecked.

The default value is False.

group​

A Boolean specifying the group in which this RadioButton will be added to:

True: creating RadioButton will be added separately from the previous RadioButton (different group of button). So, at the time selecting the creating RadioButton, the selected RadioButton will not be deselected.

False: creating RadioButton will be added to the same group with previous RadioButton. So, at the time selecting the creating RadioButton, the selected RadioButton will be deselected.

The default value is False.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_radiobutton(name="RadioButton16",text="RadioButton",layout="Window")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()

if __name__=='__main__':
    main()
