# dlg.remove_listbox_option()

dlg.remove_listbox_option()

Description​

Remove a specified option in a ListBox.

Syntax​

dlg.remove_listbox_option(...)

Inputs​

name​

A String specifying the name of the ComboBox component.

This is a required input.

position​

An Integer specifying the position of option in ListBox to be removed.

This is a required input.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def on_button_clicked (dlg):
# It is possible to remove options one by one or multiple options at the same time
    options_idx=list(dlg.get_listbox_sels(name="ListBox2"))
    for idx in options_idx:
        option_name=dlg.get_listbox_option(name="ListBox2",option_index=options_idx[0])
        dlg.remove_listbox_option(name="ListBox2",position=options_idx[0])
        print("The option " + option_name + " is removed")

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_listbox(name="ListBox2",multisel=True,
      options=["item1","item2","item3"],width=100,height=150,layout="Window")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="Button3",text="Remove Option",width=100,height=30,bk_color=15790320,layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.on_button_clicked(name="Button3",callfunc=on_button_clicked)

if __name__=='__main__':
    main()
