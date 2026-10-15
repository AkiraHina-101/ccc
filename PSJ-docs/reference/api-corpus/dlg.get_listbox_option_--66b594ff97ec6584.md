# dlg.get_listbox_option()

dlg.get_listbox_option()

Description​

Get the string value of the being selected ListBox option.

Syntax​

dlg.get_listbox_option(...)

Inputs​

name​

A String specifying the name of the ListBox component.

This is a required input.

option_index​

A Integer specifying the order of the ListBox component's values.

This is a required input.

Return Code​

A String specifying the being selected ListBox option.

Sample Code​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_listbox(name="ListBox1",options=["item1","item2","item3","item4","item5","item6"],
        width=100,height=150,layout="Window")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    print(dlg.get_listbox_option(name="ListBox1",option_index=2))

if __name__=='__main__':
    main()
