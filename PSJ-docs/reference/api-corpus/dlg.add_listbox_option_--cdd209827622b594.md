# dlg.add_listbox_option()

dlg.add_listbox_option()

Description​

Add an option to the ListBox component.

Syntax​

dlg.add_listbox_option(...)

Inputs​

name​

A String specifying the name of the ListBox component.

This is a required input.

option_text​

A String specifying the option added.

This is a required input.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_listbox(name="ListBox3",multisel=True,
      options=["item1","item2","item3"],width=100,height=150,layout="Window")
    dlg.add_listbox_option(name="ListBox3",option_text="new_item")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()

if __name__=='__main__':
    main()
