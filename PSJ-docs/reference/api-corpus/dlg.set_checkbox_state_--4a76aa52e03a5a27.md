# dlg.set_checkbox_state()

dlg.set_checkbox_state()

Description​

Set the state of the CheckBox to checked or unchecked.

Syntax​

dlg.set_checkbox_state(...)

Inputs​

name​

A String specifying the name of the component in which will be used for setting the state to checked/unchecked.

This is a required input.

checked​

A Boolean specifying the state of the CheckBox:
True: The initial state of the CheckBox component is checked.

False: The initial state of the CheckBox component is unchecked.

This is a required input.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def main():
    dlg=JDGCreator(title="TechnoStar",resizable=True,validation=True)
    dlg.add_layout(name="Layout1",margin=[0,0,100,0],orientation=orientation.horizontal,layout="Window")
    dlg.add_checkbox(name="CheckBox2",text="Jupiter",checked=True,layout="Layout1")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.set_checkbox_state(name="CheckBox2",checked=False)
    isChecked = dlg.isbutton_checked(name="CheckBox2")
    print(isChecked)

if __name__=='__main__':
    main()
