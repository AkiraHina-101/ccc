# dlg.get_len_combobox()

dlg.get_len_combobox()

Description​

Get the size (number of items) of the ComboBox.

Syntax​

dlg.get_len_combobox(...)

Inputs​

name​

A String specifying the name of the ComboBox component.

This is a required input.

Return Code​

An Integer specifying the size of the ComboBox component.

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
    comboBoxLen=dlg.get_len_combobox(name="ComboBox2")
    print(comboBoxLen)

if __name__=='__main__':
    main()
