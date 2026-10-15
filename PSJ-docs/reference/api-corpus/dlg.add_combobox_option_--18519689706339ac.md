# dlg.add_combobox_option()

dlg.add_combobox_option()

Description​

Add an option to the ComboBox component.

Syntax​

dlg.add_combobox_option(...)

Inputs​

name​

A String specifying the name of the ComboBox component.

This is a required input.

option_text​

A String specifying the option added.

This is a required input.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def main():
    dlg=JDGCreator(title="TechnoStar",resizable=True,validation=True)
    dlg.add_layout(name="Layout1",orientation=orientation.horizontal,layout="Window")
    dlg.add_combobox(name="ComboBox2",options=["item1","item2","item3","item4"],layout="Layout1")
    dlg.add_combobox_option(name="ComboBox2",option_text="new_item")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")

    dlg.generate_window()
if __name__=='__main__':
    main()
