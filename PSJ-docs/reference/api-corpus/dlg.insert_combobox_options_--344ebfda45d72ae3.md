# dlg.insert_combobox_options()

dlg.insert_combobox_options()

Description​

Insert multiple options to a specific position of the ComboBox component.

Syntax​

dlg.insert_combobox_options(...)

Inputs​

name​

A String specifying the name of the ComboBox component.

This is a required input.

position​

An Integer specifying the position in ComboBox to put the new options.

This is a required input.

options​

A List of String specifying the new options.

This is a required input.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def main():
    dlg=JDGCreator(title="TechnoStar",resizable=True,validation=True)
    dlg.add_layout(name="Layout1",margin=[0,0,100,0],orientation=orientation.horizontal,layout="Window")
    dlg.add_combobox(name="ComboBox2",options=["item1","item2","item3","item4","item5"],width=70,layout="Layout1")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.insert_combobox_options(name="ComboBox2",position=2,options=["item_New_2","item_New_1"])

if __name__=='__main__':
    main()
