# dlg.clear_listbox()

dlg.clear_listbox()

Description​

Clear all options of a specified ListBox.

Syntax​

dlg.clear_listbox(...)

Inputs​

name​

A String specifying the name of the ListBox component.

This is a required input.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def on_button_clicked (dlg):
    dlg.clear_listbox(name="ListBox2")
    print("All ListBox options are cleared")

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_listbox(name="ListBox2",multisel=True,
      options=["item1","item2","item3"],width=100,height=150,layout="Window")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="Button3",text="Clear ListBox",width=100,height=30,bk_color=15790320,layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.on_button_clicked(name="Button3",callfunc=on_button_clicked)

if __name__=='__main__':
    main()
