# dlg.get_listbox_sels()

dlg.get_listbox_sels()

Description​

Get the indexes of the selecting ListBox options.

Syntax​

dlg.get_listbox_sels(...)

Inputs​

name​

A String specifying the name of the ListBox component.

This is a required input.

Return Code​

An IntVector specifying the indexes of the being selected ListBox options.

Sample Code​

from pyjdg import *

def onButtonClicked(dlg):
    listBoxPos=dlg.get_listbox_sels(name="ListBox2")
    dlg.set_item_text(name="TextBox4",text=str(list(listBoxPos)))

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_listbox(name="ListBox2",multisel=True,
      options=["item1","item2","item3","item4"],width=100,height=150,layout="Window")
    dlg.set_item_size_behavior(name="ListBox2",behavior=size_behavior.fixed)
    dlg.add_layout(name="Layout3",orientation=orientation.horizontal,layout="Window")
    dlg.add_textbox(name="TextBox4",width=150,height=22,layout="Layout3")
    dlg.add_button(name="Button5",text="Get Index",width=60,height=22,bk_color=15790320,layout="Layout3")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.on_command(name="Button5",callfunc=onButtonClicked)

if __name__=='__main__':
    main()
