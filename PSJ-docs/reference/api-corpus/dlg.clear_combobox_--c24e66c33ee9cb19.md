# dlg.clear_combobox()

dlg.clear_combobox()

Description​

Clear all options of a specified ComboBox.

Syntax​

dlg.clear_combobox(...)

Inputs​

name​

A String specifying the name of the ComboBox component.

This is a required input.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def on_button_clicked (dlg):
    dlg.clear_combobox(name="ComboBox2")
    print("All ComboBox options are cleared")

def main():
    dlg=JDGCreator(title="TechnoStar",resizable=True,validation=True)
    dlg.add_layout(name="Layout1",orientation=orientation.horizontal,layout="Window")
    dlg.add_combobox(name="ComboBox2",options=["item1","item2","item3","item4"],index=1,layout="Layout1")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="Button3",text="Clear ComboBox",width=100,height=30,bk_color=15790320,layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.on_button_clicked(name="Button3",callfunc=on_button_clicked)

if __name__=='__main__':
    main()
