# dlg.isbutton_checked()

dlg.isbutton_checked()

Description​

Check the status of the inputted component whether it is checked or not.
Currently supporting checkbox and radio button components.

Syntax​

dlg.isbutton_checked(...)

Inputs​

name​

A String specifying the name of the component using for checking the status of selection.

This is a required input.

Return Code​

A Boolean specifying the status of the inputted component:

True: The inputted component is checked (Selected).

False: The inputted component is unchecked (Unselected).

Sample Code​

from pyjdg import *

def check_status(dlg):
    isChecked = dlg.isbutton_checked(name="CheckBox2")
    print(isChecked)

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
    dlg.on_command(name="CheckBox2",callfunc=check_status)

if __name__=='__main__':
    main()
